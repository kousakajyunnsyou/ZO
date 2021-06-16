//
//  Log.swift
//  ZO
//
//  Created by yons on 2021/6/16.
//

import UIKit

struct Log{

    static func D(_ message: String, _ args: CVarArg..., file: String = #file, function: String = #function, line: Int = #line) {
        var filename = file
        if let match = filename.range(of: "[^/]*$", options: .regularExpression) {
            filename = String(filename[match])
        }
        NSLog("#D %@:%d:%@:%@",filename,line,function,String(format:message,arguments: args))
    }
    static func API(_ format: String, _ args: CVarArg...){
            NSLog(String(format: "#A " + format, arguments: args))
    }
    static func WEB(_ format: String, _ args: CVarArg...){
            NSLog(String(format: "#W " + format, arguments: args))
    }
    
    // テストコードのログ DebugForDevelopとDebugで出力
    static func TEST(format: String, _ args: CVarArg...){
            NSLog(String(format: "#T " + format, arguments: args))
    }
}
