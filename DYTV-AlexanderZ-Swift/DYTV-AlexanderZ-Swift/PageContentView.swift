//
//  PageContentView.swift
//  DYTV-AlexanderZ-Swift
//
//  Created by Alexander Zou on 16/9/24.
//  Copyright © 2016年 Alexander Zou. All rights reserved.
//

import UIKit

private let contentCellID = "contentCellID"

class PageContentView: UIView {
    
    // 定义属性
    private var childVcs : [UIViewController]
    private var parentViewController : UIViewController?
    
    // 懒加载属性
    private lazy var collectionView : UICollectionView = {
       // 1.创建layout
       let layout = UICollectionViewFlowLayout()
       layout.itemSize = self.bounds.size
       layout.minimumLineSpacing = 0
       layout.minimumInteritemSpacing = 0
       layout.scrollDirection = .Horizontal
        
       // 2.创建UICollectionView
       let collectionView = UICollectionView(frame: CGRectZero, collectionViewLayout: layout)
       collectionView.showsHorizontalScrollIndicator = false
       collectionView.pagingEnabled = true
       collectionView.bounces = false
       collectionView.registerClass(UICollectionView.self, forCellWithReuseIdentifier: contentCellID)
        
       return collectionView
    }()
    
    
    init(frame: CGRect, childVcs : [UIViewController], parentViewController : UIViewController) {
        
        self.childVcs = childVcs
        self.parentViewController = parentViewController
        
        super.init(frame:frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

// 设置界面
extension PageContentView {
    
    private func setupUI() {
        // 1.将所有子控制器添加到父控制器
        for childVC in childVcs {
            parentViewController!.addChildViewController(childVC)
        }
        
        // 2.添加UICollectionView,用于Cell中存放控制器的View
        addSubview(collectionView)
        collectionView.bounds = bounds
        
    }
    
    
}


// 遵守UICollectionViewDataSource
extension PageContentView : UICollectionViewDataSource {
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return childVcs.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        // 1.创建Cell
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(contentCellID, forIndexPath: indexPath)
        
        // 2.给Cell设置内容
        for view in cell.contentView.subviews {
            view.removeFromSuperview()
        }
        
        let childVc = childVcs[indexPath.item]
        childVc.view.frame = cell.contentView.bounds
        cell.contentView.addSubview(childVc.view)
        
        return cell
    }
}
