//
//  CustomViewController.swift
//  ZO
//
//  Created by dousei hann on 2022/2/24.
//

import UIKit

class CustomViewController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        viewController.hidesBottomBarWhenPushed = true
        
        super.pushViewController(viewController, animated: animated)
    }

}
