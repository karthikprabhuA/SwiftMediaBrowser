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

    
}
class KPAImageViewController: UIViewController,UIScrollViewDelegate {
    var imageView:UIImageView!;
    var scrollImg: ImageScrollView!;
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
        scrollImg.frame = UIScreen.mainScreen().bounds;
    }
    func initializeImageViewForZoomingWithImage(image:UIImage)
    {
        let rect = self.view.frame;
        self.view.autoresizingMask = [UIViewAutoresizing.FlexibleHeight,UIViewAutoresizing.FlexibleWidth];
        scrollImg = ImageScrollView(frame: rect)
        scrollImg.autoresizingMask = [UIViewAutoresizing.FlexibleHeight,UIViewAutoresizing.FlexibleWidth];
        scrollImg.delegate = self
        scrollImg.backgroundColor = UIColor.whiteColor();
        scrollImg.alwaysBounceVertical = false
        scrollImg.alwaysBounceHorizontal = false
        scrollImg.showsVerticalScrollIndicator = false
        scrollImg.flashScrollIndicators()
        scrollImg.minimumZoomScale = 1.0
        scrollImg.maximumZoomScale = 4.0
        self.view.addSubview(scrollImg)
        self.imageView = UIImageView(frame: CGRectZero);
        self.imageView.image = image;
        self.imageView.frame.size = CGSizeAspectFit(self.imageView.image!.size, boundingSize: rect.size);
        scrollImg.imageView = self.imageView;
        scrollImg.contentSize = (self.imageView.frame.size);
        imageView!.layer.cornerRadius = 11.0
        imageView!.clipsToBounds = false
        scrollImg.addSubview(imageView!)
       
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
