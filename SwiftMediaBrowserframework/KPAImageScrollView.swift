//
//  KPAImageScrollView.swift
//  SwiftMediaBrowser
//
//  Created by Sathiya Karthik Prabhu on 10/09/15.
//  Copyright © 2015 KPAlagu. All rights reserved.
//

import UIKit

class KPAImageScrollView: UIScrollView,UIScrollViewDelegate {

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    var imageView:UIImageView!;
    var tapRecognizer:UITapGestureRecognizer!;
    override init(frame: CGRect) {
        super.init(frame: frame);
        self.imageView = UIImageView(frame: frame);
        self.imageView.contentMode = UIView.ContentMode.scaleAspectFit;
        self.imageView.autoresizingMask = [UIView.AutoresizingMask.flexibleHeight,UIView.AutoresizingMask.flexibleWidth];
        self.delegate = self;
        imageView!.layer.cornerRadius = 11.0
      //  imageView.backgroundColor = UIColor.redColor()
        imageView!.clipsToBounds = false
        self.addSubview(imageView!)
        
        tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(KPAImageScrollView.doubleTapDetected(tapped:)));
        tapRecognizer.numberOfTapsRequired = 2;
        self.addGestureRecognizer(tapRecognizer);
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView? {
        return self.imageView
    }
    //tag gesture
    @objc func doubleTapDetected(tapped:UITapGestureRecognizer)
    {
        if(self.zoomScale > 1.0)
        {
            //            self.scrollImg.contentOffset = CGPointMake(((self.imageView.image?.size.width)! * self.scrollImg.zoomScale - self.view.bounds.width) / 2.0,
            //                ((self.imageView.image?.size.height)! * self.scrollImg.zoomScale - self.view.bounds.height) / 2.0);
            self.setZoomScale(1.0, animated: true)
            // self.imageView.frame = self.view.frame;
        }
        else
        {
            
            //            let scale:CGFloat = 3;
            //
            //            var zoomPoint:CGPoint = tapped.locationInView(self.scrollImg);
            //            //translate the zoom point to relative to the content rect
            //            zoomPoint.x = (self.imageView.frame.size.width - self.imageView.image!.size.width);
            //            zoomPoint.y = (self.imageView.frame.size.height - self.imageView.image!.size.height);
            //
            //
            //            // The zoom rect is in the content view's coordinates.
            //            // At a zoom scale of 1.0, it would be the size of the
            //            // imageScrollView's bounds.
            //            // As the zoom scale decreases, so more content is visible,
            //            // the size of the rect grows.
            //            var zoomRect:CGRect = CGRectZero;
            //            zoomRect.size.height = self.scrollImg.bounds.size.height / scale;
            //            zoomRect.size.width  = self.scrollImg.bounds.size.width / scale;
            //
            //            //let point = tapped.locationOfTouch(0, inView: self.view)
            //            // choose an origin so as to get the right center.
            //            zoomRect.origin.x = 0;
            //            zoomRect.origin.y = 0;
            //            self.imageView.frame = CGRectMake(0, 0,  self.imageView.image!.size.width,  self.imageView.image!.size.height)
            
            // self.scrollImg.zoomToRect(zoomRect, animated: true);
            self.setZoomScale(4.0, animated: true)
            
            
        }
    }
    override func layoutSubviews()
    {
    super.layoutSubviews()
    
    // center the zoom view as it becomes smaller than the size of the screen
        let boundsSize:CGSize = self.bounds.size;
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
