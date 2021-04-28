//
//  PageContentView.swift
//  ZO
//
//  Created by yons on 2021/4/28.
//  与滚动小标题对应的展示内容

import UIKit

class PageContentView: UIView {

    //MARK: 定义属性
    
    private var childViews: [UIViewController]
    private var paraentView: UIViewController
    
    /*自定义初始化方法
     *@param frame: 布局
     *@param childViews: 每个小标题对应的控制器
     *@param paraentView: 用于规定本视图从属的父控制器
     */
    init(frame: CGRect, childViews: [UIViewController], paraentView: UIViewController) {
        self.childViews = childViews
        self.paraentView = paraentView
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
