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
        let tapOnce:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ImageScrollView.tapOnce))
        tapOnce.numberOfTapsRequired = 1;
        self.addGestureRecognizer(tapOnce);
        
        let tapTwice:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ImageScrollView.tapTwice))
        tapTwice.numberOfTapsRequired = 2;
        self.addGestureRecognizer(tapTwice);
        
    }
    @objc func tapOnce()
    {
        print("tappedonce");
        self.zoomScale = 1.0;
    }
    @objc func tapTwice()
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
        self.imageView!.frame = CGRect(x:0, y:0, width:self.imageView!.frame.size.width, height:self.imageView!.frame.size.height);
        
        // Sizes
        let boundsSize:CGSize = self.bounds.size;
        let imageSize:CGSize = self.imageView!.image!.size;
        
        // Calculate Min
        let xScale:CGFloat = boundsSize.width / imageSize.width;    // the scale needed to perfectly fit the image width-wise
        let yScale:CGFloat = boundsSize.height / imageSize.height;  // the scale needed to perfectly fit the image height-wise
        var minScale:CGFloat = min(xScale, yScale);                 // use minimum of these to allow the image to become fully visible
        
        // Calculate Max
        var maxScale:CGFloat = 3;
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiom.pad) {
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
            self.contentOffset = CGPoint(x:(imageSize.width * self.zoomScale - boundsSize.width) / 2.0,
                                         y:(imageSize.height * self.zoomScale - boundsSize.height) / 2.0);
            
        }
        
        // Disable scrolling initially until the first pinch to fix issues with swiping on an initally zoomed in photo
        self.isScrollEnabled = true;
        
        
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
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil);
    }
    override func willAnimateRotation(to toInterfaceOrientation: UIInterfaceOrientation, duration: TimeInterval) {
        scrollView.frame = UIScreen.main.bounds;
    }
    func initializeImageViewForZoomingWithImage(image:UIImage)
    {
        let rect = self.view.frame;
        self.view.autoresizingMask = [UIView.AutoresizingMask.flexibleHeight,UIView.AutoresizingMask.flexibleWidth];
        scrollView = ImageScrollView(frame: rect)
        scrollView.autoresizingMask = [UIView.AutoresizingMask.flexibleHeight,UIView.AutoresizingMask.flexibleWidth];
        scrollView.delegate = self
        scrollView.backgroundColor = UIColor.white;
        scrollView.alwaysBounceVertical = false
        scrollView.alwaysBounceHorizontal = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.flashScrollIndicators()
        scrollView.minimumZoomScale = 1.0
        scrollView.maximumZoomScale = 4.0
        self.view.addSubview(scrollView)
        imageView = UIImageView(frame: CGRect.zero);
        scrollView.imageView = imageView
        scrollView.imageView!.image = image;
        scrollView.imageView!.frame.size = CGSizeAspectFit(aspectRatio: scrollView.imageView!.image!.size, boundingSize: rect.size);
        scrollView.contentSize = (scrollView.imageView!.frame.size);
        imageView!.layer.cornerRadius = 11.0
        imageView!.clipsToBounds = false
        scrollView.addSubview(imageView!)
       
    }

    
    func CGSizeAspectFit( aspectRatio:CGSize,  boundingSize:CGSize) -> CGSize
    {
    var size = boundingSize
    let mW = size.width / aspectRatio.width;
    let mH = size.height / aspectRatio.height;
    if( mH < mW )
    {
    size.width = size.height / aspectRatio.height * aspectRatio.width;
        }
    else if( mW < mH )
    {
    size.height = size.width / aspectRatio.width * aspectRatio.height;
        }
    return size;
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
