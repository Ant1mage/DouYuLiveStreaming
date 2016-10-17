//
//  AmuseMenuViewCell.swift
//  DYTV-AlexanderZ-Swift
//
//  Created by Alexander Zou on 2016/10/17.
//  Copyright © 2016年 Alexander Zou. All rights reserved.
//

import UIKit

private let kGameCellID = "kGameCellID"

class AmuseMenuViewCell: UICollectionViewCell {
    
    var groups : [AnchorGroupModel]? {
        didSet {
            collectionView.reloadData()
        }
    }


    @IBOutlet weak var collectionView: UICollectionView!

    override func awakeFromNib() {
        super.awakeFromNib()
        
        collectionView.register(UINib(nibName: "CollectionGameViewCell", bundle: nil), forCellWithReuseIdentifier: kGameCellID)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        let itemW = collectionView.bounds.width / 4
        let itemH = collectionView.bounds.height / 2
        layout.itemSize = CGSize(width: itemW, height: itemH)
    }
}


extension AmuseMenuViewCell : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return groups?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kGameCellID, for: indexPath) as! CollectionGameViewCell
        
        cell.baseGame = groups![indexPath.item]
        cell.clipsToBounds = true
        
        return cell
    }
}
