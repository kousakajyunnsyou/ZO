//
//  HomeViewController.swift
//  ZO
//
//  Created by yons on 2021/4/21.
//

import UIKit

class HomeViewController: UIViewController {

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
    }
    
    private func setupNavigationBar() {
        //左侧LOGO
        let logoBtn = UIButton()
        logoBtn.setImage(UIImage(named: "ad_launch_upLogo_66x30_"), for: .normal)
        logoBtn.sizeToFit()
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: logoBtn)
        
        //右侧按钮
        let size = CGSize(width: 40, height: 40)
    
        //历史记录
        let historyItem = UIBarButtonItem.createItem(imageName: "navi_history_selected", hightImageName: "navi_history_normal", size: size)
        //搜索
        let searchItem = UIBarButtonItem(imageName: "navi_search_selected", hightImageName: "navi_search_normal", size: size)
        //二维码扫描
        let QRcodeBtn = UIButton()
        QRcodeBtn.setImage(UIImage(named: "navi_qr_selected"), for: .normal)
        QRcodeBtn.setImage(UIImage(named: "navi_qr_normal"), for: .highlighted)
        QRcodeBtn.frame = CGRect(origin: CGPoint.zero, size: size)
        let QRcodeItem = UIBarButtonItem(customView: QRcodeBtn)
        
        navigationItem.rightBarButtonItems = [historyItem,searchItem,QRcodeItem]
    }
}
