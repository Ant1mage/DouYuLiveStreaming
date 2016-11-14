//
//  CustomNavViewController.swift
//  DYTV-AlexanderZ-Swift
//
//  Created by Alexander Zou on 2016/11/15.
//  Copyright © 2016年 Alexander Zou. All rights reserved.
//

import UIKit

class CustomNavViewController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // 拿到系统的Pop手势
        guard let systemGes = interactivePopGestureRecognizer else { return }
        
        // 获取手势添加到view中
        guard let gesView = systemGes.view else { return }
        
        // 利用runtime获取target/action
        /*
        var count : UInt32 = 0
        let ivars = class_copyIvarList(UIGestureRecognizer.self, &count)!
        for i in 0..<count {
            let ivar = ivars[Int(i)]
            let name = ivar_getName(ivar)
            print(String(cString : name!))
        }
        */
        
        let targets = systemGes.value(forKey: "_targets") as? [NSObject]
        guard let targetObjc = targets?.first else { return }
//        print(targetObjc)
        
        guard let target = targetObjc.value(forKey: "target") else { return }
        let action = Selector(("handleNavigationTransition:"))
        
        // 创建自己的手势并添加到系统的类中
        let panGes = UIPanGestureRecognizer()
        gesView.addGestureRecognizer(panGes)
        panGes.addTarget(target, action: action)
        
    }


}
