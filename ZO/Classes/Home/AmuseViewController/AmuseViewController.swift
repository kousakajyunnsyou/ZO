//
//  AmuseViewController.swift
//  ZO
//
//  Created by dousei hann on 2022/2/21.
//

import UIKit

class AmuseViewController: BaseAnchorViewController {

    fileprivate lazy var amuseVM: AmuseViewModel = AmuseViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
}

//MARK: 请求数据
extension AmuseViewController {
    override func loadData() {
        baseAnchorVM = self.amuseVM
        amuseVM.requsetData {
            
            self.collectinView.reloadData()
        }
    }
}
