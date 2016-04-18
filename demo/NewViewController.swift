//
//  NewViewController.swift
//  demo
//
//  Created by jackWang on 16/4/18.
//  Copyright © 2016年 jackWang. All rights reserved.
//

import UIKit

class NewViewController: UIViewController {

    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var backGroundView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        


    }
    
    func gradientAnimate() {
        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        let gradientLayer = CAGradientLayer()
        gradientLayer.bounds = CGRect(x: 0, y: 0, width: backGroundView.frame.size.width, height: backGroundView.frame.size.height)
        gradientLayer.position = CGPoint(x: backGroundView.frame.size.width/2, y: backGroundView.frame.size.height/2)
        
        gradientLayer.startPoint = CGPoint(x: 0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1, y: 0.5)
        
        gradientLayer.colors = [
            UIColor.blackColor().CGColor,
            UIColor.whiteColor().CGColor,
            UIColor.blackColor().CGColor
        ]
        
        
        gradientLayer.locations = [0.2, 0.5, 0.8]
        
        backGroundView.layer.addSublayer(gradientLayer)
        
        let text = "textView"
        
//        textLabel.text = text
        textAnimate(text)
        gradientLayer.mask = textLabel.layer
        
        //
        let gradient = CABasicAnimation(keyPath: "locations")
        gradient.fromValue = [0, 0, 0.25]
        gradient.toValue = [0.75, 1, 1]
        gradient.duration = 2.5
        gradient.repeatCount = HUGE
        gradientLayer.addAnimation(gradient, forKey: nil)
    }
    
    
    func delay(seconds seconds: Double, completion:()->()) {
        let intervalTime = dispatch_time(DISPATCH_TIME_NOW, Int64( Double(NSEC_PER_SEC) * seconds ))
        
        dispatch_after(intervalTime, dispatch_get_main_queue(), {
            completion()
        })
    }
    
    
    func textAnimate(text: String) {
        if text.characters.count > 0 {
            textLabel.text = "\(textLabel.text!)\(text.substringToIndex(text.startIndex.successor()))"
            delay(seconds: 0.2, completion: {
                self.textAnimate(text.substringFromIndex(text.startIndex.successor()))
            })
        }
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

}
