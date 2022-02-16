//
//  UIColor-Extension.swift
//  ZO
//
//  Created by yons on 2021/4/28.
//

import UIKit
extension UIColor {
    
    //便利初始化方法
    convenience init(red: CGFloat, green: CGFloat, blue: CGFloat) {
        self.init(red: red/255, green: green/255, blue: blue/255, alpha: 1.0)
    }
    
    //提供一个随机颜色
    class func randomColor() -> UIColor {
        let color = UIColor(red: CGFloat(arc4random_uniform(255)), green: CGFloat(arc4random_uniform(255)), blue: CGFloat(arc4random_uniform(255)))
        return color
    }
}


