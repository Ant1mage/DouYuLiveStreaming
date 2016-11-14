//
//  MainViewController.swift
//  DYTV-AlexanderZ-Swift
//
//  Created by Alexander Zou on 16/9/23.
//  Copyright © 2016年 Alexander Zou. All rights reserved.
//

import UIKit

class MainViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addChildVCs()
        
    }

}

extension MainViewController {
    
    fileprivate func addChildVCs() {
        
        tabBar.tintColor = UIColor.orange
        addChildViewController(HomeViewController(), title: "首页", imageName: "btn_home_normal", selImg: "btn_home_selected")
        addChildViewController(LiveViewController(), title: "直播", imageName: "btn_column_normal",selImg: "btn_column_selected")
        addChildViewController(FollowViewController(), title: "关注", imageName: "btn_live_normal",selImg: "btn_live_selected")
        addChildViewController(MineViewController(), title: "我的", imageName: "btn_user_normal", selImg: "btn_user_selected")
    }
    
    fileprivate func addChildViewController(_ vc: UIViewController, title: String, imageName: String, selImg:String) {
        
        // 设置标题
        vc.tabBarItem.title = title
        
        // 设置图像
        vc.tabBarItem.image = UIImage(named: imageName)
        vc.tabBarItem.selectedImage = UIImage(named: selImg)
        
        // 导航控制器
        let nav = CustomNavViewController(rootViewController: vc)
        addChildViewController(nav)
        
    }
    
}
