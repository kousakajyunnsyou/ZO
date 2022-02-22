//
//  AmuseViewController.swift
//  ZO
//
//  Created by dousei hann on 2022/2/21.
//

import UIKit

private let KAmuseMenuH: CGFloat = 200

class AmuseViewController: BaseAnchorViewController {

    fileprivate lazy var amuseVM: AmuseViewModel = AmuseViewModel()
    fileprivate lazy var amuseMenu: AmuseMenuView = {
        let view = AmuseMenuView.amuseMenuView()
        view.frame = CGRect(x: 0, y: -KAmuseMenuH, width: KScreenW, height: KAmuseMenuH)
        return view
    }()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
}

//MARK: - 设置视图
extension AmuseViewController {
    override func setupUI() {
        super.setupUI()
        
        self.collectinView.addSubview(amuseMenu)
        collectinView.contentInset = UIEdgeInsets(top: KAmuseMenuH, left: 0, bottom: 0, right: 0)
    }
}

//MARK: 请求数据
extension AmuseViewController {
    override func loadData() {
        baseAnchorVM = self.amuseVM
        amuseVM.requsetData {
            
            self.collectinView.reloadData()
            
            //设置头部展示数据
            var groups = self.amuseVM.anchorGroup
            groups.removeFirst()
            self.amuseMenu.groups = groups
        }
    }
}
