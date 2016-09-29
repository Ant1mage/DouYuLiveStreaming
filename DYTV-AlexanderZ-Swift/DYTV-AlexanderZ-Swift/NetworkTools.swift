//
//  NetworkTools.swift
//  DYTV-AlexanderZ-Swift
//
//  Created by Alexander Zou on 16/9/26.
//  Copyright © 2016年 Alexander Zou. All rights reserved.
//

import UIKit
import Alamofire

enum MethodType {
    case GET
    case POST
}

class NetworkTools {
    class func requestData(type : MethodType, URLString : String, parameters : [String : NSString]? = nil, finishedCallback : (result : AnyObject) -> ()) {
        
        let method = type == .GET ? Method.GET : Method.POST
        
        Alamofire.request(method, URLString, parameters: parameters).responseJSON { (response) in
            
            guard let result = response.result.value else {
                print(response.result.error)
                return
            }

            finishedCallback(result: result)
        }
    }
}
