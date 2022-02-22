//
//  AmuseViewModel.swift
//  ZO
//
//  Created by dousei hann on 2022/2/21.
//

import UIKit

class AmuseViewModel: BaseAnchorViewModel {
    
}

extension AmuseViewModel {
    func requsetData(finishCallback:@escaping () -> ()) {
        loadAnchorData(url: "http://capi.douyucdn.cn/api/v1/getHotRoom/2", finishCallback: finishCallback)
    }
}
