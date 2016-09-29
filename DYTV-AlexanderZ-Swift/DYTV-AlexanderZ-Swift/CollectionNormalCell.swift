//
//  CollectionNormalCell.swift
//  DYTV-AlexanderZ-Swift
//
//  Created by Alexander Zou on 16/9/26.
//  Copyright © 2016年 Alexander Zou. All rights reserved.
//

import UIKit

class CollectionNormalCell: CollectionBaseCell {
    
    // 拿到控件属性
    @IBOutlet weak var roomNameLabel: UILabel!
    
    
    override var anchor : AnchorModel? {
        didSet {
            
            super.anchor = anchor
            
            // 房间名称
            roomNameLabel.text = anchor?.room_name
        }
    }
    
}
