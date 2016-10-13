//
//  RecommendViewController.swift
//  DYTV-AlexanderZ-Swift
//
//  Created by Alexander Zou on 16/9/26.
//  Copyright © 2016年 Alexander Zou. All rights reserved.
//

import UIKit

private let kCycleViewH = kScreenW * 3 / 7
private let kGameViewH : CGFloat = 90

class RecommendViewController: BaseAnchorViewController {
    
    fileprivate lazy var recommendViewModel : RecommendViewModel = RecommendViewModel()
    fileprivate lazy var cycleView : RecommendCycleView = {
        let cycleView = RecommendCycleView.recommendCycleView()
        cycleView.frame = CGRect(x: 0, y: -(kCycleViewH + kGameViewH), width: kScreenW, height: kCycleViewH)
        return cycleView
    }()
    fileprivate lazy var gameView : RecommendGameView = {
        let gameView = RecommendGameView.recommendGameView()
        gameView.frame = CGRect(x: 0, y: -kGameViewH, width: kScreenW, height: kGameViewH)
        return gameView
    }()
}


// MARK:- 请求网络数据
extension RecommendViewController {
    
    // 请求数据
    override func loadData() {
        
        baseViewModel = recommendViewModel
        
        // 推荐页面数据
        self.recommendViewModel.requestData {
            
            self.collectionView.reloadData()
            
            let groups = self.recommendViewModel.anchorGroups
            
            self.gameView.groups = groups
            
        }
        
        // 无限轮播数据
        recommendViewModel.requestCycleData {
            self.cycleView.cycleModels = self.recommendViewModel.cycleModels
        }
        
    }
    
    
}


// MARK:- 设置UI
extension RecommendViewController {
    
    override func setupUI() {
        
        view.addSubview(collectionView)
        collectionView.addSubview(cycleView)
        collectionView.addSubview(gameView)
        
        // 设置collectionView内边距
        collectionView.contentInset = UIEdgeInsets(top: (kCycleViewH + kGameViewH), left: 0, bottom: 0, right: 0)
        
    }
    
}

// MARK:- CollectionViewdataSource协议
extension RecommendViewController : UICollectionViewDelegateFlowLayout {
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.section == 1 {
            
            let prettyCell = collectionView.dequeueReusableCell(withReuseIdentifier: kPrettyCellID, for: indexPath) as! CollectionPrettyCell
            
            prettyCell.anchor = recommendViewModel.anchorGroups[indexPath.section].anchors[indexPath.item]
            
            return prettyCell
        } else {
            return super.collectionView(collectionView, cellForItemAt: indexPath)
        }

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
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if indexPath.section == 1 {
            return CGSize(width: kNormalItemW, height: kPrettyItemH)
        }
        
        return CGSize(width: kNormalItemW, height: kNormalItemH)
    }
    
}
