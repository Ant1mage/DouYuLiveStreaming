//
//  GameViewModel.swift
//  DYTV-AlexanderZ-Swift
//
//  Created by Alexander Zou on 2016/10/17.
//  Copyright © 2016年 Alexander Zou. All rights reserved.
//

import UIKit

class GameDetailViewModel  {
    
    lazy var games : [GameDetailModel] = [GameDetailModel]()
    
    

}

extension GameDetailViewModel {
    
    func loadData(_ finishedCallback : @escaping () -> ()) {
        
        let URLString = "http://capi.douyucdn.cn/api/v1/getColumnDetail"
        
        let parameters = ["shortName" : "game"]
        
        NetworkTools.requestData(.get, URLString: URLString, parameters: parameters as [String : String]) { (result) in
            
            guard let resultDict = result as? [String : Any] else { return }
            guard let dataArray = resultDict["data"] as? [[String : Any]] else { return }
            
            // 字典转模型
            for dict in dataArray {
                self.games.append(GameDetailModel(dict:dict))
                
            }
            
            finishedCallback()
            
        }
        
    }
    
    
    
}
