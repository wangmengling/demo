//
//  NavigatorHiddenTableViewController.swift
//  demo
//
//  Created by apple on 16/4/20.
//  Copyright © 2016年 jackWang. All rights reserved.
//

import UIKit

class NavigatorHiddenTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
//        self.title = "我的公司"
//        self.navigationItem.prompt="这是什么？"
        self.navigationController?.navigationItem.prompt = "sfasdf"
        self.navigationItem.title = "sfdaadfasdf"
        self.navigationController?.navigationBarHidden = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 20
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath)

        // Configure the cell...

        return cell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension NavigatorHiddenTableViewController {
    
    override func scrollViewDidScroll(scrollView: UIScrollView) {
//        if ([self getScrollerView]){
//            
//            UIScrollView * scrollerView = [self getScrollerView];
//            alpha =  scrollerView.contentOffset.y/self.scrolOffsetY;
//        }else{
//            return;
//        }
//        alpha = (alpha <= 0)?0:alpha;
//        alpha = (alpha >= 1)?1:alpha;
//        
//        //设置导航条上的标签是否跟着透明
//        self.navigationItem.leftBarButtonItem.customView.alpha = self.isLeftAlpha?alpha:1;
//        self.navigationItem.titleView.alpha = self.isTitleAlpha?alpha:1;
//        self.navigationItem.rightBarButtonItem.customView.alpha = self.isRightAlpha?alpha:1;
//        
//        [[[self.navigationController.navigationBar subviews]objectAtIndex:0] setAlpha:alpha];
        self.navigationController?.navigationBarHidden = false
        var alpha = scrollView.contentOffset.y/64
        alpha = (alpha <= 0) ? 0 : alpha
        alpha = (alpha >= 1) ? 1 : alpha
        
        self.navigationItem.leftBarButtonItem?.customView?.alpha = true ? alpha : 1
        self.navigationItem.titleView?.alpha = 0.1
        self.navigationItem.rightBarButtonItem?.customView?.alpha = true ? alpha : 1
        self.navigationController?.navigationBar.subviews[0].alpha = true ? alpha : 1
        let nv = self.navigationController?.navigationBar.subviews
        print(nv)
        let nvc = self.navigationController?.navigationBar
        print(nvc)
        let s = self.navigationItem.backBarButtonItem
        let d = self.navigationController?.navigationItem.backBarButtonItem
        let sdf = self.navigationController?.navigationBar
        print(sdf)
        if s === d {
            print("asdfasdf")
        }
//        self.navigationItem.te
    }
    
    func navigation()  {
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: UIBarMetrics.Default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.tableView.contentOffset = CGPointMake(0, self.tableView.contentOffset.y - 1);
        self.tableView.contentOffset = CGPointMake(0, self.tableView.contentOffset.y + 1);
    }
}
