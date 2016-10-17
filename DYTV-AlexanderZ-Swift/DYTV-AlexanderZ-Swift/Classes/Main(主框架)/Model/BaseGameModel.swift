//
//  BaseGameModel.swift
//  DYTV-AlexanderZ-Swift
//
//  Created by Alexander Zou on 2016/10/14.
//  Copyright © 2016年 Alexander Zou. All rights reserved.
//

import UIKit

class BaseGameModel: NSObject {
    
    var tag_name : String = ""
    var icon_url : String = ""
    
    
    override init() {
        
    }
    
    init(dict : [String : Any]) {
        super.init()
        
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {}
}
