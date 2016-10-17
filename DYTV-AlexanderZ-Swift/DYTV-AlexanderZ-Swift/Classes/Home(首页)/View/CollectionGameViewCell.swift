//
//  CollectionGameViewCell.swift
//  DYTV-AlexanderZ-Swift
//
//  Created by Alexander Zou on 2016/10/14.
//  Copyright © 2016年 Alexander Zou. All rights reserved.
//

import UIKit

class CollectionGameViewCell: UICollectionViewCell {

    
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var label: UILabel!
    
    var baseGame : BaseGameModel? {
        didSet {
            label.text = baseGame?.tag_name
            if let iconURL = URL(string: baseGame?.icon_url ?? "") {
                imageView.kf.setImage(with: iconURL)
            } else {
                imageView.image = UIImage(named: "home_more_btn")
            }
        }
    }
    

}
