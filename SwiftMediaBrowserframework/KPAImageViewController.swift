//
//  KPAImageViewController.swift
//  SwiftMediaBrowser
//
//  Created by Karthik Prabhu Alagu on 27/08/15.
//  Copyright © 2015 KPAlagu. All rights reserved.
//

import UIKit
import AVFoundation

class ImageScrollView: UIScrollView
{
    var imageView:UIImageView?;
    override init(frame: CGRect) {
        super.init(frame: frame)
        let tapOnce:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "tapOnce")
        tapOnce.numberOfTapsRequired = 1;
        self.addGestureRecognizer(tapOnce);
        
        let tapTwice:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "tapTwice")
        tapTwice.numberOfTapsRequired = 2;
        self.addGestureRecognizer(tapTwice);
        
    }
    func tapOnce()
    {
        print("tappedonce");
        self.zoomScale = 1.0;
    }
    func tapTwice()
    {
        print("tappedTwice");
        self.zoomScale = 2.0;
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews()
    {
        super.layoutSubviews()
        
        // center the zoom view as it becomes smaller than the size of the screen
        let boundsSize:CGSize = self.bounds.size;
        if let imageView = imageView {
            var frameToCenter:CGRect = imageView.frame;
            
            // center horizontally
            if (frameToCenter.size.width < boundsSize.width)
            {
                frameToCenter.origin.x = (boundsSize.width - frameToCenter.size.width) / 2;
            }
            else
            {
                frameToCenter.origin.x = 0;
            }
            
            // center vertically
            if (frameToCenter.size.height < boundsSize.height)
            {
                frameToCenter.origin.y = (boundsSize.height - frameToCenter.size.height) / 2;
            }
            else
            {
                frameToCenter.origin.y = 0;
            }
            imageView.frame = frameToCenter;
        }
    }
    func setMaxMinZoomScalesForCurrentBounds() {
        
        // Reset
        self.maximumZoomScale = 1;
        self.minimumZoomScale = 1;
        self.zoomScale = 1;
        
        // Bail if no image
        if (self.imageView != nil && self.imageView!.image == nil)
        {
            return;
        }
        
        // Reset position
        self.imageView!.frame = CGRectMake(0, 0, self.imageView!.frame.size.width, self.imageView!.frame.size.height);
        
        // Sizes
        let boundsSize:CGSize = self.bounds.size;
        let imageSize:CGSize = self.imageView!.image!.size;
        
        // Calculate Min
        let xScale:CGFloat = boundsSize.width / imageSize.width;    // the scale needed to perfectly fit the image width-wise
        let yScale:CGFloat = boundsSize.height / imageSize.height;  // the scale needed to perfectly fit the image height-wise
        var minScale:CGFloat = min(xScale, yScale);                 // use minimum of these to allow the image to become fully visible
        
        // Calculate Max
        var maxScale:CGFloat = 3;
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiom.Pad) {
            // Let them go a bit bigger on a bigger screen!
            maxScale = 4;
        }
        
        // Image is smaller than screen so no zooming!
        if (xScale >= 1 && yScale >= 1) {
            minScale = 1.0;
        }
        
        // Set min/max zoom
        self.maximumZoomScale = maxScale;
        self.minimumZoomScale = minScale;
        
        // Initial zoom
        //self.zoomScale = [self initialZoomScaleWithMinScale];
        
        // If we're zooming to fill then centralise
        if (self.zoomScale != minScale) {
            
            // Centralise
            self.contentOffset = CGPointMake((imageSize.width * self.zoomScale - boundsSize.width) / 2.0,
                (imageSize.height * self.zoomScale - boundsSize.height) / 2.0);
            
        }
        
        // Disable scrolling initially until the first pinch to fix issues with swiping on an initally zoomed in photo
        self.scrollEnabled = true;
        
        
        // Layout
        self.setNeedsLayout();
        
    }
    
}
class KPAImageViewController: UIViewController,UIScrollViewDelegate {
    var imageView:UIImageView!;
    var scrollView: ImageScrollView!;
    var pageIndex : Int = 0;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil);
    }
    override func willAnimateRotationToInterfaceOrientation(toInterfaceOrientation: UIInterfaceOrientation, duration: NSTimeInterval) {
        scrollView.frame = UIScreen.mainScreen().bounds;
    }
    func initializeImageViewForZoomingWithImage(image:UIImage)
    {
        let rect = self.view.frame;
        self.view.autoresizingMask = [UIViewAutoresizing.FlexibleHeight,UIViewAutoresizing.FlexibleWidth];
        scrollView = ImageScrollView(frame: rect)
        scrollView.autoresizingMask = [UIViewAutoresizing.FlexibleHeight,UIViewAutoresizing.FlexibleWidth];
        scrollView.delegate = self
        scrollView.backgroundColor = UIColor.whiteColor();
        scrollView.alwaysBounceVertical = false
        scrollView.alwaysBounceHorizontal = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.flashScrollIndicators()
        scrollView.minimumZoomScale = 1.0
        scrollView.maximumZoomScale = 4.0
        self.view.addSubview(scrollView)
        scrollView.imageView = UIImageView(frame: CGRectZero);
        scrollView.imageView!.image = image;
        scrollView.imageView!.frame.size = CGSizeAspectFit(scrollView.imageView!.image!.size, boundingSize: rect.size);
        scrollView.contentSize = (scrollView.imageView!.frame.size);
        imageView!.layer.cornerRadius = 11.0
        imageView!.clipsToBounds = false
        scrollView.addSubview(imageView!)
       
    }

    
    func CGSizeAspectFit( aspectRatio:CGSize,var  boundingSize:CGSize) -> CGSize
    {
    let mW = boundingSize.width / aspectRatio.width;
    let mH = boundingSize.height / aspectRatio.height;
    if( mH < mW )
    {
    boundingSize.width = boundingSize.height / aspectRatio.height * aspectRatio.width;
        }
    else if( mW < mH )
    {
    boundingSize.height = boundingSize.width / aspectRatio.width * aspectRatio.height;
        }
    return boundingSize;
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder);
        
    }
    func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView? {
        return self.imageView
    }
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
    
}
