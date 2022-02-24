//
//  BaseAnchorViewModel.swift
//  ZO
//
//  Created by dousei hann on 2022/2/21.
//

import UIKit

class BaseAnchorViewModel {
    lazy var anchorGroup  : [AnchorGroup] = [AnchorGroup]()
}

extension BaseAnchorViewModel {
    
    //isGroup: 请求的数据是否进行了二次分组
    func loadAnchorData(isGroup: Bool = true, url: String, paras: [String : Any]? = nil, finishCallback:@escaping () -> ()) {
        NetWorkTools.requestForData(method: .GET, url: url, paras: paras) { resp in
            Log.D("\(resp)")
            guard let resultDict = resp as? [String : Any] else {return}
            
            guard let dataArray = resultDict["data"] as? [[String : Any]] else {return}
            
            if isGroup {
                for dic in dataArray {
                    let group = AnchorGroup(dic: dic)
                    self.anchorGroup.append(group)
                }
                
                self.anchorGroup = self.removeEmpty(anchorGroups: self.anchorGroup)
            }else {
                let gruop = AnchorGroup()
                for dic in dataArray {
                    gruop.anchors.append(SingleAnchor(dict: dic))
                }
                
                self.anchorGroup.append(gruop)
            }

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



