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
class KPAMediaBrowserViewController: UIViewController,UICollectionViewDataSource,UICollectionViewDelegate{

    var delegate:KPAMediaBrowserCollectionViewDelegate?;
    var dataSourceImages:[String]!;
    var collectionView:UICollectionView?;
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

     init(delegate: KPAMediaBrowserCollectionViewDelegate)
    {
        super.init(nibName: nil, bundle: nil)
        self.delegate = delegate;
        
        
    }
 
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        let screenHeight = UIScreen.mainScreen().bounds.size.height;
        let nativeScale = UIScreen.mainScreen().nativeScale;
         if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiom.Pad) {
            layout.sectionInset = UIEdgeInsets(top: 20, left: 10, bottom: 10, right: 10)
            layout.itemSize = CGSize(width: 90, height: 72)
        }
        else if (screenHeight == 480) //3.5inch screen
         {
         }
        else if(screenHeight == 568)//iPhone5 5S
         {
         }
        else if (nativeScale == 3.0) //iphone 6Plus
         {
         }
        else if(screenHeight >= 480 && nativeScale == 2.0) //iphone6
         {
            layout.sectionInset = UIEdgeInsets(top: 20, left: 10, bottom: 10, right: 10)
            layout.itemSize = CGSize(width: 100, height: 100)
         }
        
        self.collectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
         self.collectionView!.dataSource = self
         self.collectionView!.delegate = self
        
         self.collectionView!.registerClass(KPAMediaBrowserCollectionViewCell.classForCoder(), forCellWithReuseIdentifier: "MediaBrowserCellIdentifier")
         self.collectionView!.backgroundColor = UIColor.whiteColor()
        self.view.addSubview(collectionView!)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
     func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1;
    }

    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath)
    {
        print("selected row\(indexPath.row)")
    }
     func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (dataSourceImages?.count)!;
    }
    
     func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell:KPAMediaBrowserCollectionViewCell = collectionView.dequeueReusableCellWithReuseIdentifier("MediaBrowserCellIdentifier", forIndexPath: indexPath) as! KPAMediaBrowserCollectionViewCell;
        let image = dataSourceImages[indexPath.row] ;
        cell.imageView.image = UIImage(named:image);
                return cell;
    }
    
}
