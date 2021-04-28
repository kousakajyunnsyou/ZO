//
//  Common.swift
//  ZO
//
//  Created by yons on 2021/4/23.
//  常量定义

import UIKit


let statusBarManager = UIApplication.shared.windows.first?.windowScene?.statusBarManager

//状态栏高度
let KStatusBarH : CGFloat = statusBarManager?.statusBarFrame.size.height ?? 0
//导航栏高度
let KNavigationH : CGFloat = 44
//屏幕宽度
let KScreenW = UIScreen.main.bounds.width
//屏幕高度
let KScreenH = UIScreen.main.bounds.height
