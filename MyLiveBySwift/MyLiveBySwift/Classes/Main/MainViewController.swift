//
//  MainViewController.swift
//  MyLiveBySwift
//
//  Created by Shedows on 2016/12/30.
//  Copyright © 2016年 Shedows. All rights reserved.
//

import UIKit

class MainViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // 添加子控制器
        addChildVc(childName: "Home")
        addChildVc(childName: "Live")
        addChildVc(childName: "Follow")
        addChildVc(childName: "Profile")
    }

    private func addChildVc(childName:String){
     let childVc = UIStoryboard(name: childName, bundle: nil).instantiateInitialViewController()!
        
        addChildViewController(childVc)
    }
}
