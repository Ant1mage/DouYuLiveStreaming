//
//  RoomNormalViewController.swift
//  DYTV-AlexanderZ-Swift
//
//  Created by Alexander Zou on 2016/11/14.
//  Copyright © 2016年 Alexander Zou. All rights reserved.
//

import UIKit

class RoomNormalViewController: UIViewController,UIGestureRecognizerDelegate {
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.orange
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }

}

