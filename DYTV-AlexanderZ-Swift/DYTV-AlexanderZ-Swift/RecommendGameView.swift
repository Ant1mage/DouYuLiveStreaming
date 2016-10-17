//
//  RecommendGameView.swift
//  DYTV-AlexanderZ-Swift
//
//  Created by Alexander Zou on 2016/10/14.
//  Copyright © 2016年 Alexander Zou. All rights reserved.
//

import UIKit
private let kGameViewCellID = "kGameViewCellID"
private let kEdgeInsetMargin : CGFloat = 10

class RecommendGameView: UIView {
    
    var groups : [BaseGameModel]? {
        didSet {
            
            collectionView.reloadData()
        }
    }
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        autoresizingMask = UIViewAutoresizing()
        
        collectionView.dataSource = self
        
        collectionView.register(UINib(nibName: "CollectionGameViewCell", bundle: nil), forCellWithReuseIdentifier: kGameViewCellID)
        
        collectionView.contentInset = UIEdgeInsets(top: 0, left: kEdgeInsetMargin, bottom: 0, right: kEdgeInsetMargin)
        
    }
    
    
}

extension RecommendGameView {
    class func recommendGameView() -> RecommendGameView {

        return Bundle.main.loadNibNamed("RecommendGameView", owner: nil, options: nil)?.first as! RecommendGameView
    }
}

extension RecommendGameView : UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return groups?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kGameViewCellID, for: indexPath) as! CollectionGameViewCell
        
        cell.baseGame = groups![(indexPath as NSIndexPath).item]
        
        return cell
        
    }

}
