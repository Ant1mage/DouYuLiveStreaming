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
    
    fileprivate lazy var topHeaderView : CollectionHeaderView = {
        
        let headerView = CollectionHeaderView.collectionHeaderView()
        headerView.frame = CGRect(x: 0, y: -(kHeaderH + kGameViewH), width: kScreenW, height: kHeaderH)
        headerView.iconImageView.image = UIImage(named:"Img_orange")
        headerView.titleLabel.text = "常用"
        headerView.moreButton.isHidden = true
        return headerView
    }()
    fileprivate lazy var gameDetailViewModel : GameDetailViewModel = GameDetailViewModel()
    fileprivate lazy var collectionView : UICollectionView = {[unowned self] in
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: kItemW, height: kItemH)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = UIEdgeInsets(top: 0, left: kEdgeMargin, bottom: 0, right: kEdgeMargin)
        layout.headerReferenceSize = CGSize(width: kScreenW, height: kHeaderH)
        
        
        let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.white
        collectionView.register(UINib(nibName: "CollectionGameViewCell", bundle: nil), forCellWithReuseIdentifier: "kGameCellID")
        collectionView.register(UINib(nibName: "CollectionHeaderView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: kGameHeaderID)
        collectionView.dataSource = self
        collectionView.autoresizingMask = [.flexibleWidth,.flexibleHeight]
        
        return collectionView
    }()
    fileprivate lazy var gameView : RecommendGameView = {
       
        let gameView = RecommendGameView.recommendGameView()
        gameView.frame = CGRect(x: 0, y:-kGameViewH , width: kScreenW, height: kGameViewH)
        
        return gameView
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        loadData()
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension GameViewController {
    
    func loadData() {
        
        gameDetailViewModel.loadData {
            self.collectionView.reloadData()
            
            self.gameView.groups = Array(self.gameDetailViewModel.games[0..<10])
        }
        
    }
    
    
}

extension GameViewController {
    
    override func setupUI() {
        
        contentView = collectionView
        view.addSubview(collectionView)
        collectionView.addSubview(topHeaderView)
        collectionView.addSubview(gameView)
        collectionView.contentInset = UIEdgeInsets(top: kHeaderH+kGameViewH, left: 0, bottom: 0, right: 0)
        super.setupUI()
    }
    
}

extension GameViewController : UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return gameDetailViewModel.games.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kGameCellID, for: indexPath) as! CollectionGameViewCell
        
        cell.baseGame = gameDetailViewModel.games[indexPath.item]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let hearderView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: kGameHeaderID, for: indexPath)as! CollectionHeaderView
        
        hearderView.titleLabel.text = "全部"
        hearderView.iconImageView.image = UIImage(named: "Img_orange")
        hearderView.moreButton.isHidden = true
        return hearderView
        
    }
}
