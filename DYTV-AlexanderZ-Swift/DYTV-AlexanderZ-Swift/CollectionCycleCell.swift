//
//  CollectionCycleCell.swift
//  DYTV-AlexanderZ-Swift
//
//  Created by Alexander Zou on 16/10/10.
//  Copyright © 2016年 Alexander Zou. All rights reserved.
//

import UIKit
import Kingfisher
class CollectionCycleCell: UICollectionViewCell {
    
    

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    var cycleModel : CycleModel? {
        didSet {
            titleLabel.text = cycleModel?.title
            let iconURL = URL(string: cycleModel?.pic_url ?? "")!
            imageView.kf.setImage(with: iconURL, placeholder: UIImage(named: "Img_default"))
        }
    }
    
}
