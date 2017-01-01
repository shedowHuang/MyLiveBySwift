//
//  RecommonViewController.swift
//  MyLiveBySwift
//
//  Created by Shedows on 2016/12/31.
//  Copyright © 2016年 Shedows. All rights reserved.
//

import UIKit

private let kNormalCellID = "kNormalCellID"
private let kPrettryCellID = "kPrettryCellID"
private let kHeaderViewID = "kHeaderViewID"

private let kItemMarginW : CGFloat = 10                           // 间距
private let kItemW : CGFloat = (kScreenW - 3 * kItemMarginW) / 2
private let kNormalItemH : CGFloat = kItemW * 3 / 4
private let kPrettyItemH : CGFloat = kItemW * 4 / 3
private let kHeaderViewH : CGFloat = 50


class RecommonViewController: UIViewController {

    fileprivate lazy var recommandVM: RecommandViewModel = RecommandViewModel()
    fileprivate lazy var collectionView: UICollectionView = { [unowned self] in
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: kItemW, height: kNormalItemH)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = kItemMarginW
        layout.headerReferenceSize = CGSize(width: kScreenW, height: kHeaderViewH)
        layout.sectionInset = UIEdgeInsetsMake(0, kItemMarginW, 0, kItemMarginW)  // 设置内边距
        
        let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.white
        collectionView.dataSource = self
        collectionView.delegate = self
        
        // 注册普通cell
        collectionView.register(UINib(nibName: "CollectionNormalCell", bundle: nil), forCellWithReuseIdentifier: kNormalCellID)
        // 注册特殊cell
        collectionView.register(UINib(nibName: "CollectionPrettyCell", bundle: nil), forCellWithReuseIdentifier: kPrettryCellID)
        // 注册headerView
        collectionView.register(UINib(nibName: "CollectionHeaderView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: kHeaderViewID)

        collectionView.autoresizingMask = [.flexibleHeight,.flexibleWidth]    // 自动跟随屏幕拉伸

        
        return collectionView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //加载UI界面
        setupUI()
        //发送网络请求
        loadData()



    }
}


extension RecommonViewController{
    fileprivate func setupUI(){
        view.addSubview(collectionView)
    }

}


extension RecommonViewController{
    fileprivate func loadData(){
       recommandVM.requestDate { 
            self.collectionView.reloadData()
        }
    }

}


extension RecommonViewController : UICollectionViewDataSource , UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return recommandVM.anchorGroups.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let group = recommandVM.anchorGroups[section]
        return group.anchors.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // 1.创建Cell
        var cell: UICollectionViewCell!
        // 2.取值
        
        if indexPath.section == 1 {
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: kPrettryCellID, for: indexPath)
        } else {
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: kNormalCellID, for: indexPath)
        }
        

        return cell

    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        // 1. 获取selection的HeaderView
        let headerView  = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: kHeaderViewID, for: indexPath) as! CollectionHeaderView
        // 2.获取模型
        headerView.group = recommandVM.anchorGroups[indexPath.section]
        
        return headerView
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        if indexPath.section == 1 {
            return CGSize(width: kItemW, height: kPrettyItemH)
        }
        
        return CGSize(width: kItemW, height: kNormalItemH)
    }
}
