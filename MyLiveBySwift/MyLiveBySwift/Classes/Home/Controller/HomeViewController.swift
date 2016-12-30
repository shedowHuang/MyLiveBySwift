//
//  HomeViewController.swift
//  MyLiveBySwift
//
//  Created by Shedows on 2016/12/30.
//  Copyright © 2016年 Shedows. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
 
        setupUI()
        
    }
    
}


// MARK:- 设置UI界面
extension HomeViewController {

    func setupUI(){
        setNavigetionBar()
    }

    // 设置导航栏 
    func setNavigetionBar(){
        // 设置导航栏左边图标
        //let btn = UIButton()
        //btn.setImage(UIImage(named: "logo"), for: .normal)
        //btn.sizeToFit()                         // 设置button尺寸，这里是按图片大小自动设置
        //navigationItem.leftBarButtonItem = UIBarButtonItem(customView: btn)
        navigationItem.leftBarButtonItem = UIBarButtonItem(imageName: "logo")
        
        // 设置导航栏右边的图标
        let size = CGSize(width: 30, height: 30)
        let historyItem = UIBarButtonItem(imageName: "image_my_history", hightimageName: "Image_my_history_click", size: size)
        let serchItem = UIBarButtonItem(imageName: "btn_search", hightimageName: "btn_search_clicked", size: size)
        let qrcodeItem = UIBarButtonItem(imageName: "Image_scan", hightimageName: "Image_scan_click", size: size)
        
        navigationItem.rightBarButtonItems = [historyItem, serchItem, qrcodeItem]
        
    }


}
