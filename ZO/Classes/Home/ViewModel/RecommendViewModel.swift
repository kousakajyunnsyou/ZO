//
//  RecommendViewModel.swift
//  ZO
//
//  Created by yons on 2021/5/27.
//  推荐页的ViewModel

import UIKit

class RecommendViewModel: BaseAnchorViewModel{
    //分组信息
    //热门
    private lazy var hotAnchorGroup : AnchorGroup = AnchorGroup()
    private lazy var beautyAnchorGroup : AnchorGroup = AnchorGroup()
    //无限轮播数据
    lazy var cycleDatas : [CycleModel] = [CycleModel]()
}

//MARK: 发送网络请求
extension RecommendViewModel {
    //请求主播展示数据
    func requsetData(finishCallback : @escaping () -> ()) {
        //共同参数定义
        let parameters = ["limit" : "4","offset" : "0", "time" : NSDate.getCurrentDate() ]
        
        let disGroup = DispatchGroup()
        //请求推荐数据
        //http://capi.douyucdn.cn/api/v1/getbigDataRoom?time=1623052788
        disGroup.enter()
        NetWorkTools.requestForData(method: .GET, url: "http://capi.douyucdn.cn/api/v1/getbigDataRoom?time=1623052788", paras: parameters) { (resp) in

            guard let resultDict  = resp as? [String : Any] else {return}
            
            guard let dataArray = resultDict["data"] as? [[String : Any]] else {return}
            
            self.hotAnchorGroup.tag_name = "热门"
            self.hotAnchorGroup.icon_name = "home_header_hot"
            
            for dic in dataArray {
                let anchor = SingleAnchor(dict: dic)
                self.hotAnchorGroup.anchors.append(anchor)
            }
            Log.D("\(resp)")
            disGroup.leave()
        }
        
        //请求颜值数据
        //http://capi.douyucdn.cn/api/v1/getVerticalRoom?limit=4&offset=0&time=1623052788
        disGroup.enter()
        NetWorkTools.requestForData(method: .GET, url: "http://capi.douyucdn.cn/api/v1/getVerticalRoom", paras: parameters) { (resp) in

            guard let resultDict  = resp as? [String : Any] else {return}
            
            guard let dataArray = resultDict["data"] as? [[String : Any]] else {return}
            
            self.beautyAnchorGroup.tag_name = "颜值"
            self.beautyAnchorGroup.icon_name = "home_header_phone"
            
            for dic in dataArray {
                let anchor = SingleAnchor(dict: dic)
                self.beautyAnchorGroup.anchors.append(anchor)
            }

            disGroup.leave()
        }
        
        //请求后面其他游戏数据

        //http://capi.douyucdn.cn/api/v1/getHotCate?limit=4&offset=0&time=1623052788
        disGroup.enter()
        loadAnchorData(url: "http://capi.douyucdn.cn/api/v1/getHotCate", paras: parameters, finishCallback: {
            disGroup.leave()
        })
        
        disGroup.notify(queue: DispatchQueue.main) {
            self.anchorGroup.insert(self.beautyAnchorGroup, at: 0)
            self.anchorGroup.insert(self.hotAnchorGroup, at: 0)
            finishCallback()
        }
    }
    
    //请求无限轮播数据
    func requestCycleData(finishCallback: @escaping () -> ()) {
        NetWorkTools.requestForData(method: .GET, url: "http://www.douyutv.com/api/v1/slide/6", paras: ["version" : "2.300"]) { resp in

            guard let resultDict = resp as? [String : NSObject] else { return }
            
            guard let dataArray = resultDict["data"] as? [[String : NSObject]] else { return }
            
            for data in dataArray {
                self.cycleDatas.append(CycleModel(dic: data))
            }
            
            finishCallback()
        }
    }
}
