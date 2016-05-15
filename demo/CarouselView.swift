//
//  CarouselView.swift
//  demo
//
//  Created by jackWang on 16/5/15.
//  Copyright © 2016年 jackWang. All rights reserved.
//

import UIKit

let timeInterval:NSTimeInterval = 2

class CarouselView: UIView, UIScrollViewDelegate{
    
    var imageArray:Array! {
        willSet(newValue) {
            self.imageArray = newValue
        }
        didSet  {
            
        }
    }
    
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
        self.imageArray = imageArray
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func buildView(frame:CGRect) -> Void {
        
        
        
        contentScrollView = UIScrollView(frame: frame)
        contentScrollView.pagingEnabled = true
        self.addSubview(contentScrollView)
        
        
        pageControl = UIPageControl(frame: frame)
        self.addSubview(pageControl)
        
        
        currentImageView = UIImageView()
        self.addSubview(currentImageView)
        preImageView = UIImageView()
        self.addSubview(preImageView)
        nextImageView = UIImageView()
        self.addSubview(nextImageView)
        
        
        timer = NSTimer(timeInterval: timeInterval, target: self, selector: #selector(CarouselView.carouseAction), userInfo: nil, repeats: true)
    }
    
    func carouseAction() -> Void {
        self.currentPageIndex = self.currentPageIndex + 1
        self.contentScrollView.contentOffset = CGPoint(x: CGFloat(self.currentPageIndex)  * self.frame.size.width, y: 0)
    }
    
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        
    }
}