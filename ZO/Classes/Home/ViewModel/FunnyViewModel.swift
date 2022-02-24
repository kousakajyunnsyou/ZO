//
//  FunnyViewModel.swift
//  ZO
//
//  Created by dousei hann on 2022/2/23.
//

import UIKit

class FunnyViewModel: BaseAnchorViewModel {

}


extension FunnyViewModel {
    func requsetData(finishCallback: @escaping () -> ()) {
        self.loadAnchorData(isGroup: false, url: "http://capi.douyucdn.cn/api/v1/getColumnRoom/2", paras: ["limit" : 30, "offset" : 0], finishCallback: finishCallback)
    }
}
