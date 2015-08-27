//
//  KPAImageViewController.swift
//  SwiftMediaBrowser
//
//  Created by Karthik Prabhu Alagu on 27/08/15.
//  Copyright © 2015 KPAlagu. All rights reserved.
//

import UIKit

class KPAImageViewController: UIViewController,UIScrollViewDelegate {
    var imageView:UIImageView!;
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
        initializeImageViewForZooming();
    }
    func initializeImageViewForZooming()
    {
        let rect = UIScreen.mainScreen().bounds;
        let scrollImg: UIScrollView = UIScrollView(frame: rect)
        scrollImg.autoresizingMask = [UIViewAutoresizing.FlexibleHeight,UIViewAutoresizing.FlexibleWidth];
        scrollImg.delegate = self
        scrollImg.backgroundColor = UIColor.whiteColor();
        scrollImg.alwaysBounceVertical = false
        scrollImg.alwaysBounceHorizontal = false
        scrollImg.showsVerticalScrollIndicator = false
        scrollImg.flashScrollIndicators()
        scrollImg.minimumZoomScale = 1.0
        scrollImg.maximumZoomScale = 10.0
        self.view.addSubview(scrollImg)
        self.imageView = UIImageView(frame: scrollImg.frame);
        self.imageView.contentMode = UIViewContentMode.ScaleAspectFit;
        self.imageView.autoresizingMask = [UIViewAutoresizing.FlexibleHeight,UIViewAutoresizing.FlexibleWidth];
        imageView!.layer.cornerRadius = 11.0
        imageView!.clipsToBounds = false
        scrollImg.addSubview(imageView!)
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
