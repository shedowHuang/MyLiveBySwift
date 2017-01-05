//
//  AnchorGroup.swift
//  MyLiveBySwift
//
//  Created by Shedows on 2017/1/1.
//  Copyright © 2017年 Shedows. All rights reserved.
//

import UIKit

class AnchorGroup: NSObject {
    
    /// 该组中对应的房间信息
    var room_list: [[String : Any]]? {
        // 属性监听器， room_list值改变就触发 didSet
        didSet {
            guard let room_list = room_list else { return }
            for dict in room_list {
                anchors.append(AnchorModel(dict: dict))
            }
        }
    }
    /// 该组的标题名
    var tag_name: String = ""
    /// 组显示的图标
    var icon_name: String = "home_header_normal"
    /// 组对应的图标
    var icon_url: String = ""
    /// 定义主播的模型对象数组
    lazy var anchors : [AnchorModel] = [AnchorModel]()

    init(dict: [String : Any]) {
        super.init()
        
        setValuesForKeys(dict)
    }
    
    override init() {}
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {}
    
}
