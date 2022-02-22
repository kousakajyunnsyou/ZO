//
//  BaseGameModel.swift
//  ZO
//
//  Created by dousei hann on 2022/2/19.
//

import UIKit

@objcMembers
class BaseGameModel: NSObject {
    
    var tag_name: String = ""
    var icon_url: String = ""
    
    override init() { }
    
    init(dic: [String : Any]) {
        super.init()
        
        setValuesForKeys(dic)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) { }
}
