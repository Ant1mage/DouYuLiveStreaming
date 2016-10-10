//
//  RecommendViewModel.swift
//  DYTV-AlexanderZ-Swift
//
//  Created by Alexander Zou on 16/9/30.
//  Copyright © 2016年 Alexander Zou. All rights reserved.
//

import UIKit

class RecommendViewModel {
    
    // 懒加载属性
    lazy var anchorGroups : [AnchorGroupModel] = [AnchorGroupModel]()
    lazy var cycleModels : [CycleModel] = [CycleModel]()
    private lazy var bigDataGroup : AnchorGroupModel = AnchorGroupModel()
    private lazy var prettyGroup : AnchorGroupModel = AnchorGroupModel()
    

}

// 发送网络请求
extension RecommendViewModel {
    
    // 请求推荐数据
    func requestData(finishCallback : () -> ()) {
        
        let parameters = ["limit" : "4", "offset" : "0", "time" : NSDate.getCurrentTime()]
        
        // 创建组
        let axGroup = dispatch_group_create()
        
        // 推荐数据
        dispatch_group_enter(axGroup)
        NetworkTools.requestData(.GET, URLString: "http://capi.douyucdn.cn/api/v1/getbigDataRoom", parameters: ["time" : NSDate.getCurrentTime()]) { (result) in
            
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
            
            dispatch_group_leave(axGroup)
        }
        
        
        
        // 颜值数据
        dispatch_group_enter(axGroup)
        NetworkTools.requestData(.GET, URLString: "http://capi.douyucdn.cn/api/v1/getVerticalRoom", parameters: parameters) { (result) in
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
            dispatch_group_leave(axGroup)
        }
        
        
        
        // 游戏数据
        dispatch_group_enter(axGroup)
        NetworkTools.requestData(.GET, URLString: "http://capi.douyucdn.cn/api/v1/getHotCate", parameters: parameters) { (result) in
            
//            print(result)
            
            // 数据转字典
            guard let resultDict = result as? [String : NSObject] else { return }
            
            // 根据key获取数组
            guard let dataArray =  resultDict["data"] as? [[String : NSObject]] else { return }
            
            
            // 遍历数组 转模型
            for dict in dataArray {
                
                // KVC转模型
                let group = AnchorGroupModel(dict:dict)
                self.anchorGroups.append(group)
                
            }
            dispatch_group_leave(axGroup)
        }
        
        dispatch_group_notify(axGroup, dispatch_get_main_queue()) { 
            self.anchorGroups.insert(self.prettyGroup, atIndex: 0)
            self.anchorGroups.insert(self.bigDataGroup, atIndex: 0)
            
            finishCallback()
        }

    }
    
    // 无限轮播数据
    func requestCycleData(finishCallback : () -> ()) {
        NetworkTools.requestData(.GET, URLString: "http://www.douyutv.com/api/v1/slide/6", parameters: ["version" : "2.300"]) { (result) in

            guard let resultDict = result as? [String : NSObject] else { return }
            
            guard let dataArray = resultDict["data"] as? [[String : NSObject]] else { return }
            
            for dict in dataArray {
                self.cycleModels.append(CycleModel(dict: dict))
            }
            
            finishCallback()
        }
    }
    
}
