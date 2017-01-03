//
//  CollectionCycleCell.swift
//  MyLiveBySwift
//
//  Created by Shedows on 2017/1/4.
//  Copyright © 2017年 Shedows. All rights reserved.
//

import UIKit
import Kingfisher

class CollectionCycleCell: UICollectionViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    
    var cycleModel : CycleModel?{
        didSet {
            titleLabel.text = cycleModel?.title
            let iconUrl = URL(string: cycleModel?.pic_url ?? "" )!
            
            iconImageView.kf.setImage(with: iconUrl)
        }
    }
}
