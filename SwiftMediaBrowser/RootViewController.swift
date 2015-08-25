//
//  RootViewController.swift
//  SwiftMediaBrowser
//
//  Created by Karthik Prabhu Alagu on 24/08/15.
//  Copyright © 2015 KPAlagu. All rights reserved.
//

import UIKit

class RootViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,KPAMediaBrowserCollectionViewDelegate {

    var  numberOfRows:Int = 3;
    var recipeImages:[String]!;
    @IBOutlet weak var tableView: UITableView!
    var segmentedControl:UISegmentedControl!;
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        segmentedControl = UISegmentedControl(items: ["Push","Modal"]);
        segmentedControl.selectedSegmentIndex = 0;
        segmentedControl.addTarget(self, action: "segmentChange", forControlEvents: UIControlEvents.ValueChanged);
        let item = UIBarButtonItem(customView: segmentedControl);
        self.navigationItem.rightBarButtonItem = item;
        self.tableView.registerClass(UITableViewCell.classForCoder(), forCellReuseIdentifier: "TitleCellIdentifier")
        recipeImages = ["angry_birds_cake.jpg","creme_brelee.jpg","egg_benedict.jpg", "full_breakfast.jpg", "green_tea.jpg", "ham_and_cheese_panini.jpg", "ham_and_egg_sandwich.jpg", "hamburger.jpg", "instant_noodle_with_egg.jpg", "japanese_noodle_with_pork.jpg", "mushroom_risotto.jpg", "noodle_with_bbq_pork.jpg", "starbucks_coffee.jpg", "thai_shrimp_cake.jpg", "vegetable_curry.jpg", "white_chocolate_donut.jpg"];
    }
    

    func segmentChange()
    {
        self.tableView.reloadData();
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
/*
    UITableViewDelegate
*/
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        switch(indexPath.row)
        {
            
        default:
            if(self.segmentedControl.selectedSegmentIndex == 0)
            {
                let mediaBrowser =  KPAMediaBrowserViewController(delegate: self);
                mediaBrowser.dataSourceImages = recipeImages;
                self.navigationController?.pushViewController(mediaBrowser, animated: true);
            }
            else
            {
                let mediaBrowser =  KPAMediaBrowserViewController(delegate: self);
                mediaBrowser.dataSourceImages = recipeImages;
                self.presentViewController(mediaBrowser, animated: true, completion: nil);
                
            }
            break;
        }
    }
/*
    UITableViewDataSource
*/
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return numberOfRows;
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCellWithIdentifier("TitleCellIdentifier", forIndexPath: indexPath)
  
        switch(indexPath.row)
        {
        case 0:
            cell.textLabel?.text = "GridView";
        case 1:
            cell.textLabel?.text = "GridView With Selection";
        case 2:
           cell.textLabel?.text = "Web Photos GridView";
        default:
            break;
        }
     
        
        return cell;
    }
}
