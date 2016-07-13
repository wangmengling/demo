//
//  HomeViewController.swift
//  demo
//
//  Created by jackWang on 16/5/21.
//  Copyright © 2016年 jackWang. All rights reserved.
//

import UIKit
import EasyPeasy
import RxSwift
import RxCocoa

class HomeViewController: UIViewController {
    
    var caruselView:InfiniteScrollView!
    
    var user = Variable(UserModel())

    @IBOutlet weak var backScrollView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.buildView()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
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

extension HomeViewController {
    func buildView() -> Void {
        let imageArray = ["http://photocdn.sohu.com/20160708/Img458441263.jpeg","http://img15.3lian.com/2015/f1/190/d/16.jpg"]
//        caruselView = CarouselView(rhs: [Left(0),Top(0),Right(0),Width(self.view.frame.width),Height(130)], imageArray: [UIImage(named: "28"),UIImage(named: "copy"),UIImage(named: "Rectangle 79"),UIImage(named: "top-back_")])
        
//        self.backScrollView.addSubview(caruselView)
        caruselView = InfiniteScrollView(rhs: [Top(0),Left(0),Width(self.view.frame.width),Height(130),Right(0)])
        caruselView.backgroundColor = UIColor.redColor()
        caruselView.viewTapBlocks { (object) in
            print(object)
        }
        self.backScrollView.addSubview(caruselView)
        caruselView <- [
            Top(0),
            Left(0),
            Width(self.view.frame.size.width),
            Height(130),
            Right(0)
        ]
        let time = dispatch_time(DISPATCH_TIME_NOW, Int64(1.0 * Double(NSEC_PER_SEC)))
        dispatch_after(time, dispatch_get_main_queue()) {
            self.caruselView.addIn(imageArray)
        }
    }
    
    func buildModel() -> Void {
        let json = ["Name":"wangguozhong","PassWord":"111111"]
        var userModle = UserModel()
        userModle.Name = "wang"
        userModle.PassWord = "111111"
        
        user.value = userModle
        
        self.user.asObservable().subscribeNext { (userModel) in
            print(userModle)
        }
    }
}
