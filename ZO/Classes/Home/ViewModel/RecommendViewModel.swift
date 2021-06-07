//
//  RecommendViewModel.swift
//  ZO
//
//  Created by yons on 2021/5/27.
//  推荐页的ViewModel

import UIKit

class RecommendViewModel{
    //分组信息
    private lazy var anchorGroup : [AnchorGroup] = [AnchorGroup]()
}

//MARK: 发送网络请求
extension RecommendViewModel {
    func requsetData() {
        //请求推荐数据
        
        //请求颜值数据
        
        //请求后面其他游戏数据

        //http://capi.douyucdn.cn/api/v1/getHotCate?limit=4&offset=0&time=1623052788
        NetWorkTools.requestForData(method: .GET, url: "http://capi.douyucdn.cn/api/v1/getHotCate", paras: ["limit" : "4","offset" : "0", "time" : NSDate.getCurrentDate() ]) { (resp) in
            
            guard let resultDict = resp as? [String : NSObject] else {return}
            
            guard let dataArray = resultDict["data"] as? [[String:NSObject]] else {return}
            
            for dic in dataArray {
                let group = AnchorGroup.init(dict: dic)
                self.anchorGroup.append(group)
            }
        }
    }
}
