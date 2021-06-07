//
//  SingleAnchor.swift
//  ZO
//
//  Created by yons on 2021/6/7.
//  单个主播信息

import UIKit

class SingleAnchor: NSObject {

    //房间ID
    var room_id : Int = 0
    //房间图标URl
    var vertical_src : String = ""
    //0：电脑直播， 1 ： 手机直播
    var isVertical : Int = 0
    //房间名称
    var room_name : String = ""
    //主播昵称
    var nickname : String = ""
    //观看人数
    var online : Int = 0
    
    init(dict : [String:NSObject]) {
        super.init()
        setValuesForKeys(dict)
    }
    
    override class func setValue(_ value: Any?, forUndefinedKey key: String) {
        //无事发生
    }
}
