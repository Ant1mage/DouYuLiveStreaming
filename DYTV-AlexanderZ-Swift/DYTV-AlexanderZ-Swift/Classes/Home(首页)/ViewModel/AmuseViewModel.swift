//
//  AmuseViewModel.swift
//  DYTV-AlexanderZ-Swift
//
//  Created by Alexander Zou on 2016/10/17.
//  Copyright © 2016年 Alexander Zou. All rights reserved.
//

import UIKit

class AmuseViewModel : BaseViewModel {
}

extension AmuseViewModel {
    func loadAmuseData(finishedCallback : @escaping () -> ()) {
        loadAnchorData(isGroupData: true, URLString: "http://capi.douyucdn.cn/api/v1/getHotRoom/2", finishedCallback: finishedCallback)
    }
}
