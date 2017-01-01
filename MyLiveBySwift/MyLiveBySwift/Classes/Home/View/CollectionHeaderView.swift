//
//  CollectionHeaderView.swift
//  MyLiveBySwift
//
//  Created by Shedows on 2016/12/31.
//  Copyright © 2016年 Shedows. All rights reserved.
//

import UIKit

class CollectionHeaderView: UICollectionReusableView {

    // MARK:- 控件属性

    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var iconImageView: UIImageView!

    // MARK:- 定义模型属性
    var group : AnchorGroup? {
        didSet {
            titleLabel.text = group?.tag_name
            iconImageView.image = UIImage(named: group?.icon_name ?? "home_header_normal")
        }
        
    }

}
