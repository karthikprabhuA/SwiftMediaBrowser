//
//  KPAImageViewController.swift
//  SwiftMediaBrowser
//
//  Created by Karthik Prabhu Alagu on 27/08/15.
//  Copyright © 2015 KPAlagu. All rights reserved.
//

import UIKit
extension UIScrollView {
    func zoomToPoint(point: CGPoint, withScale scale: CGFloat, animated: Bool) {
        var x, y, width, height: CGFloat
        
        //Normalize current content size back to content scale of 1.0f
        width = (self.contentSize.width / self.zoomScale)
        height = (self.contentSize.height / self.zoomScale)
        let contentSize = CGSize(width: width, height: height)
        
        //translate the zoom point to relative to the content rect
        x = (point.x / self.bounds.size.width) * contentSize.width
        y = (point.y / self.bounds.size.height) * contentSize.height
        let zoomPoint = CGPoint(x: x, y: y)
        
        //derive the size of the region to zoom to
        width = self.bounds.size.width / scale
        height = self.bounds.size.height / scale
        let zoomSize = CGSize(width: width, height: height)
        
        //offset the zoom rect so the actual zoom point is in the middle of the rectangle
        x = zoomPoint.x - zoomSize.width / 2.0
        y = zoomPoint.y - zoomSize.height / 2.0
        width = zoomSize.width
        height = zoomSize.height
        let zoomRect = CGRect(x: x, y: y, width: width, height: height)
        
        //apply the resize
        self.zoomToRect(zoomRect, animated: animated)
    }
}
class KPAImageViewController: UIViewController {
    var image:UIImage!;
    var scrollImg: KPAImageScrollView!;
    var pageIndex : Int = 0;
    var captionView:KPACaptionView!;

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
    override func willAnimateRotationToInterfaceOrientation(toInterfaceOrientation: UIInterfaceOrientation, duration: NSTimeInterval) {
        scrollImg.frame = UIScreen.mainScreen().bounds;
    }
    func initializeImageViewForZooming()
    {
        let rect = self.view.frame;
        self.view.autoresizingMask = [UIViewAutoresizing.FlexibleHeight,UIViewAutoresizing.FlexibleWidth];
        scrollImg = KPAImageScrollView(frame: rect)
        scrollImg.autoresizingMask = [UIViewAutoresizing.FlexibleHeight,UIViewAutoresizing.FlexibleWidth];
        scrollImg.backgroundColor = UIColor.whiteColor();
        scrollImg.alwaysBounceVertical = false
        scrollImg.alwaysBounceHorizontal = false
        scrollImg.showsVerticalScrollIndicator = false
        scrollImg.flashScrollIndicators()
        scrollImg.minimumZoomScale = 1.0;
        scrollImg.maximumZoomScale = 4.0

        self.view.addSubview(scrollImg)
        captionView = KPACaptionView(frame: CGRectMake(0,self.view.frame.height - 88,self.view.frame.width,44));
        captionView.setupCaption("Use these properties: barTintColor to get the color of the navigation bar background")
        self.view.addSubview(captionView);
        self.view.bringSubviewToFront(captionView);
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder);

    }
    func setContentImage(image:UIImage)
    {
        scrollImg.imageView.image = image;
        scrollImg.imageView.frame.size = image.size;
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
