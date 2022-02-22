//
//  BaseAnchorViewModel.swift
//  ZO
//
//  Created by dousei hann on 2022/2/21.
//

import UIKit

class BaseAnchorViewModel {
    lazy var anchorGroup : [AnchorGroup] = [AnchorGroup]()
}

extension BaseAnchorViewModel {
    func loadAnchorData(url: String, paras: [String : String]? = nil, finishCallback:@escaping () -> ()) {
        NetWorkTools.requestForData(method: .GET, url: url, paras: paras) { resp in
            Log.D("\(resp)")
            guard let resultDict = resp as? [String : Any] else {return}
            
            guard let dataArray = resultDict["data"] as? [[String : Any]] else {return}
            
            for dic in dataArray {
                let group = AnchorGroup(dic: dic)
                self.anchorGroup.append(group)
            }
            
            self.anchorGroup = self.removeEmpty(anchorGroups: self.anchorGroup)
            
            finishCallback()
        }
    }
    
    func removeEmpty(anchorGroups: [AnchorGroup]) -> [AnchorGroup] {
        var newGroup: [AnchorGroup] = [AnchorGroup]()
        for group in anchorGroups {
            if group.anchors.count > 0 {
                newGroup.append(group)
            }
        }
        return newGroup
    }
}



