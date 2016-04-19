//
//  SpringViewController.swift
//  demo
//
//  Created by apple on 16/4/19.
//  Copyright © 2016年 jackWang. All rights reserved.
//

import UIKit

class SpringViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var containerView: UIImageView!
    let ipadView = UIImageView(frame: CGRectMake(100, 100, 200, 151.5))

    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var image3View: UIImageView!
    @IBOutlet weak var image2View: UIImageView!
    @IBOutlet weak var lableBackView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        self.containerView.addSubview(self.ipadView)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        ipadView.image = UIImage(named: "top-back_")
        
        UIView.transitionWithView(self.imageView, duration: 1.5, options: .TransitionFlipFromBottom, animations: {
//            self.view.addSubview(self.ipadView)
        }, completion: nil)
        UIView.transitionWithView(self.image2View, duration: 1.5, options: .TransitionFlipFromBottom, animations: {
            //            self.view.addSubview(self.ipadView)
            }, completion: nil)
        
//        UIView.transitionWithView(self.label, duration: 2, options: [.CurveEaseOut, .TransitionCrossDissolve], animations: {
////            self.textContainerView.addSubview(self.textView)
//        }, completion: nil)
        
        
        
        
    }
    
    
    func delay(seconds: Double, completion:()->()) {
        let popTime = dispatch_time(DISPATCH_TIME_NOW, Int64( Double(NSEC_PER_SEC) * seconds ))
        dispatch_after(popTime, dispatch_get_main_queue()) {
            completion()
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func buttonAction(sender: AnyObject) {
//        UIView.transitionWithView(self.lableBackView, duration: 2, options: [.CurveLinear, .TransitionCrossDissolve], animations: {
//            
//            }, completion: nil)
//        UIView .transitionWithView(self.label, duration: 2, options: .AllowUserInteraction, animations: {
//            
//            }) { (true) in
//                
//        }
//        UIView.animateWithDuration(0.5, animations: {
//            self.image2View.backgroundColor = UIColor(red: 252.0/255.0, green: 155.0/255.0, blue: 65.0/255.0, alpha: 1)
//        })
        
        UIView.transitionWithView(self.label, duration: 1.5, options: [.CurveEaseOut, .TransitionFlipFromBottom], animations: {
            self.label.hidden = true
            // self.someView.hidden = false
            }, completion: nil)
        
//        UIView.animateWithDuration(1, delay: 0, options: [], animations: {
//            self.iphoneView.frame = CGRectMake(0, 0, 334, 72)
//            self.iphoneContainerView.frame = CGRectMake(26, 130, 334, 72)
//            }, completion: {
//                (flag: Bool) in
//                if flag {
//                    UIView.transitionFromView(self.iphoneContainerView, toView: self.supportIphone, duration: 0.33, options: .TransitionCrossDissolve, completion: nil)
//               	}
//        })
//        
//        UIView.animateWithDuration(1, delay: 1, options: [], animations: {
//            self.ipadView.frame = CGRectMake(0, 0, 334, 72)
//            self.ipadContainerView.frame = CGRectMake(26, 242, 334, 72)
//            }, completion: {
//                (flag: Bool) in
//                if flag {
//                    UIView.transitionFromView(self.ipadContainerView, toView: self.supportIpad, duration: 0.33, options: .TransitionCrossDissolve, completion: nil)
//                }
//        })
//        
//        UIView.animateWithDuration(1, delay: 2, options: [], animations: {
//            self.webView.frame = CGRectMake(0, 0, 334, 72)
//            self.webContainerView.frame = CGRectMake(26, 354, 334, 72)
//            }, completion: {
//                (flag: Bool) in
//                if flag {
//                    UIView.transitionFromView(self.webContainerView, toView: self.supportWeb, duration: 0.33, options: .TransitionCrossDissolve, completion: nil)
//                }
//        })
    }
}
