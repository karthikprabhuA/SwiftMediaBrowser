//
//  KPAMBPageViewController.swift
//  SwiftMediaBrowser
//
//  Created by Karthik Prabhu Alagu on 28/08/15.
//  Copyright © 2015 KPAlagu. All rights reserved.
//

import UIKit

class KPAMBPageViewController: UIPageViewController,UIPageViewControllerDataSource,UIPageViewControllerDelegate,UINavigationBarDelegate {
    var toolbar :UIToolbar!;
    
    var currentIndex : Int = 0
        {
        didSet
        {
            self.dataSource = self;
            self.delegate = self;
        }
    };
    var pageImages:Array<String>! ;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var navigationBarHeight: CGFloat? = (self.navigationController?.navigationBar.frame.height);
        if(navigationBarHeight == nil)
        {
            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiom.Phone) {
                if(UIInterfaceOrientationIsPortrait(UIInterfaceOrientation.Portrait)){
                    
                    navigationBarHeight = 44;
                }
                else {
                    navigationBarHeight = 32;
                }
            }
            else
            {
                navigationBarHeight = 44;
            }
        }
        // Do any additional setup after loading the view.
        toolbar = UIToolbar();
        toolbar.frame = CGRectMake(0,UIScreen.mainScreen().bounds.height - navigationBarHeight!, UIScreen.mainScreen().bounds.width, navigationBarHeight!);
        toolbar.autoresizingMask = [UIViewAutoresizing.FlexibleWidth, UIViewAutoresizing.FlexibleHeight];
        toolbar.sizeToFit();
        let action = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Action, target: self, action: "shareImage");
        toolbar.setItems([action], animated: false);
        self.view.addSubview(toolbar);
        
    }
    func shareImage()
    {
        
    }
    func createNavBar()
    {
        let app = UIApplication.sharedApplication();
        let height = app.statusBarFrame.size.height;
        // Create the navigation bar
        let navigationBar = UINavigationBar(frame: CGRectMake(0, height, self.view.frame.size.width, 44)) // Offset by 20 pixels vertically to take the status bar into account
        
        navigationBar.backgroundColor = UIColor.whiteColor()
        navigationBar.delegate = self;
        
        // Create a navigation item with a title
        let navigationItem = UINavigationItem()
        navigationItem.title = "Title"
        
        // Create left and right button for navigation item
        let leftButton =  UIBarButtonItem(title: "Back", style:   UIBarButtonItemStyle.Plain, target: self, action: "backButtonClicked:")
        // Create two buttons for the navigation item
        navigationItem.leftBarButtonItem = leftButton
        
        // Assign the navigation item to the navigation bar
        navigationBar.items = [navigationItem]
        
        // Make the navigation bar a subview of the current view controller
        self.view.addSubview(navigationBar)
        
    }
    
    func backButtonClicked(sender: UIBarButtonItem) {
        self.parentViewController?.navigationController?.navigationBarHidden = false;
        //        UIView.transitionWithView(self.view, duration: 0.5, options: UIViewAnimationOptions.TransitionCurlUp, animations: { () -> Void in
        //            self.view.removeFromSuperview();
        //            self.removeFromParentViewController();
        //            }, completion: nil);
        
        UIView.animateWithDuration(0.5, delay: 0.0, options: UIViewAnimationOptions.CurveEaseOut, animations: { () -> Void in
            self.view.transform = CGAffineTransformScale(self.view.transform, 0.01, 0.01);
            }) { (finished:Bool) -> Void in
                self.view.removeFromSuperview();
                self.removeFromParentViewController();
        }
        //        [UIView animateWithDuration:secs delay:0.0 options:option
        //            animations:^{
        //            self.transform = CGAffineTransformScale(self.transform, 0.01, 0.01);
        //            }
        //            completion:^(BOOL finished) {
        //            [self removeFromSuperview];
        //            }];
        
        
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated);
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillDisappear(animated: Bool) {
        if (self.navigationController?.viewControllers.indexOf(self) == nil) {
            // back button was pressed.  We know this is true because self is no longer
            // in the navigation stack.
            print("Back Button pressed.")
            //            self.parentViewController?.navigationController?.navigationBarHidden = false;
            
        }
        super.viewWillDisappear(animated);
        
    }
    
    override init(transitionStyle style: UIPageViewControllerTransitionStyle, navigationOrientation: UIPageViewControllerNavigationOrientation, options: [String : AnyObject]?) {
        super.init(transitionStyle: style, navigationOrientation: navigationOrientation, options: options);
        createNavBar();
        
    }
    override func willAnimateRotationToInterfaceOrientation(toInterfaceOrientation: UIInterfaceOrientation, duration: NSTimeInterval) {
        let navigationBarHeight: CGFloat = self.navigationController!.navigationBar.frame.height;
        toolbar.frame = CGRectMake(0,UIScreen.mainScreen().bounds.height - navigationBarHeight, UIScreen.mainScreen().bounds.width, navigationBarHeight);
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder);
    }
    func viewControllerAtIndex(index: Int) -> KPAImageViewController?
    {
        if self.pageImages.count == 0 || index >= self.pageImages.count
        {
            return nil
        }
        
        // Create a new view controller and pass suitable data.
        let pageContentViewController = KPAImageViewController(nibName: nil, bundle: nil)
        pageContentViewController.initializeImageViewForZoomingWithImage(UIImage(named: pageImages[index])!);
        pageContentViewController.pageIndex = index
        currentIndex = index
        
        return pageContentViewController
    }
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController?
    {
        var index = (viewController as! KPAImageViewController).pageIndex
        
        if (index == 0) || (index == NSNotFound) {
            return nil
        }
        
        index--
        
        return viewControllerAtIndex(index)
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController?
    {
        var index = (viewController as! KPAImageViewController).pageIndex
        
        if index == NSNotFound {
            return nil
        }
        
        index++
        
        if (index == self.pageImages.count) {
            return nil
        }
        
        return viewControllerAtIndex(index)
    }
    
    //    func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int
    //    {
    //        return self.pageImages.count
    //    }
    //    
    //    func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int
    //    {
    //        return 0
    //    }
    
}
