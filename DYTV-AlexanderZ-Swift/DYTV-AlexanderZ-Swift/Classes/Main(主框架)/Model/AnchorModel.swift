//
//  AnchorModel.swift
//  DYTV-AlexanderZ-Swift
//
//  Created by Alexander Zou on 16/9/30.
//  Copyright © 2016年 Alexander Zou. All rights reserved.
//

import UIKit

class AnchorModel: NSObject {
    
    // 房间id
    var room_id : Int = 0
    
    // 房间缩略图
    var vertical_src : String = ""
    
    // 判断是手机直播还是电脑直播
    var isVertical : Int = 0
    
    // 房间名称
    var room_name : String = ""
    
    // 主播昵称
    var nickname : String = ""
    
    // 在线人数
    var online : Int = 0
    
    // 所在的城市
    var anchor_city : String = ""
    
    init(dict : [String : NSObject]) {
        super.init()
        
        setValuesForKeys(dict)
    
    }
    override func setValue(_ value: Any?, forUndefinedKey key: String) {}
}
