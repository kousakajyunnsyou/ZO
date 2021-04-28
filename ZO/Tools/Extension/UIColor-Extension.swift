//
//  UIColor-Extension.swift
//  ZO
//
//  Created by yons on 2021/4/28.
//

import UIKit
extension UIColor {
    
    convenience init(red: CGFloat, green: CGFloat, blue: CGFloat) {
        self.init(red: red/255, green: green/255, blue: blue/255, alpha: 1.0)
    }
}
