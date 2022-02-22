//
//  AnchorGroup.swift
//  ZO
//
//  Created by yons on 2021/6/7.
//  直播分组数据

import UIKit

class AnchorGroup: BaseGameModel {
    
    var icon_name : String = "home_header_normal"
    
    //分组的房间信息
    var room_list : [[String : Any]]? {
        didSet{
            guard let rooms = room_list else {return}
            for anchor in rooms {
                anchors.append(SingleAnchor(dict: anchor))
            }
        }
    }
    //主播信息
    var anchors : [SingleAnchor] = [SingleAnchor]()
}
