//
//  HJBanner.swift
//  BannerDemo
//
//  Created by 士伟 on 17/3/17.
//  Copyright © 2017年 shiweiluan. All rights reserved.
//

import UIKit
import Kingfisher

/** 滚动图宽度 */
fileprivate var hjBannerViewWidth : CGFloat? = nil
/** 滚动图高度 */
fileprivate var hjBannerViewHeight : CGFloat? = nil
/** 滚动的UIScrollView */
fileprivate var scroll : UIScrollView? = nil
/** 图片的url数组 */
fileprivate var imageURLArray = [AnyObject]()
/** 定时器 */
fileprivate var timer : Timer? = nil
/** 当前显示的图片在数组中的下标 */
fileprivate var bannerIndex : NSInteger = 0
/** 左边的图片在数组中的下标 */
fileprivate var leftBannerIndex : NSInteger = 0
/** 右边的图片在数组中的下标 */
fileprivate var rightBannerIndex : NSInteger = 0
/** 左边的图片 */
fileprivate var leftImageView : UIImageView? = nil
/** 中间的图片 */
fileprivate var centerImageView : UIImageView? = nil
/** 右边的图片 */
fileprivate var rightImageView : UIImageView? = nil
/** 间隔时间 */
fileprivate var timeInterval : CGFloat = 3.0
/** 白点 */
fileprivate var pageControl : UIPageControl? = nil

class HJBannerView: UIView, UIScrollViewDelegate {
    
    weak var delegate: HJBannerViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    convenience init(width: CGFloat, height: CGFloat) {
        self.init()
        hjBannerViewWidth = width
        hjBannerViewHeight = height
        self.backgroundColor = UIColor.white
        
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /**
     *  图片url数组
     */
    var imageURLs: Array<Any>? {
        set {
            imageURLArray = newValue! as [AnyObject]
            creatHJBannerView()
        }
        get {
            return imageURLArray
        }
    }
    /**
     *  创建滚动视图
     */
    fileprivate func creatHJBannerView () {
        /** 图片数组不为空 */
        if imageURLArray.count != 0 {
            scroll?.removeFromSuperview()
            self.addSubview(scroll!)
            scroll?.delegate = self
            scroll?.snp.makeConstraints({ (make) in
                make.left.equalTo(self).offset(0)
                make.right.equalTo(self).offset(0)
                make.top.equalTo(self).offset(0)
                make.bottom.equalTo(self).offset(0)
            })
            bannerIndex = 0
            /** 只有一张图片 */
            if imageURLArray.count == 1 {
                /** 创建只有一张图的轮播图 */
                creatOneImage()
            }
            else {
                /** 创建有多张图片的轮播图 */
                creatMoreImage()
            }
            pageControl?.removeFromSuperview()
            pageControl = UIPageControl()
            pageControl?.numberOfPages = imageURLArray.count
            pageControl?.currentPage = bannerIndex;
            pageControl?.hidesForSinglePage = true
            pageControl?.pageIndicatorTintColor = UIColor.white
            pageControl?.currentPageIndicatorTintColor = UIColor.red
            self.addSubview(pageControl!)
            pageControl?.snp.makeConstraints({ (make) in
                make.left.equalTo(self.snp.left).offset(0)
                make.right.equalTo(self.snp.right).offset(0)
                make.bottom.equalTo(self.snp.bottom).offset(0)
                make.height.equalTo(20)
            })
            creatTimer()
            creatTap()
        }
    }
    /**
     *  创建有多张图片的轮播图
     */
    fileprivate func creatMoreImage() {
        /** 设置滚动范围 */
        scroll?.contentSize = CGSize(width: hjBannerViewWidth! * 3, height: 0)
        bannerIndex = 0
        leftBannerIndex = imageURLArray.count - 1
        rightBannerIndex = bannerIndex + 1
        
        leftImageView = UIImageView()
        leftImageView?.kf.setImage(with: URL(string: imageURLArray[leftBannerIndex] as! String))
        leftImageView?.contentMode = .scaleToFill
        scroll?.addSubview(leftImageView!)
        leftImageView?.backgroundColor = UIColor.magenta
        leftImageView?.snp.makeConstraints({ (make) in
            make.left.equalTo(scroll!.snp.left).offset(0)
            make.width.equalTo(hjBannerViewWidth!)
            make.top.equalTo(scroll!.snp.top).offset(0)
            make.height.equalTo(hjBannerViewHeight!)
        })
        
        centerImageView = UIImageView()
        centerImageView?.kf.setImage(with: URL(string: imageURLArray[bannerIndex] as! String))
        centerImageView?.contentMode = .scaleToFill
        scroll?.addSubview(centerImageView!)
        centerImageView?.backgroundColor = UIColor.magenta
        centerImageView?.snp.makeConstraints({ (make) in
            make.left.equalTo(leftImageView!.snp.right).offset(0)
            make.width.equalTo(hjBannerViewWidth!)
            make.top.equalTo(scroll!.snp.top).offset(0)
            make.height.equalTo(hjBannerViewHeight!)
        })
        rightImageView = UIImageView()
        rightImageView?.kf.setImage(with: URL(string: imageURLArray[rightBannerIndex] as! String))
        rightImageView?.contentMode = .scaleToFill
        scroll?.addSubview(rightImageView!)
        rightImageView?.backgroundColor = UIColor.magenta
        rightImageView?.snp.makeConstraints({ (make) in
            make.left.equalTo(centerImageView!.snp.right).offset(0)
            make.width.equalTo(hjBannerViewWidth!)
            make.top.equalTo(scroll!.snp.top).offset(0)
            make.height.equalTo(hjBannerViewHeight!)
        })
        
        /** 设置当前显示位置 */
        scroll?.setContentOffset(CGPoint(x: hjBannerViewWidth!, y: 0), animated: false)
        
    }
    
    /**
     *  创建只有一张图的轮播图
     */
    fileprivate func creatOneImage() {
        scroll?.contentSize = CGSize(width: 0, height: 0)
        centerImageView = UIImageView()
        let url = URL(string: imageURLArray[0] as! String)
        centerImageView?.kf.setImage(with: url)
        centerImageView?.contentMode = .scaleToFill
        scroll?.addSubview(centerImageView!)
        centerImageView?.backgroundColor = UIColor.magenta
        centerImageView?.snp.makeConstraints({ (make) in
            make.left.equalTo(scroll!.snp.left).offset(0)
            make.width.equalTo(hjBannerViewWidth!)
            make.top.equalTo(scroll!.snp.top).offset(0)
            make.height.equalTo(hjBannerViewHeight!)
        })
    }
    
    /**
     *  点击图片事件
     */
    @objc fileprivate func clickScroll() -> Void {
        if imageURLArray.count != 0 {
            if delegate != nil {
                delegate!.didSelectHJBannerView(index: bannerIndex)
            }
            
        }
    }
    /**
     *  创建手势点击
     */
    fileprivate func creatTap() {
        let tap = UITapGestureRecognizer()
        tap.addTarget(self, action: #selector(clickScroll))
        scroll?.addGestureRecognizer(tap)
    }
    
    /**
     *  创建定时器
     */
    fileprivate func creatTimer() -> Void {
        timer?.invalidate()
        timer = nil
        if (timer == nil && imageURLArray.count > 1) {
            timer = Timer.scheduledTimer(timeInterval: TimeInterval(timeInterval), target: self, selector: #selector(timeAction), userInfo: nil, repeats: true)
        }
    }
    /**
     *  定时器事件
     */
    @objc fileprivate func timeAction() -> Void {
        scroll?.setContentOffset(CGPoint(x:hjBannerViewWidth! * 2, y:0), animated: true)
    }
    
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        bannerIndex = bannerIndex + 1
        leftBannerIndex = bannerIndex - 1
        rightBannerIndex = bannerIndex + 1
        
        if bannerIndex == imageURLArray.count - 1 {
            rightBannerIndex = 0
        }
        if bannerIndex == imageURLArray.count {
            bannerIndex = 0
            leftBannerIndex = imageURLArray.count - 1
            rightBannerIndex = bannerIndex + 1
        }
        
//        print("left:\(leftBannerIndex) center:\(cycleIndex) right:\(rightBannerIndex)")
        
        leftImageView?.kf.setImage(with: URL(string: imageURLArray[leftBannerIndex] as! String))
        centerImageView?.kf.setImage(with: URL(string: imageURLArray[bannerIndex] as! String))
        rightImageView?.kf.setImage(with: URL(string: imageURLArray[rightBannerIndex] as! String))
        scroll?.setContentOffset(CGPoint(x:hjBannerViewWidth! * 1, y:0), animated: false)
        pageControl?.currentPage = bannerIndex;
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        hjBannerViewPause()
        
    }
    /**
     *  用户拖动图片后处理
     */
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
//        print(scroll!.contentOffset.x / hjBannerViewWidth!)
        if scroll!.contentOffset.x / hjBannerViewWidth! == 0.0 {
            bannerIndex = bannerIndex - 1
            leftBannerIndex = bannerIndex - 1
            rightBannerIndex = bannerIndex + 1
            
            
        } else if scroll!.contentOffset.x / hjBannerViewWidth! == 1.0 {
            
        } else if scroll!.contentOffset.x / hjBannerViewWidth! == 2.0 {
            bannerIndex = bannerIndex + 1
            leftBannerIndex = bannerIndex - 1
            rightBannerIndex = bannerIndex + 1
        } else {}
        
        if bannerIndex == imageURLArray.count - 1 {
            rightBannerIndex = 0
        }
        if bannerIndex == imageURLArray.count || bannerIndex == 0{
            bannerIndex = 0
            leftBannerIndex = imageURLArray.count - 1
            rightBannerIndex = bannerIndex + 1
        }
        if bannerIndex == -1 {
            bannerIndex = imageURLArray.count - 1
            leftBannerIndex = bannerIndex - 1
            rightBannerIndex = 0
        }
        
        leftImageView?.kf.setImage(with: URL(string: imageURLArray[leftBannerIndex] as! String))
        centerImageView?.kf.setImage(with: URL(string: imageURLArray[bannerIndex] as! String))
        rightImageView?.kf.setImage(with: URL(string: imageURLArray[rightBannerIndex] as! String))
        scroll?.setContentOffset(CGPoint(x:hjBannerViewWidth! * 1, y:0), animated: false)
        pageControl?.currentPage = bannerIndex;
        hjBannerViewStart()
    }

    /**
     *  定时器暂停
     */
    func hjBannerViewPause() -> Void {
        if (timer != nil) {
            timer?.fireDate = Date.distantFuture
        }
    }
    /**
     *  定时器开始
     */
    func hjBannerViewStart() -> Void {
        if (timer != nil) {
            timer?.fireDate = NSDate(timeIntervalSinceNow: TimeInterval(timeInterval)) as Date
        }
    }
    
    //MARK: - lazy
    /**
     *  scrollView
     */
    fileprivate lazy var scroll: UIScrollView? = {
        let scro = UIScrollView()
        scro.backgroundColor = UIColor.black
        scro.bounces = false
        scro.isPagingEnabled = true
        scro.layer.masksToBounds = true
        scro.alwaysBounceVertical = false
        scro.alwaysBounceHorizontal = true
        scro.showsVerticalScrollIndicator = false
        scro.showsHorizontalScrollIndicator = false
        return scro
    }()
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
/**
 *  点击视图后的代理
 */
protocol HJBannerViewDelegate : NSObjectProtocol {
    func didSelectHJBannerView(index: NSInteger)
}
