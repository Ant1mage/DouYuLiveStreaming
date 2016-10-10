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

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    var cycleModel : CycleModel? {
        didSet {
            titleLabel.text = cycleModel?.title
            let iconURL = NSURL(string: cycleModel?.pic_url ?? "")!
            imageView.kf_setImageWithURL(iconURL, placeholderImage: UIImage(named: "Img_default"))
        }
    }
    
}
