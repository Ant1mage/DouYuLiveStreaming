//
//  RecommendViewController.swift
//  DYTV-AlexanderZ-Swift
//
//  Created by Alexander Zou on 16/9/26.
//  Copyright © 2016年 Alexander Zou. All rights reserved.
//

import UIKit

private let kItemMargin : CGFloat = 10
private let kItemW = (kScreenW - 3 * kItemMargin) / 2
private let kNormalItemH = kItemW * 3 / 4
private let kPrettyItemH = kItemW * 4 / 3
private let kHeaderViewH : CGFloat = 50

private let kCycleViewH = kScreenW * 3 / 7


private let kNormalCellID = "kNormalCellID"
private let kPrettyCellID = "kPrettyCellID"
private let kHeaderViewID = "kHeaderViewID"

class RecommendViewController: UIViewController {
    
    // 懒加载属性
    private lazy var recommendViewModel : RecommendViewModel = RecommendViewModel()
    
    private lazy var cycleView : RecommendCycleView = {
        
        let cycleView = RecommendCycleView.recommendCycleView()
        cycleView.frame = CGRect(x: 0, y: -kCycleViewH, width: kScreenW, height: kCycleViewH)
        return cycleView
    }()
    
    private lazy var collectionView : UICollectionView = {[unowned self] in
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: kItemW, height: kNormalItemH)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = kItemMargin
        layout.headerReferenceSize = CGSize(width: kScreenW, height: 50)
        layout.sectionInset = UIEdgeInsets(top: 0, left: kItemMargin, bottom: 0, right: kItemMargin)
        
        let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.autoresizingMask = [.FlexibleWidth,.FlexibleHeight]
        collectionView.backgroundColor = UIColor.whiteColor()
        
        // 注册
        collectionView.registerNib(UINib(nibName: "CollectionNormalCell",bundle: nil), forCellWithReuseIdentifier: kNormalCellID)
        collectionView.registerNib(UINib(nibName: "CollectionPrettyCell",bundle: nil), forCellWithReuseIdentifier: kPrettyCellID)
        collectionView.registerNib(UINib(nibName: "CollectionHeaderView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: kHeaderViewID)
        
        return collectionView
        }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 设置界面
        setupUI()
        
        // 发送网络请求
        loadData()
        
        
    }
    
}


// MARK:- 请求网络数据
extension RecommendViewController {
    
    // 请求数据
    private func loadData() {
        
        // 推荐页面数据
        self.recommendViewModel.requestData {
            
            self.collectionView.reloadData()
        }
        
        // 无限轮播数据
        recommendViewModel.requestCycleData {
            self.cycleView.cycleModels = self.recommendViewModel.cycleModels
        }
        
    }
    
    
}


// MARK:- 设置UI
extension RecommendViewController {
    
    private func setupUI() {
        
        view.addSubview(collectionView)
        collectionView.addSubview(cycleView)
        
        // 设置collectionView内边距
        collectionView.contentInset = UIEdgeInsets(top: kCycleViewH, left: 0, bottom: 0, right: 0)
        
    }
    
}

// MARK:- CollectionViewdataSource协议
extension RecommendViewController : UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        
        return recommendViewModel.anchorGroups.count ?? 0
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let group = recommendViewModel.anchorGroups[section]
        
        return group.anchors.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        // 取出模型
        let group = recommendViewModel.anchorGroups[indexPath.section]
        let anchor = group.anchors[indexPath.item]
        
        var cell : CollectionBaseCell!
        
        
        if indexPath.section == 1 {
            cell = collectionView.dequeueReusableCellWithReuseIdentifier(kPrettyCellID, forIndexPath: indexPath) as! CollectionPrettyCell
            
        } else {
            cell = collectionView.dequeueReusableCellWithReuseIdentifier(kNormalCellID, forIndexPath: indexPath) as! CollectionNormalCell
            
        }
        
        cell.anchor = anchor
        
        return cell
    }
    
    
//    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
//        
//        let cell = collectionView.cellForItemAtIndexPath(indexPath)
//        
//        cell?.backgroundColor = UIColor.blueColor()
//        
//        let liveVideoVC = LiveVideoViewController()
//        
//        self.navigationController?.pushViewController(liveVideoVC, animated: true)
//    }
    
    
    func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
        
        let headerView = collectionView.dequeueReusableSupplementaryViewOfKind(kind, withReuseIdentifier: kHeaderViewID, forIndexPath: indexPath) as! CollectionHeaderView
        
        headerView.group = recommendViewModel.anchorGroups[indexPath.section]
        
        return headerView
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        
        if indexPath.section == 1 {
            
            return CGSize(width: kItemW,height: kPrettyItemH)
        }
        
        return CGSize(width: kItemW, height: kNormalItemH)
        
    }
    
}