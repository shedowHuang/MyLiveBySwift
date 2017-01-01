//
//  CollectionPrettyCell.swift
//  MyLiveBySwift
//
//  Created by Shedows on 2016/12/31.
//  Copyright © 2016年 Shedows. All rights reserved.
//

import UIKit

class CollectionPrettyCell: UICollectionViewCell {
 
    @IBOutlet weak var cityBtn: UIButton!
    @IBOutlet weak var onLineBtn: UIButton!
    @IBOutlet weak var nickNameLabel: UILabel!
    @IBOutlet weak var IconImageView: UIImageView!
    
    var anchor: AnchorModel? {
        didSet {
            guard let anchor = anchor else { return }
            
            var onLineStr : String = ""
            if anchor.online >= 10000 {
                onLineStr = "\(Int( anchor.online / 10000))万在线"
            } else {
                onLineStr = "\(anchor.online)在线"
            }
            onLineBtn.setTitle(onLineStr, for: .normal)
            nickNameLabel.text = anchor.nickname
            cityBtn.setTitle(anchor.anchor_city, for: .normal)
            
            // 显示图片
        }
    
    }
    

}
