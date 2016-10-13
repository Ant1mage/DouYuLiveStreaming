//
//  PageContentView.swift
//  DYTV-AlexanderZ-Swift
//
//  Created by Alexander Zou on 16/9/24.
//  Copyright © 2016年 Alexander Zou. All rights reserved.
//

import UIKit

protocol PageContentViewDelegate : class {
    func pageContentView(_ contentView : PageContentView, progress : CGFloat, sourceIndex : Int, targetIndex : Int)
}

private let contentCellID = "contentCellID"


class PageContentView: UIView {
    
    // 定义属性
    fileprivate var childVcs : [UIViewController]
    fileprivate weak var parentViewController : UIViewController?
    fileprivate var startOffsetX : CGFloat = 0
    weak var delegate : PageContentViewDelegate?
    fileprivate var isForbidScrollDelegate : Bool = false
    
    // 懒加载属性
    fileprivate lazy var collectionView : UICollectionView = {[weak self] in

       let layout = UICollectionViewFlowLayout()
       layout.itemSize = (self?.bounds.size)!
       layout.minimumLineSpacing = 0
       layout.minimumInteritemSpacing = 0
       layout.scrollDirection = .horizontal
        
       let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
       collectionView.showsHorizontalScrollIndicator = false
       collectionView.isPagingEnabled = true
       collectionView.bounces = false
       collectionView.scrollsToTop = false
       collectionView.dataSource = self
       collectionView.delegate = self
       collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: contentCellID)
        
       return collectionView
    }()
    
    
    init(frame: CGRect, childVcs : [UIViewController], parentViewController : UIViewController?) {
        
        self.childVcs = childVcs
        self.parentViewController = parentViewController
        
        super.init(frame:frame)
        
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

// MARK:- 设置UI
extension PageContentView {
    
    fileprivate func setupUI() {

        for childVC in childVcs {
            parentViewController?.addChildViewController(childVC)
        }
        
        addSubview(collectionView)
        collectionView.frame = bounds
        
    }
}


// MARK:- 遵守UICollectionViewDataSource
extension PageContentView : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return childVcs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: contentCellID, for: indexPath)
        
        for view in cell.contentView.subviews {
            view.removeFromSuperview()
        }
        
        let childVc = childVcs[(indexPath as NSIndexPath).item]
        childVc.view.frame = cell.contentView.bounds
        cell.contentView.addSubview(childVc.view)
        
        return cell
    }
}


// MARK:- 遵守UICollectionViewDelegate
extension PageContentView : UICollectionViewDelegate {
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        
        isForbidScrollDelegate = false
        
        startOffsetX = scrollView.contentOffset.x
    }
    
    func scrollViewDidScroll(_ scrollView : UIScrollView){
        
        if isForbidScrollDelegate { return }
        
        var progress : CGFloat = 0
        var sourceIndex : Int = 0
        var targetIndex : Int = 0
        
        // 判断左滑动还是右华东
        let currentOffsetX = scrollView.contentOffset.x
        let scrollViewW = scrollView.bounds.width
        if currentOffsetX > currentOffsetX {
            // 左滑动
            progress = currentOffsetX / scrollViewW - floor( currentOffsetX / scrollViewW )
            sourceIndex = Int(currentOffsetX / scrollViewW)
            targetIndex = sourceIndex + 1
            
            // 判断targetIndex是否越界
            if targetIndex >= childVcs.count {
                targetIndex = childVcs.count - 1
            }
            
            // 如果完全滑过去
            if currentOffsetX - currentOffsetX == scrollViewW {
                progress = 1
                targetIndex = sourceIndex
            }
            
        }else {
            // 右滑动
            progress = 1 - (currentOffsetX / scrollViewW - floor( currentOffsetX / scrollViewW ))
            targetIndex = Int(currentOffsetX / scrollViewW)
            sourceIndex = targetIndex + 1
            if sourceIndex >= childVcs.count {
                sourceIndex = childVcs.count - 1
            }
        }
        
        // 将3个数据传给titleView
        print("pro:\(progress),souce:\(sourceIndex),tar:\(targetIndex)")
        delegate?.pageContentView(self, progress: progress, sourceIndex: sourceIndex, targetIndex: targetIndex)
    }
    
    
}

// MARK:- 与pageTitleView的逻辑处理
extension PageContentView {
    
    func setCurrentIndex(currentIndex : Int) {
        
        isForbidScrollDelegate = true
        
        let offsetX = CGFloat (currentIndex) * collectionView.frame.width
        collectionView.setContentOffset(CGPoint(x:offsetX,y:0), animated: true)
    }
}
