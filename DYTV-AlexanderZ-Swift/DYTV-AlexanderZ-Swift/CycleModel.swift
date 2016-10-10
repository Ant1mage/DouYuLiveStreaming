//
//  CycleModel.swift
//  DYTV-AlexanderZ-Swift
//
//  Created by Alexander Zou on 16/10/10.
//  Copyright © 2016年 Alexander Zou. All rights reserved.
//

import UIKit

class CycleModel: NSObject {

    var title : String = ""
    
    var pic_url : String = ""
    
    // 主播对应的字典
    var room : [String : NSObject]? {
        didSet {
            guard let room = room else { return }
            anchor = AnchorModel(dict: room)
        }
    }
    
    var anchor : AnchorModel?
    
    // 构造函数
    init(dict : [String : NSObject]) {
        super.init()
        
        setValuesForKeysWithDictionary(dict)
    }
    
    override func setValue(value: AnyObject?, forKey key: String) {
        
    }
    
}
