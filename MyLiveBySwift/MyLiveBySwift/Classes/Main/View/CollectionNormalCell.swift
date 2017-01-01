//
//  CollectionNormalCell.swift
//  MyLiveBySwift
//
//  Created by Shedows on 2016/12/31.
//  Copyright © 2016年 Shedows. All rights reserved.
//

import UIKit

class CollectionNormalCell: UICollectionViewCell {

    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var onLineBtn: UIButton!    
    @IBOutlet weak var nickNameLabel: UILabel!
    @IBOutlet weak var roomLabel: UILabel!
    var anchor: AnchorModel?{
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
            roomLabel.text = anchor.room_name
            // 显示图片
            
            //初始化URL并且获取图片地址
            guard let url = URL(string: anchor.vertical_src) else { return }
            iconImageView.kf.setImage(with: url)

        
        }
    }
    
}
