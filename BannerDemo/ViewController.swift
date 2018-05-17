//
//  ViewController.swift
//  BannerDemo
//
//  Created by 士伟 on 17/3/17.
//  Copyright © 2017年 shiweiluan. All rights reserved.
//

import UIKit
import Kingfisher
import SnapKit

let HJScreenWidth = UIScreen.main.bounds.size.width
let HJcreentHeight = UIScreen.main.bounds.size.height

class ViewController: UIViewController, HJBannerViewDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        view.backgroundColor = UIColor.white
        
        let banner = HJBannerView.init(width: HJScreenWidth, height: 180)
        banner.delegate = self
        view.addSubview(banner)
        banner.snp.makeConstraints { (make) in
            make.left.equalTo(view)
            make.top.equalTo(view).offset(20)
            make.right.equalTo(view)
            make.height.equalTo(180)
        }
        
        banner.imageURLs = ["https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1526554359903&di=8c808b70af75984438d11c8d8ba48486&imgtype=jpg&src=http%3A%2F%2Fimg3.imgtn.bdimg.com%2Fit%2Fu%3D3450281778%2C3068234180%26fm%3D214%26gp%3D0.jpg",
                            
                           "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1526554251388&di=33495fceaff187129cd180660a5a1bfd&imgtype=0&src=http%3A%2F%2Fpic.58pic.com%2F58pic%2F13%2F56%2F99%2F88f58PICuBh_1024.jpg",
                           
                           "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1526554354216&di=98f2f921627d83fac16c2786f920e151&imgtype=0&src=http%3A%2F%2Fimage.tianjimedia.com%2FuploadImages%2F2016%2F330%2F15%2F802AX9R1IB42.jpg",
                           
                           "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1526554354214&di=c06afcf26f0e13ed0b29d02a3b3dc42f&imgtype=0&src=http%3A%2F%2Fimage.tianjimedia.com%2FuploadImages%2F2016%2F330%2F58%2F9VH9HT022Y2Z.jpg",
                           
                           "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1526554354209&di=3587768c6624074d20dad9e29da731a2&imgtype=0&src=http%3A%2F%2Fimage.tianjimedia.com%2FuploadImages%2F2016%2F330%2F58%2F152CJ2E316I8.jpg",
                           
                           "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1526554409988&di=6f62d4cb6ae7e9c2c1dc2b051301b6f8&imgtype=0&src=http%3A%2F%2Fimage.tianjimedia.com%2FuploadImages%2F2016%2F330%2F02%2FNQ3IIDJJ8W29.jpg",]
        
    }
    
    func didSelectHJBannerView(index: NSInteger) {
        print(index)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
