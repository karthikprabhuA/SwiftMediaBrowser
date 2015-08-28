//
//  KPAMBPageViewController.swift
//  SwiftMediaBrowser
//
//  Created by Karthik Prabhu Alagu on 28/08/15.
//  Copyright © 2015 KPAlagu. All rights reserved.
//

import UIKit

class KPAMBPageViewController: UIPageViewController,UIPageViewControllerDataSource,UIPageViewControllerDelegate {
    
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

        // Do any additional setup after loading the view.
        let toolbar = UIToolbar();
        toolbar.frame = CGRectMake(0,self.view.frame.size.height - 44, self.view.frame.size.width, 44);
        toolbar.sizeToFit();
        
//        toolbar.setItems(items: [UIBarButtonItem]?, animated: <#T##Bool#>)
        toolbar.tintColor = UIColor.redColor();
        self.view.addSubview(toolbar);
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override init(transitionStyle style: UIPageViewControllerTransitionStyle, navigationOrientation: UIPageViewControllerNavigationOrientation, options: [String : AnyObject]?) {
        super.init(transitionStyle: style, navigationOrientation: navigationOrientation, options: options);

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
        pageContentViewController.imageView.image = UIImage(named: pageImages[index]);
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
