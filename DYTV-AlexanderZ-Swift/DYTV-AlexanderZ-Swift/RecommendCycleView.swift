//
//  RecommendCycleView.swift
//  DYTV-AlexanderZ-Swift
//
//  Created by Alexander Zou on 16/10/10.
//  Copyright © 2016年 Alexander Zou. All rights reserved.
//

import UIKit

private let kCycleID = "kCycleID"

class RecommendCycleView: UIView {

    var cycleModels : [CycleModel]? {
        didSet {
            
            collectView.reloadData()
            
            pageControl.numberOfPages = cycleModels?.count ?? 0
        }
    }
    
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var collectView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        autoresizingMask = .None
        
        collectView.showsHorizontalScrollIndicator = false
        collectView.bounces = false
        // 注册cell
        collectView.registerNib(UINib(nibName: "CollectionCycleCell", bundle: nil), forCellWithReuseIdentifier: kCycleID)
        
    }
    
    override func layoutSubviews() {
        
        
        // 设置layout
        let layout = collectView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = collectView.bounds.size
    }

}

extension RecommendCycleView {
    
    class func recommendCycleView() -> RecommendCycleView {
        
        return NSBundle.mainBundle().loadNibNamed("RecommendCycleView", owner: nil, options: nil).first as! RecommendCycleView
    }
    
}

// 遵守collectionView数据源
extension RecommendCycleView : UICollectionViewDelegate {
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cycleModels?.count ?? 0
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(kCycleID, forIndexPath: indexPath) as! CollectionCycleCell
        
        cell.cycleModel = cycleModels![indexPath.item % cycleModels!.count]
        
        return cell
    }
    
    
}