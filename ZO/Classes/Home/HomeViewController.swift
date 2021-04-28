//
//  HomeViewController.swift
//  ZO
//
//  Created by yons on 2021/4/21.
//  首页

import UIKit

class HomeViewController: UIViewController {
    
    // MARK: 画面基础元素
    
    //滚动标题高度
    private let KTitleViewH : CGFloat = 40
    
    //滚动标题初始化
    private lazy var homeTitles : PageTitleView = {
        let titleFrame = CGRect(x: 0, y: KStatusBarH + KNavigationH, width: KScreenW, height: KTitleViewH)
        let titles = ["推荐","游戏","娱乐","趣玩"]
        let titleView = PageTitleView(frame: titleFrame, titles: titles)
        return titleView
    }()
    //与滚标题对应的控制器
    private lazy var contentView : PageContentView = {
        //布局
        let frameH: CGFloat = KScreenH - KStatusBarH - KNavigationH - KTitleViewH
        let frame = CGRect(x: 0, y: KStatusBarH + KNavigationH + KTitleViewH, width: KScreenW, height: frameH)
        
        //子控制器
        var childVCs = [UIViewController]()
        for _ in 0..<4 {
            let vc = UIViewController()
            vc.view.backgroundColor = UIColor(red: CGFloat(arc4random_uniform(255)), green: CGFloat(arc4random_uniform(255)), blue: CGFloat(arc4random_uniform(255)))
            childVCs.append(vc)
        }
        
        let contentView = PageContentView(frame: frame, childViews: childVCs, paraentView: self)
        return contentView
    }()
    
    //MARK: 系统回调函数
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }
    

}

// MARK: 设置UI界面
extension HomeViewController {
    fileprivate func setupUI() {
        //设置导航栏
        setupNavigationBar()
        view.addSubview(homeTitles)
        view.addSubview(contentView)
    }
    //导航栏
    private func setupNavigationBar() {
        //左侧LOGO
        let logoBtn = UIButton()
        logoBtn.setImage(UIImage(named: "ad_launch_upLogo_66x30_"), for: .normal)
        logoBtn.sizeToFit()
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: logoBtn)
        
        /*右侧按钮定义*/
        //按钮大小
        let size = CGSize(width: 40, height: 40)
    
        //历史记录 --通过扩展定义类方法
        let historyItem = UIBarButtonItem.createItem(imageName: "navi_history_selected", hightImageName: "navi_history_normal", size: size)
        //搜索    --通过扩展定义初始化方法
        let searchItem = UIBarButtonItem(imageName: "navi_search_selected", hightImageName: "navi_search_normal", size: size)
        //二维码扫描  --直接写法
        let QRcodeBtn = UIButton()
        QRcodeBtn.setImage(UIImage(named: "navi_qr_selected"), for: .normal)
        QRcodeBtn.setImage(UIImage(named: "navi_qr_normal"), for: .highlighted)
        QRcodeBtn.frame = CGRect(origin: CGPoint.zero, size: size)
        let QRcodeItem = UIBarButtonItem(customView: QRcodeBtn)
        
        navigationItem.rightBarButtonItems = [historyItem,searchItem,QRcodeItem]
    }
}
