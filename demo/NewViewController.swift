//
//  NewViewController.swift
//  demo
//
//  Created by jackWang on 16/4/18.
//  Copyright © 2016年 jackWang. All rights reserved.
//

import UIKit

class NewViewController: UIViewController {

    @IBOutlet weak var bottomBackVie: UIView!
    @IBOutlet weak var replicatorBackView: UIView!
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
        backGroundView.gradientLayer(textLabel,text: "我是独角兽")
        self.replicator()
        
        self.loading()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func replicator() {
        ///
        let replicatorLayer = CAReplicatorLayer()
        replicatorLayer.bounds = CGRect(x: replicatorBackView.frame.origin.x, y: replicatorBackView.frame.origin.y, width: replicatorBackView.frame.size.width, height: replicatorBackView.frame.size.height)
        replicatorLayer.anchorPoint = CGPoint(x: 0, y: 0)
//        replicatorLayer.position = CGPoint(x:  0, y: 0)
        replicatorLayer.instanceCount = 3
        replicatorLayer.instanceTransform = CATransform3DMakeTranslation(40, 0, 0)
        replicatorLayer.instanceDelay = 0.3
//        replicatorLayer.preservesDepth = false
        replicatorLayer.masksToBounds = true
        replicatorLayer.backgroundColor = UIColor.clearColor().CGColor
        replicatorBackView.layer.addSublayer(replicatorLayer)
        
        
        let rectangle = CALayer()
        rectangle.bounds = CGRect(x: 0, y: 0, width: 30, height: 90)
        rectangle.anchorPoint = CGPoint(x: 0, y: 0)
        rectangle.position = CGPoint(x: replicatorBackView.frame.origin.x + 10, y: replicatorBackView.frame.origin.y + 110)
        rectangle.cornerRadius = 2
        rectangle.backgroundColor = UIColor.redColor().CGColor
        replicatorLayer.addSublayer(rectangle)
        
        let moveRectangle = CABasicAnimation(keyPath: "position.y")
        moveRectangle.toValue = rectangle.position.y - 70
        moveRectangle.duration = 0.7
        moveRectangle.autoreverses = true
        moveRectangle.repeatCount = HUGE
        rectangle.addAnimation(moveRectangle, forKey: nil)
    }
    
    func loading() {
        let replicatorLayer = CAReplicatorLayer()
        replicatorLayer.bounds = CGRect(x: 0, y: 0, width: bottomBackVie.frame.size.width, height: bottomBackVie.frame.size.height)
        replicatorLayer.position = CGPoint(x: bottomBackVie.frame.size.width/2, y: bottomBackVie.frame.size.height/2)
        replicatorLayer.backgroundColor = UIColor.lightGrayColor().CGColor
        replicatorLayer.instanceDelay = 1/15
        replicatorLayer.instanceCount = 15
        replicatorLayer.cornerRadius = 5
        let angle = CGFloat(2 * M_PI) / CGFloat(15)
        replicatorLayer.instanceTransform = CATransform3DMakeRotation(angle, 0, 0, 1)

        bottomBackVie.layer.addSublayer(replicatorLayer)
        
        
        let circle = CALayer()
        circle.bounds = CGRect(x: 0, y: 0, width: 15, height: 15)
        circle.position = CGPoint(x: bottomBackVie.frame.size.width/2, y: bottomBackVie.frame.size.height/2 - 55)
        circle.cornerRadius = 7.5
        circle.backgroundColor = UIColor.whiteColor().CGColor
        circle.transform = CATransform3DMakeScale(1, 1, 1)

        replicatorLayer.addSublayer(circle)
        
        
        
        let scale = CABasicAnimation(keyPath: "transform.scale")
        scale.fromValue = 1
        scale.toValue = 0.1
        scale.duration = 1
        scale.repeatCount = HUGE
        circle.addAnimation(scale, forKey: nil)
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
