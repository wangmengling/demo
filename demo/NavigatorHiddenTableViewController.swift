//
//  NavigatorHiddenTableViewController.swift
//  demo
//
//  Created by apple on 16/4/20.
//  Copyright © 2016年 jackWang. All rights reserved.
//

import UIKit
import Alamofire


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
        self.automaticallyAdjustsScrollViewInsets = false
//        self.tableView.contentInset =  UIEdgeInsetsMake(-64, 0, 0, 0)
//        self.tableView.contentMode
//        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: UIBarMetrics.Default)
        
        self.getCNodeOrgTopics()
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
        return 2
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
//        self.navigationController?.navigationBarHidden = false
//        var alpha = scrollView.contentOffset.y/64
//        alpha = (alpha <= 0) ? 0 : alpha
//        alpha = (alpha >= 1) ? 1 : alpha
//        self.navigationController?.navigationBar.subviews.map({ (view) -> Void in
//            view.alpha = true ? alpha : 1
//        })
    }
    
    func getCNodeOrgTopics() -> Void {
        NetWork.request(.GET, url: "https://cnodejs.org/api/v1/topics") { (data, response, error) in
//            print(data)
//            self.jsonToModelArray(StoreModel(), json: data["data"])
            
            let array = self.jsonToModelArray(TopicsModel(), json: data.objectForKey("data")! as! Array<AnyObject>)
            print(array.count)
        }
    }
    
    @IBAction func clickAction(sender: AnyObject) {
        self.mirrorModel()
    }
    func mirrorModel() -> AnyObject? {
        return nil
    }
    
    func jsonToModelArray(model:AnyObject, json:Array<AnyObject>) -> Array<Any> {
        let jsonToModelArray = json.map { (singleJson) -> Any in
            let singleJsonModel = self.jsonToModel(model,json: singleJson)
            return singleJsonModel
        }
        return jsonToModelArray
    }
    
    func jsonToModel(model:AnyObject, json:AnyObject) -> AnyObject {
        let mirror = Mirror(reflecting: model)
        mirror.children.map { (child) -> Void in
            let value:AnyObject? = json.objectForKey(child.label!)
            model.setValue(value, forKey: child.label!)
        }
        return model
    }
}


