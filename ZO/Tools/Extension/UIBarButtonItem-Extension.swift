//
//  UIBarButtonItem-Extension.swift
//  ZO
//
//  Created by yons on 2021/4/21.
//

import UIKit

extension UIBarButtonItem {
    class func createItem(imageName: String, hightImageName: String, size: CGSize) -> UIBarButtonItem {
        
        let btn = UIButton()
        //普通模式图片
        btn.setImage(UIImage(named: imageName), for: .normal)
        //选中模式图片
        btn.setImage(UIImage(named: hightImageName), for: .highlighted)
        //按钮尺寸
        btn.frame = CGRect(origin: CGPoint.zero, size: size)
        
        return UIBarButtonItem(customView: btn)
    }
    
    convenience init(imageName: String, hightImageName: String, size: CGSize) {
        let btn = UIButton()
        //普通模式图片
        btn.setImage(UIImage(named: imageName), for: .normal)
        //选中模式图片
        btn.setImage(UIImage(named: hightImageName), for: .highlighted)
        //按钮尺寸
        btn.frame = CGRect(origin: CGPoint.zero, size: size)
        
        self.init(customView: btn)
    }
}
