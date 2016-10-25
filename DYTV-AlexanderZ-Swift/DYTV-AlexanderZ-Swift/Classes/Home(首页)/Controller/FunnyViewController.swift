//
//  FunnyViewController.swift
//  DYTV-AlexanderZ-Swift
//
//  Created by Alexander Zou on 2016/10/18.
//  Copyright © 2016年 Alexander Zou. All rights reserved.
//

import UIKit

private let kTopMargin : CGFloat = 8

class FunnyViewController: BaseAnchorViewController {
    
    fileprivate lazy var funnyViewModel : FunnyViewModel = FunnyViewModel()
}


extension FunnyViewController {
    override func setupUI() {
        super.setupUI()
        
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.headerReferenceSize = CGSize.zero
        collectionView.contentInset = UIEdgeInsets(top: kTopMargin, left: 0, bottom: 0, right: 0)
    }
}


extension FunnyViewController {
    override func loadData() {
        
        baseViewModel = funnyViewModel
        
        funnyViewModel.loadFunnyData {
            
            self.collectionView.reloadData()
            
            self.loadDataFinished()
            
        }
    }
}

