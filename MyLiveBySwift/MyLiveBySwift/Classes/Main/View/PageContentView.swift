//
//  PageContentView.swift
//  MyLiveBySwift
//
//  Created by Shedows on 2016/12/31.
//  Copyright © 2016年 Shedows. All rights reserved.
//

import UIKit

private let contentCellID = "contentCellID"

class PageContentView: UIView {

    fileprivate var childVcs: [UIViewController]
    fileprivate var praentController: UIViewController
    
    
    lazy var collectionView: UICollectionView = {
        // 先创建layout。   
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = self.bounds.size
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        layout.scrollDirection = .horizontal
        
        // 创建collectionView
        let conllectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        conllectionView.showsHorizontalScrollIndicator = false
        conllectionView.isPagingEnabled = true
        conllectionView.bounces = false
        conllectionView.dataSource = self     // 使用dataSource 必须遵守 UICollectionViewDataSource 协议
        conllectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: contentCellID)
        return conllectionView
    
    }()
    
    init(frame: CGRect, childVcs: [UIViewController], praentController: UIViewController) {
        self.childVcs = childVcs
        self.praentController = praentController

        super.init(frame: frame)
        
        setupUI()
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


extension PageContentView{
    func setupUI(){
        // 把子控制器添加到父控制器
        for childVc in childVcs {
            praentController.addChildViewController(childVc)
        }
        
        // 定义collectView来存放cell里UIView
        self.addSubview(collectionView)
        collectionView.frame = bounds
    }
}

extension PageContentView: UICollectionViewDataSource{

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return childVcs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // 创建cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: contentCellID, for: indexPath)
        // 给cell设置内容
        for view in cell.contentView.subviews{
            view.removeFromSuperview()
        }
        
        let childVc = childVcs[indexPath.item]
        childVc.view.frame = cell.contentView.bounds
        cell.contentView.addSubview(childVc.view)
   
        return cell
    }

}
