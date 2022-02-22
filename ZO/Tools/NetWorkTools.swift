//
//  NetWorkTools.swift
//  ZO
//
//  Created by yons on 2021/5/26.
//  简单的网络请求封装

import UIKit
import Alamofire

enum RequestMethod {
    case GET
    case POST
}

class NetWorkTools: NSObject {
    public typealias finishCallback = (_ resp : AnyObject) -> ()

    class func requestForData(method : RequestMethod, url : String ,paras: [String : String]? = nil, callback:@escaping finishCallback) {
       
        let httpMethod = method == RequestMethod.GET ? HTTPMethod.get : HTTPMethod.post
        
        AF.request(url ,method: httpMethod, parameters: paras).responseJSON { (result) in
            guard  let resp = result.value else {
                print(result.error as Any)
                return
            }
            
            callback(resp as AnyObject)
        }
    }
}
