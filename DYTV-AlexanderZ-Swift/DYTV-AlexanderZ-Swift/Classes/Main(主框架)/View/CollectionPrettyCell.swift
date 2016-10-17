//
//  CollectionPrettyCell.swift
//  DYTV-AlexanderZ-Swift
//
//  Created by Alexander Zou on 16/9/26.
//  Copyright © 2016年 Alexander Zou. All rights reserved.
//

import UIKit
import Kingfisher

class CollectionPrettyCell: CollectionBaseCell {
    
    @IBOutlet weak var cityBtn: UIButton!
    
    override var anchor : AnchorModel? {
        didSet {
            
            super.anchor = anchor
            
            // 所在的城市
            cityBtn.setTitle(anchor?.anchor_city, for: .normal)
        }
    }
    
}
