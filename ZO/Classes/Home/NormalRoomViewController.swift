//
//  NormalRoomViewController.swift
//  ZO
//
//  Created by dousei hann on 2022/2/24.
//  使用电脑直播

import UIKit

class NormalRoomViewController: UIViewController, UIGestureRecognizerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.purple
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //隐藏导航栏（此行为会移除系统默认的pop手势）
        navigationController?.setNavigationBarHidden(true, animated: true)
        //重新添加pop手势
        navigationController?.interactivePopGestureRecognizer?.delegate = self
        navigationController?.interactivePopGestureRecognizer?.isEnabled = true
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
}
