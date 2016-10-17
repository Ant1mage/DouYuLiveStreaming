//
//  CollectionBaseCell.swift
//  DYTV-AlexanderZ-Swift
//
//  Created by Alexander Zou on 16/9/30.
//  Copyright © 2016年 Alexander Zou. All rights reserved.
//

import UIKit

class CollectionBaseCell: UICollectionViewCell {
    
    
    @IBOutlet weak var iconImageView: UIImageView!
    
    @IBOutlet weak var onlineBtn: UIButton!
    
    @IBOutlet weak var nickNameLabel: UILabel!
    
    var anchor : AnchorModel? {
        didSet {
            
        guard let anchor = anchor else { return }
        
        var onlineString : String = ""
        if anchor.online >= 10000 {
            onlineString = "\(Int(anchor.online / 10000))万在线"
        } else {
            onlineString = "\(anchor.online)人在线"
        }
        
        onlineBtn.setTitle(onlineString, for: .normal)
        
        nickNameLabel.text = anchor.nickname
        
            guard let iconURL = URL(string: anchor.vertical_src) else { return }
            iconImageView.kf.setImage(with: iconURL)

        }
    
    }
    
}
