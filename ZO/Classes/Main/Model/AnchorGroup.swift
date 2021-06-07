//
//  AnchorGroup.swift
//  ZO
//
//  Created by yons on 2021/6/7.
//  直播分组数据

import UIKit

class AnchorGroup: NSObject {

    //分组的名字
    var tag_name : String = ""
    //分组的图标
    var icon_url : String = "home_header_normal"
    //分组的房间信息
    var room_list : [[String:NSObject]]?{
        didSet{
            guard let rooms = room_list else {return}
            for anchor in rooms {
                anchors.append(SingleAnchor(dict: anchor))
            }
        }
    }
    //主播信息
    var anchors : [SingleAnchor] = [SingleAnchor]()
    
    
    init(dict : [String:NSObject]) {
        super.init()
        
        setValuesForKeys(dict)
    }
    
    override class func setValue(_ value: Any?, forUndefinedKey key: String) {
      //无事发生
    }
}
