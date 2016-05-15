//
//  CarouselView.swift
//  demo
//
//  Created by jackWang on 16/5/15.
//  Copyright © 2016年 jackWang. All rights reserved.
//

import UIKit

class CarouselView: UIView, UIScrollViewDelegate{
//    var imageArray:Array {
//        didSet  {
//            
//        }
//    }
    
    var contentScrollView: UIScrollView!
    
    var currentImageView: UIImageView!
    var nextImageView: UIImageView!
    var preImageView:UIImageView!
    
    var pageControl:UIPageControl!
    var currentPageIndex:Int! {
        willSet(newValue) {
            self.currentPageIndex = newValue
        }
        didSet{
            self.pageControl.currentPage = self.currentPageIndex
        }
    }
    
    var timer:NSTimer!
    
    
    //MARK:- Begin
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    convenience init(frame: CGRect, imageArray: [UIImage!]?) {
        self.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        
    }
}