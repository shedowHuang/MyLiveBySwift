//
//  RecommandViewModel.swift
//  MyLiveBySwift
//
//  Created by Shedows on 2017/1/1.
//  Copyright © 2017年 Shedows. All rights reserved.
//

import UIKit

class RecommandViewModel{

    lazy var cycleModels : [CycleModel] = [CycleModel]()
    lazy var anchorGroups : [AnchorGroup] = [AnchorGroup]()
    fileprivate lazy var bigDataGroup : AnchorGroup = AnchorGroup();
    fileprivate lazy var prettyGroup : AnchorGroup = AnchorGroup();

}

// 网络请求数据
extension RecommandViewModel {
    
    //请求推荐数据
    func requestDate (_ finishCallback : @escaping () ->()) {
        // 0.定义参数
        let parameters = ["limit" : "4", "offset" : "0", "time" : Date.getCurrentTime()]
        
        // 1.创建Group
        let dGroup = DispatchGroup()
        
        // 2. 第一部分推荐数据。 编号：0
        dGroup.enter()
        NetworkTools.requestData(.get, URLString: "http://capi.douyucdn.cn/api/v1/getbigDataRoom", parameters: ["time" : Date.getCurrentTime()]){ (result) in
            // 1. 请求到的结果转换成字典模型
            guard let resultDict = result as? [String : Any] else { return }
            // 2. 获取Key对应的数据
            guard let dataArray = resultDict["data"] as? [[String : Any]] else { return }
            
            // 3.遍历字典,并且转成模型对象
            // 3.1.设置组的属性
            self.bigDataGroup.tag_name = "热门"
            self.bigDataGroup.icon_name = "home_header_hot"
            
            for dict in dataArray {
                let anchor = AnchorModel(dict: dict)
                self.bigDataGroup.anchors.append(anchor)
            }
            // 3.3.离开组
            dGroup.leave()
        }
        
        
        // 3. 第二部分颜值数据。 编号：1
        dGroup.enter()
        NetworkTools.requestData(.get, URLString: "http://capi.douyucdn.cn/api/v1/getVerticalRoom", parameters: parameters){ (result) in
            // 1. 请求到的结果转换成字典模型
            guard let resultDict = result as? [String : Any] else { return }
            // 2. 获取Key对应的数据
            guard let dataArray = resultDict["data"] as? [[String : Any]] else { return }
            
       
            self.prettyGroup.tag_name = "颜值"
            self.prettyGroup.icon_name = "home_header_phone"
            
            for dict in dataArray {
                let anchor = AnchorModel(dict: dict)
            self.prettyGroup.anchors.append(anchor)
                
            }
            dGroup.leave()
        }
        
        // 4. 第三部分游戏数据。 编号：2-12
        dGroup.enter()
        NetworkTools.requestData(.get, URLString: "http://capi.douyucdn.cn/api/v1/getHotCate", parameters: parameters){ (result) in
            
            // 1. 请求到的结果转换成字典模型
            guard let resultDict = result as? [String : Any] else { return }
            // 2. 获取Key对应的数据
            guard let dataArray = resultDict["data"] as? [[String : Any]] else { return }
            // 3. 遍历数据，获取的数据转换成模型对象
            
            for dict in dataArray {
            
                let group = AnchorGroup(dict: dict)
                //print(group.tag_name)
                self.anchorGroups.append(group)
            
            }
            dGroup.leave()
        }
        
        // 5.所有的数据都请求到,之后进行排序
        dGroup.notify(queue: DispatchQueue.main) {
            self.anchorGroups.insert(self.prettyGroup, at: 0)
            self.anchorGroups.insert(self.bigDataGroup, at: 0)
            
            finishCallback()
        }
    
    }
    
    // 请求无限轮播数据
    func requestCycleData(_ finishCallback : @escaping () ->()){
    
        NetworkTools.requestData(.get, URLString: "http://www.douyutv.com/api/v1/slide/6", parameters: ["version" : "2.430"]){ (result) in
            
            // 1.获取整体字典数据
            guard let resultDict = result as? [String : NSObject] else { return }
            
            // 2.根据data的key获取数据
            guard let dataArray = resultDict["data"] as? [[String : NSObject]] else { return }
            
            // 3.字典转模型对象
            for dict in dataArray {
                self.cycleModels.append(CycleModel(dict: dict))
                
            }
        
        finishCallback()
    }
    
}
}
