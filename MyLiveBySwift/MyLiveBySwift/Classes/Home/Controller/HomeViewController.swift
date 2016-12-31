//
//  HomeViewController.swift
//  MyLiveBySwift
//
//  Created by Shedows on 2016/12/30.
//  Copyright © 2016年 Shedows. All rights reserved.
//

import UIKit

private let kTitleViewH : CGFloat = 40

class HomeViewController: UIViewController {
    
    // 加载属性
    // 通过懒加载来调用： pageTitleView
    lazy var pageTitleView: PageTitleView = { [weak self] in
        let titleFrame = CGRect(x: 0, y: kStatusBarH + kNavigetionBarH, width: kScreenW, height: kTitleViewH)
        let titles = ["推荐","游戏","娱乐","趣玩"]
        let titleView = PageTitleView(frame: titleFrame, titles: titles)
        titleView.deleget = self
        return titleView
    }()
    
    lazy var pageContentView: PageContentView = { [weak self] in
        // 创建frame
        let kContenViewH = kScreenH - kStatusBarH-kTitleViewH
        let contentFrame = CGRect(x: 0, y: kStatusBarH+kNavigetionBarH+kTitleViewH, width: kScreenW, height: kContenViewH)
        
        // 创建childVcs
        var childVcs = [UIViewController]()
        for _ in 0..<4 {
            let vc = UIViewController()
            vc.view.backgroundColor = UIColor(r: CGFloat(arc4random_uniform(255)), g: CGFloat(arc4random_uniform(255)), b: CGFloat(arc4random_uniform(255)))
            childVcs.append(vc)
        }
        
        let contentView = PageContentView(frame: contentFrame, childVcs: childVcs, praentController: self)
        
        return contentView
    }()
    
    
    // 系统的回调函数
    override func viewDidLoad() {
        super.viewDidLoad()
        //
        setupUI()
        
        
    }
    
}

// MARK:- 设置UI界面
extension HomeViewController {

    func setupUI(){
        // 不需要调整scrollView的内边距
        automaticallyAdjustsScrollViewInsets = false
        // 设置导航栏
        setNavigetionBar()
        // 设置标题栏
        view.addSubview(pageTitleView)
        // 设置内容显示栏
        view.addSubview(pageContentView)
        pageContentView.backgroundColor = UIColor.purple
    }

    
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

// MARK:- 遵守PageTitleViewDelegate协议
extension HomeViewController : PageTitleViewDelegate {
    func pageTitleView(_ titleView: PageTitleView, selectedIndex index: Int) {
        pageContentView.setCurrentIndex(index)
    }
}
