//
//  ViewController.swift
//  BannerDemo
//
//  Created by 栾士伟 on 17/3/17.
//  Copyright © 2017年 Luanshiwei. All rights reserved.
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
        
        banner.imageURLs = ["https://ss2.baidu.com/6ONYsjip0QIZ8tyhnq/it/u=303603140,3184148043&fm=175&s=5F20B946F4B3379C05D9B9060100C0C2&w=640&h=853&img.JPEG",
                           "https://ss1.baidu.com/6ONXsjip0QIZ8tyhnq/it/u=2265243523,4221178339&fm=173&s=73BE27660B434E55361EA26F0300D07B&w=317&h=321&img.JPG",
                           "https://ss1.baidu.com/6ONXsjip0QIZ8tyhnq/it/u=3967922392,606741558&fm=175&s=42B039C6A996A69C7F79B1160300C0C1&w=640&h=853&img.JPEG",
                           "https://ss0.baidu.com/6ONWsjip0QIZ8tyhnq/it/u=563166834,3735424302&fm=175&s=0A125D87B8F2D184B69CCCB6030050E1&w=640&h=853&img.JPEG",
                           "https://ss2.baidu.com/6ONYsjip0QIZ8tyhnq/it/u=4178677268,2322341897&fm=173&s=98D3A14C582AAC1FAC5CA81B030090C3&w=600&h=319&img.JPG",
                           "https://ss1.baidu.com/6ONXsjip0QIZ8tyhnq/it/u=3640343134,972389242&fm=173&s=F61C14C65403A51F9AB3A4680300201B&w=640&h=426&img.JPEG",]
        
    }
    
    func didSelectHJBannerView(index: NSInteger) {
        print(index)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
