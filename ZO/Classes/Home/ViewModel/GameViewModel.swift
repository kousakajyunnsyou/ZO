//
//  GameViewModel.swift
//  ZO
//
//  Created by dousei hann on 2022/2/19.
//

import UIKit

class GameViewModel{
    lazy var games: [GameModel] = [GameModel]()
}

extension GameViewModel {
    
    //请求游戏数据
    func requestGameData(finiskCallback: @escaping () -> ()) {
        NetWorkTools.requestForData(method: .GET, url: "http://capi.douyucdn.cn/api/v1/getColumnDetail") { resp in
            
            guard let result = resp as? [String : Any] else { return }
            guard let dictArray = result["data"] as? [[String : Any]] else { return }
            
            for data in dictArray {
                self.games.append(GameModel(dic: data))
            }
            
            finiskCallback()
        }
    }
}
