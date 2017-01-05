//
//  RecommendGameView.swift
//  MyLiveBySwift
//
//  Created by Shedows on 2017/1/4.
//  Copyright © 2017年 Shedows. All rights reserved.
//

import UIKit

private let kGameCellID = "kGameCellID"
private let kEdgeInsetMargin : CGFloat = 10

class RecommendGameView: UIView {

    // MARK:-定义属性
    var groups : [AnchorGroup]?{
        didSet {
            groups?.remove(at: 0)
            groups?.remove(at: 0)
            //添加 更多 选项
            let moreGroup = AnchorGroup()
            moreGroup.tag_name = "更多"
            groups?.append(moreGroup)
            
            // 刷新
            collectView.reloadData()
        
        
        }
    }
    
    // MARK: 控件属性
    @IBOutlet weak var collectView: UICollectionView!
    
    // MARK: 系统回调函数
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // 设置该控件不随着父控件的拉伸而拉伸
        autoresizingMask = UIViewAutoresizing()
        // 注册cell
        collectView.register(UINib(nibName: "CollectionGameCell", bundle: nil), forCellWithReuseIdentifier: kGameCellID)
        // 给collectionView添加内边距
        collectView.contentInset = UIEdgeInsets(top: 0, left: kEdgeInsetMargin, bottom: 0, right: kEdgeInsetMargin)
    }

}


// MARK:- 快速创建的类方法
extension RecommendGameView{
    static func recommendGameView() -> RecommendGameView{
    
        return Bundle.main.loadNibNamed("RecommendGameView", owner: nil, options: nil)?.first as! RecommendGameView
    }

}

// MARK:- 遵守UICollectionView的数据源协议
extension RecommendGameView: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return  groups?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kGameCellID, for: indexPath) as! CollectionGameCell
        
        cell.group = groups![indexPath.item]
        
        //cell.backgroundColor = (indexPath.item) % 2 == 0 ? UIColor.purple : UIColor.red
        return cell
    }

}
