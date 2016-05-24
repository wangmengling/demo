//
//  HomeViewController.swift
//  demo
//
//  Created by jackWang on 16/5/21.
//  Copyright © 2016年 jackWang. All rights reserved.
//

import UIKit
import EasyPeasy

class HomeViewController: UIViewController {
    
    var caruselView:CarouselView!

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
        caruselView = CarouselView(rhs: [Left(0),Top(0),Right(0),Width(self.view.frame.width),Height(130)], imageArray: [UIImage(named: "28"),UIImage(named: "copy"),UIImage(named: "Rectangle 79"),UIImage(named: "top-back_")])
        
        self.backScrollView.addSubview(caruselView)
    }
}
