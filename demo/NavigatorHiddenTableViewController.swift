//
//  NavigatorHiddenTableViewController.swift
//  demo
//
//  Created by apple on 16/4/20.
//  Copyright © 2016年 jackWang. All rights reserved.
//

import UIKit
import Alamofire
import ObjectMapper
import RxSwift
import RealmSwift


class NavigatorHiddenTableViewController: UITableViewController {
    var topicModelArray:Array<TopicModel> = Array<TopicModel>()
    
    @IBOutlet weak var imageView: UIImageView!
    let d = Variable(TopicssModel())
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        self.title = "我的公司"
        self.navigationController?.navigationItem.prompt = "sfasdf"
        self.navigationItem.title = "sfdaadfasdf"
        self.navigationController?.navigationBarHidden = true
        self.automaticallyAdjustsScrollViewInsets = false
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 114
        self.getCNodeOrgTopics()
        
//        let url = NSURL(string: "http://gtb.baidu.com/HttpService/get?p=dHlwZT1pbWFnZS9qcGVnJm49dmlzJnQ9YWRpbWcmYz10YjppZyZyPTQ5NzI4NDUwNCwzNjU5MjAxODMy")
//        self.imageView.set_MLImageWithURL(url!)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        let url = NSURL(string: "//gravatar.com/avatar/75667f52de5dbe27f5d037d7121bc178?size=48")
        self.imageView.set_MLImageWithURL(url!)
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.topicModelArray.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("NavigatorHiddenTableViewCell", forIndexPath: indexPath) as! NavigatorHiddenTableViewCell

        // Configure the cell...
//        print(self.topicModelArray[indexPath.row] as? TopicsModel)
        cell.topicsModel = self.topicModelArray[indexPath.row] as? TopicsModel
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
            
//            self.topicModelArray = JsonModel().jsonToModelArray(TopicsModel.self, json: data.objectForKey("data")! as! Array<AnyObject>)
//            self.topicModelArray = array as! Array<TopicsModel>
//            self.jsonToModelArray(TopicsModel.self, json: data.objectForKey("data")! as! Array<AnyObject>)
//            self.topicModelArray = Mapper<TopicModel>().mapArray(data.objectForKey("data"))!
            
            
//            let dds = Mapper().toJSONArray(self.topicModelArray)
            
            let topicsssModelArray = DataConversion<TopicsssModel>().mapArray(data.objectForKey("data"))!
            var topic = topicsssModelArray.first! as TopicsssModel
//            Storage().add(topicsssModelArray)
            var store = Storage<TopicsssModel>()
            store.add(topic, update: true)
//            Storage().add(topic)
//            var storage = Storage<TopicsssModel>()
//            storage.addArray(topicsssModelArray)
//            let array = Storage<TopicsssModel>().objects()
//            print(array)
//            print(topicsssModelArray)
//            let datas = data.objectForKey("data")
//            let d = DataConversion(TopicModel()).mapArray(data)
//            self.tableView.reloadData()
        }
    }
    
    @IBAction func clickAction(sender: AnyObject) {
//        self.getCNodeOrgTopics()
        // 使用的方法和常规 Swift 对象的使用方法类似
        let myDog = Dog()
        myDog.name = "大黄"
        myDog.age = 1
        print(" 狗狗的名字： \(myDog.name)")
        
        // 获取默认的 Realm 数据库
        let realm = try! Realm()
        
        // 检索 Realm 数据库，找到小于 2 岁 的所有狗狗
        let puppies = realm.objects(Dog).filter("age < 2")
        puppies.count // => 0 因为目前还没有任何狗狗被添加到了 Realm 数据库中
        
        // 数据持久化操作十分简单
        try! realm.write {
            realm.add(myDog)
        }
        
        // 检索结果会实时更新
        puppies.count // => 1
        
        // 可以在任何一个线程中执行检索操作
        dispatch_async(dispatch_queue_create("background", nil)) {
            let realm = try! Realm()
            let theDog = realm.objects(Dog).filter("age == 1").first
            try! realm.write {
                theDog!.age = 3
            }
        }
    }
    
}

class Dog: Object {
    dynamic var name = ""
    dynamic var age = 0
}
class Person: Object {
    dynamic var name = ""
    dynamic var picture: NSData? = nil // 支持可选值
    let dogs = List<Dog>()
}

struct Cat:StorageProtocol {
    var name:String?
    var age:Int?
}




