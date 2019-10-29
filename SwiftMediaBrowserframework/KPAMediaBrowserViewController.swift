//
//  KPAMediaBrowserViewController.swift
//  SwiftMediaBrowser
//
//  Created by Karthik Prabhu Alagu on 25/08/15.
//  Copyright © 2015 KPAlagu. All rights reserved.
//

import UIKit
protocol KPAMediaBrowserCollectionViewDelegate
{
    
}
class KPAMediaBrowserViewController: UIViewController,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout{
   

    var delegate:KPAMediaBrowserCollectionViewDelegate?;
    var dataSourceImages:Array<String>!;
    var collectionView:UICollectionView?;
    //var layoutSectionInsets:UIEdgeInsets?;  //user can  set the layout SectionInsets
    //var layoutItemSize:CGSize?;  //user can  set the layout ItemSize
    var margin, gutter, marginL, gutterL, columns, columnsL:CGFloat!;
    var numberOfSections = 1; //current implementation is for one sections
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

     init(delegate: KPAMediaBrowserCollectionViewDelegate)
    {
        super.init(nibName: nil, bundle: nil)
        self.delegate = delegate;
        // Defaults
        columns = 3; columnsL = 4;
        margin = 0; gutter = 1;
        marginL = 0;  gutterL = 1;
        
        // For pixel perfection...
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiom.pad) {
            // iPad
            columns = 6; columnsL = 8;
            margin = 1 ; gutter = 2;
            marginL = 1; gutterL = 2;
        } else if (UIScreen.main.bounds.size.height == 480) {
            // iPhone 3.5 inch
            columns = 3; columnsL = 4;
            margin = 0; gutter = 1;
            marginL = 1; gutterL = 2;
        } else {
            // iPhone 4 inch
            columns = 3; columnsL = 5;
            margin = 0; gutter = 1;
            marginL = 0; gutterL = 2;
        }
        initializeViewLayout();

        
    }
    func initializeViewLayout()
    {
    let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout();
    //        let margin = self.getMargin();
    //        layout.sectionInset = UIEdgeInsets(top: margin, left: margin, bottom: margin, right: margin)
    //        layout.itemSize = self.calculatedLayoutItemSize();
    if(self.collectionView == nil)
    {
    self.collectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        self.collectionView?.autoresizingMask = [UIView.AutoresizingMask.flexibleHeight,UIView.AutoresizingMask.flexibleWidth];
    }
        
    self.collectionView!.dataSource = self
    self.collectionView!.delegate = self
        self.collectionView!.register(KPAMediaBrowserCollectionViewCell.classForCoder(), forCellWithReuseIdentifier: "MediaBrowserCellIdentifier")
        self.collectionView!.backgroundColor = UIColor.white
    self.view.addSubview(collectionView!)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false;
        if(self.collectionView != nil)
        {
            self.collectionView?.reloadData();
        }
        super.viewWillAppear(animated);
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func performLayout() {
    if let navBar = self.navigationController?.navigationBar
    {
        self.collectionView!.contentInset = UIEdgeInsets(top: navBar.frame.origin.y + navBar.frame.size.height + self.getGutter(), left: 0, bottom: 0, right: 0);
        }
    }
    override func willAnimateRotation(to toInterfaceOrientation: UIInterfaceOrientation, duration: TimeInterval) {
        self.collectionView!.reloadData();
        //let numberFormatter = NSNumberFormatter()
        //let number = numberFormatter.numberFromString(UIDevice.currentDevice().systemVersion)?.floatValue
        //if(number < 7)
        // {
        //self.performLayout(); // needed for iOS 5 & 6
      //  }
    }
    /*
    layout properties
    */
    func getColumns()->CGFloat
    {
        if(UIInterfaceOrientation.portrait.isPortrait)
    {
    return columns;
    }
   else {
    return columnsL;
    }
    }
    
    func getMargin() -> CGFloat {
        if(UIInterfaceOrientation.portrait.isPortrait){
    return margin;
    } else {
    return marginL;
    }
    }
    
    func getGutter() -> CGFloat {
        if(UIInterfaceOrientation.portrait.isPortrait){
    return gutter;
    } else {
    return gutterL;
    }
    }
    
    func calculatedLayoutItemSize() -> CGSize
    {
        let margin = Float(self.getMargin());
        let gutter = Float(self.getGutter());
        let columns = Float(self.getColumns());
    let value = floorf(((Float(self.view!.bounds.size.width) - (columns - 1.0 * gutter - 2.0 * margin)) / columns));
        return CGSize(width:CGFloat(value), height:CGFloat(value));
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    /*
    Collectionview delegate
    */
     func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return numberOfSections;
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        print("selected row\(indexPath.row)")
        let pageViewController = KPAMBPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        pageViewController.view.frame = self.collectionView!.frame;
        pageViewController.pageImages = dataSourceImages;
        pageViewController.currentIndex = indexPath.row;
        let startingViewController: KPAImageViewController = pageViewController.viewControllerAtIndex(index: indexPath.row)!
        let viewControllers: NSArray = [startingViewController]
        pageViewController.setViewControllers(viewControllers as? [UIViewController], direction:UIPageViewController.NavigationDirection.forward, animated: true, completion: nil)
        self.navigationController?.isNavigationBarHidden = true;

        UIView.transition(with: self.view, duration: 0.5, options: UIView.AnimationOptions.transitionCrossDissolve, animations: { () -> Void in
            self.addChild(pageViewController)
            self.view.addSubview(pageViewController.view)
            pageViewController.didMove(toParent: self)
            }, completion: nil);
    
    }
    /*
    Collectionview data source
    */
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (dataSourceImages?.count)!;
    }
    
     func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:KPAMediaBrowserCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "MediaBrowserCellIdentifier", for: indexPath) as! KPAMediaBrowserCollectionViewCell;
        let image = dataSourceImages[indexPath.row] ;
        cell.imageView.image = UIImage(named:image);
                return cell;
    }
    
    /*
    FlowLayout delegate
    */
    func collectionView(_ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        insetForSectionAt section: Int) -> UIEdgeInsets
    {
        let margin = self.getMargin();
        return UIEdgeInsets(top: margin, left: margin, bottom: margin, right: margin);
    }
    func collectionView(_ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumLineSpacingForSectionAt section: Int) -> CGFloat
    {
        return self.getGutter();
    }
    func collectionView(_ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat
    {
        return self.getGutter();
    }
func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        return calculatedLayoutItemSize();
    }
}
