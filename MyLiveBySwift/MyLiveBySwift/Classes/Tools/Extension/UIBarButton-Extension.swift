//
//  UIBarButton-Extension.swift
//  MyLiveBySwift
//
//  Created by Shedows on 2016/12/30.
//  Copyright © 2016年 Shedows. All rights reserved.
//

import UIKit


extension UIBarButtonItem {

    // 便利构造函数 1.必须convenience 开头；2.必须调用已有的一个函数
    convenience init(imageName:String, hightimageName:String = "",size:CGSize = CGSize.zero) {
        
        let btn = UIButton()
        btn.setImage(UIImage(named:imageName), for: .normal)
        
        if hightimageName != "" {
            btn.setImage(UIImage(named:hightimageName), for: .highlighted)

        }
        
        if size != CGSize.zero {
            btn.frame = CGRect(origin: CGPoint.zero, size: size)
        } else {
            btn.sizeToFit()                          // 设置button尺寸，这里是按图片大小自动设置
        }
        
        self.init(customView: btn)
    }
}
