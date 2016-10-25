//
//  AmuseViewController.swift
//  DYTV-AlexanderZ-Swift
//
//  Created by Alexander Zou on 2016/10/18.
//  Copyright © 2016年 Alexander Zou. All rights reserved.
//

import UIKit

private let kMenuViewH : CGFloat = 200

class AmuseViewController: BaseAnchorViewController {
    
    fileprivate lazy var amuseViewModel : AmuseViewModel = AmuseViewModel()
    
    fileprivate lazy var menuView : AmuseMenuView = {
        let menuView = AmuseMenuView.amuseMenuView()
        menuView.frame = CGRect(x: 0, y: -kMenuViewH, width: kScreenW, height: kMenuViewH)
        return menuView
    }()
}

// MARK:- 设置UI界面
extension AmuseViewController {
    override func setupUI() {
        super.setupUI()
        
        collectionView.addSubview(menuView)
        collectionView.contentInset = UIEdgeInsets(top: kMenuViewH, left: 0, bottom: 0, right: 0)
    }
}

// MARK:- 请求数据
extension AmuseViewController {
    override func loadData() {
        
        baseViewModel = amuseViewModel
        
        amuseViewModel.loadAmuseData {
            self.collectionView.reloadData()
            
            var tempGroups = self.amuseViewModel.anchorGroups
            tempGroups.removeFirst()
            self.menuView.groups = tempGroups
            
            self.loadDataFinished()
        }
    }
}
