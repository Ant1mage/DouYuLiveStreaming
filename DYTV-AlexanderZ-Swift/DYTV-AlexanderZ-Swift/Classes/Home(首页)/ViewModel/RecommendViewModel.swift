//
//  RecommendViewModel.swift
//  DYTV-AlexanderZ-Swift
//
//  Created by Alexander Zou on 16/9/30.
//  Copyright © 2016年 Alexander Zou. All rights reserved.
//

import UIKit

class RecommendViewModel : BaseViewModel {
    
    lazy var cycleModels : [CycleModel] = [CycleModel]()
    fileprivate lazy var bigDataGroup : AnchorGroupModel = AnchorGroupModel()
    fileprivate lazy var prettyGroup : AnchorGroupModel = AnchorGroupModel()
    
    
}

// MARK:- 发送网络请求
extension RecommendViewModel {
    
    // 请求推荐数据
    func requestData(_ finishCallback : @escaping () -> ()) {
        
        let parameters = ["limit" : "4", "offset" : "0", "time" : Date.getCurrentTime()]
        
        // 创建组
        let axGroup = DispatchGroup()
        
        // 推荐数据
        axGroup.enter()
        NetworkTools.requestData(.get, URLString: "http://capi.douyucdn.cn/api/v1/getbigDataRoom", parameters: ["time" : Date.getCurrentTime()]) { (result) in
            // 数据转字典
            guard let resultDict = result as? [String : NSObject] else { return }
            
            // 根据key获取数组
            guard let dataArray =  resultDict["data"] as? [[String : NSObject]] else { return }
            
            // 遍历数组 转模型
            self.bigDataGroup.tag_name = "热门"
            self.bigDataGroup.icon_name = "home_header_hot"
            
            for dict in dataArray {
                let anchor = AnchorModel(dict:dict)
                self.bigDataGroup.anchors.append(anchor)
            }
            
            axGroup.leave()
        }
        
        
        
        // 颜值数据
        axGroup.enter()
        NetworkTools.requestData(.get, URLString: "http://capi.douyucdn.cn/api/v1/getVerticalRoom", parameters: parameters as [String : NSString]?) { (result) in
//            print(result)
            // 数据转字典
            guard let resultDict = result as? [String : NSObject] else { return }
            
            // 根据key获取数组
            guard let dataArray =  resultDict["data"] as? [[String : NSObject]] else { return }
            
            // 遍历数组 转模型
            self.prettyGroup.tag_name = "颜值"
            self.prettyGroup.icon_name = "home_header_phone"
            
            for dict in dataArray {
                let anchor = AnchorModel(dict:dict)
                self.prettyGroup.anchors.append(anchor)
            }
            axGroup.leave()
        }
        
        
        
        // 游戏数据
        axGroup.enter()
        loadAnchorData(isGroupData: true, URLString: "http://capi.douyucdn.cn/api/v1/getHotCate", parameters: parameters) {
            axGroup.leave()
        }
        
        axGroup.notify(queue: DispatchQueue.main) {
            self.anchorGroups.insert(self.prettyGroup, at: 0)
            self.anchorGroups.insert(self.bigDataGroup, at: 0)
            
            finishCallback()
        }
    }
    
    // 无限轮播数据
    func requestCycleData(_ finishCallback : @escaping () -> ()) {
        NetworkTools.requestData(.get, URLString: "http://www.douyutv.com/api/v1/slide/6", parameters: ["Version" : "2.300"]) { (result) in
            
            guard let resultDict = result as? [String : NSObject] else { return }
            
            guard let dataArray = resultDict["data"] as? [[String : NSObject]] else { return }
            
            for dict in dataArray {
                self.cycleModels.append(CycleModel(dict: dict))
            }
            
            finishCallback()
        }
    }
    
}
