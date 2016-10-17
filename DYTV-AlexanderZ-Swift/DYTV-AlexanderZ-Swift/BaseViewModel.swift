//
//  BaseViewModel.swift
//  DYTV-AlexanderZ-Swift
//
//  Created by Alexander Zou on 2016/10/14.
//  Copyright © 2016年 Alexander Zou. All rights reserved.
//

import UIKit

class BaseViewModel {
    lazy var anchorGroups : [AnchorGroupModel] = [AnchorGroupModel]()
}


extension BaseViewModel {
    func loadAnchorData(isGroupData : Bool, URLString : String, parameters : [String : Any]? = nil, finishedCallback : @escaping () -> ()) {
        NetworkTools.requestData(.get, URLString: URLString, parameters: parameters) { (result) in
            
            guard let resultDict = result as? [String : Any] else { return }
            guard let dataArray = resultDict["data"] as? [[String : Any]] else { return }
            
            
            if isGroupData {
                
                for dict in dataArray {
                    self.anchorGroups.append(AnchorGroupModel(dict: dict))
                }
            } else  {
                
                let group = AnchorGroupModel()
                
                for dict in dataArray {
                    group.anchors.append(AnchorModel(dict: dict as! [String : NSObject]))
                }
                
                self.anchorGroups.append(group)
            }
            
            finishedCallback()
        }
    }
}
