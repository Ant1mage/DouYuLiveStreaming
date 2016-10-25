//
//  GameViewController.swift
//  DYTV-AlexanderZ-Swift
//
//  Created by Alexander Zou on 2016/10/17.
//  Copyright © 2016年 Alexander Zou. All rights reserved.
//

import UIKit

private let kEdgeMargin : CGFloat = 10
private let kItemW : CGFloat = (kScreenW - 2 * kEdgeMargin) / 3
private let kItemH : CGFloat = kItemW * 6 / 5
private let kHeaderH : CGFloat = 50
private let kGameViewH : CGFloat = 90

private let kGameCellID = "kGameCellID"
private let kGameHeaderID = "kGameHeaderID"

class GameViewController: BaseViewController {
    
    fileprivate lazy var gameViewModel : GameDetailViewModel = GameDetailViewModel()
    
    fileprivate lazy var collectionView : UICollectionView = {[unowned self] in
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: kItemW, height: kItemH)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = UIEdgeInsets(top: 0, left: kEdgeMargin, bottom: 0, right: kEdgeMargin)
        layout.headerReferenceSize = CGSize(width: kScreenW, height: kHeaderH)
        
        
        let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.white
        collectionView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        collectionView.register(UINib(nibName: "CollectionGameViewCell", bundle: nil), forCellWithReuseIdentifier: kGameCellID)
        collectionView.register(UINib(nibName: "CollectionHeaderView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: kGameHeaderID)
        collectionView.dataSource = self
        
        return collectionView
        }()
    
    fileprivate lazy var topHeaderView : CollectionHeaderView = {
        let headerView = CollectionHeaderView.collectionHeaderView()
        headerView.frame = CGRect(x: 0, y: -(kHeaderH + kGameViewH), width: kScreenW, height: kHeaderH)
        headerView.iconImageView.image = UIImage(named: "Img_orange")
        headerView.titleLabel.text = "常见"
        headerView.moreButton.isHidden = true
        return headerView
    }()
    
    fileprivate lazy var gameView : RecommendGameView = {
        let gameView = RecommendGameView.recommendGameView()
        gameView.frame = CGRect(x: 0, y: -kGameViewH, width: kScreenW, height: kGameViewH)
        return gameView
    }()
    
    // MARK: 系统回调
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        loadData()
    }
    
}


// MARK:- 设置UI界面
extension GameViewController {
    override func setupUI() {
        
        contentView = collectionView
        
        view.addSubview(collectionView)
        
        collectionView.addSubview(topHeaderView)
        
        collectionView.addSubview(gameView)
        
        // 设置collectionView的内边距
        collectionView.contentInset = UIEdgeInsets(top: kHeaderH + kGameViewH, left: 0, bottom: 0, right: 0)
        
        super.setupUI()
    }
}


// MARK:- 请求数据
extension GameViewController {
    fileprivate func loadData() {
        gameViewModel.loadAllGameData {
            
            self.collectionView.reloadData()
            
            self.gameView.groups = Array(self.gameViewModel.games[0..<10])
            
            self.loadDataFinished()
        }
    }
}


// MARK:- 遵守UICollectionView的数据源&代理
extension GameViewController : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return gameViewModel.games.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kGameCellID, for: indexPath) as! CollectionGameViewCell
        
        cell.baseGame = gameViewModel.games[indexPath.item]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: kGameHeaderID, for: indexPath) as! CollectionHeaderView
        
        headerView.titleLabel.text = "全部"
        headerView.iconImageView.image = UIImage(named: "Img_orange")
        headerView.moreButton.isHidden = true
        
        return headerView
    }
}
