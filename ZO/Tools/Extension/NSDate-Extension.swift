//
//  NSDate-Extension.swift
//  ZO
//
//  Created by yons on 2021/6/7.
//

import Foundation

extension NSDate {
    
    //从1970至今经过的秒数
    class func getCurrentDate() -> String {
        let nowDate = NSDate()
        
        let interval = Int(nowDate.timeIntervalSince1970)
        return "\(interval)"
    }
}
