//
//  CycleModel.swift
//  ZO
//
//  Created by dousei hann on 2022/2/16.
//  轮播模型

import UIKit

@objcMembers
class CycleModel: NSObject {

    var title : String = ""
    var pic_url : String = ""
    var room : [String : NSObject]? {
        didSet {
            guard let room = room else {
                return
            }
            anchor = SingleAnchor(dict: room)
        }
    }
    
    var anchor : SingleAnchor?
    
    init(dic: [String:Any]) {
        super.init()
        setValuesForKeys(dic)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
    
}
