//
//  CollectionGameCell.swift
//  MyLiveBySwift
//
//  Created by Shedows on 2017/1/5.
//  Copyright © 2017年 Shedows. All rights reserved.
//

import UIKit
import Kingfisher

class CollectionGameCell: UICollectionViewCell {

    
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    var group : AnchorGroup?{
        didSet{
        
        titleLabel.text = group?.tag_name
            
        let iconUrl = URL(string: group?.icon_url ?? "")
       
        iconImageView.kf.setImage(with: iconUrl, placeholder: UIImage(named: "home_more_btn"), options: nil, progressBlock: nil, completionHandler: nil)
            
        }
    }
}
