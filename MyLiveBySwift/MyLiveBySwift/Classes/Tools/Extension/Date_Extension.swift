//
//  Date_Extension.swift
//  MyLiveBySwift
//
//  Created by Shedows on 2017/1/1.
//  Copyright © 2017年 Shedows. All rights reserved.
//

import Foundation

// MARK:- 获取当前时间 返回 以秒显示
extension Date{
    static func getCurrentTime() ->String{
        
        let nowDate = Date()
        let interval = nowDate.timeIntervalSince1970
        
        return "\(interval)"
    }
    
}
