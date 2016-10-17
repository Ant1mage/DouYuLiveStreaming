//
//  NSDate + Extension.swift
//  DYTV-AlexanderZ-Swift
//
//  Created by Alexander Zou on 16/9/30.
//  Copyright © 2016年 Alexander Zou. All rights reserved.
//

import Foundation

extension Date {
    
    static func getCurrentTime() -> String {
        
        let nowDate = Date()
        let interval =  nowDate.timeIntervalSince1970
        
        return "\(interval)"
        
    }
    
}
