//
//  UIBarButtonItem+Extension.swift
//  DYTV-AlexanderZ-Swift
//
//  Created by Alexander Zou on 16/9/23.
//  Copyright © 2016年 Alexander Zou. All rights reserved.
//

import UIKit

extension UIBarButtonItem {
    
    //便利构造函数
    convenience init(imageName : String, highImageName : String = "", size : CGSize = CGSizeZero){
        
        // 1.创建btn
        let btn = UIButton()
        
        // 2.设置btn图片
        btn.setImage(UIImage(named: imageName), forState: .Normal)
        if highImageName != "" {
            btn.setImage(UIImage(named: highImageName), forState: .Highlighted)
        }
        
        // 3.设置btn的尺寸
        if size == CGSizeZero {
            btn.sizeToFit()
        } else {
            btn.frame = CGRect(origin: CGPointZero, size: size)
        }
        
        // 4.创建UIBarButtonItem
        self.init(customView : btn)
        
}
    
    
    
    
    
}