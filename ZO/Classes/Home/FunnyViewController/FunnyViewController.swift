//
//  FunnyViewController.swift
//  ZO
//
//  Created by dousei hann on 2022/2/23.
//

import UIKit

class FunnyViewController: BaseAnchorViewController {
    
    private lazy var funnyVM: FunnyViewModel = FunnyViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }

}

//MARK: - 设置视图
extension FunnyViewController {
    override func setupUI() {
        super.setupUI()
        //本画面的模组不需要组头
        let layout = self.collectinView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.headerReferenceSize = CGSize.zero
        
        collectinView.contentInset = UIEdgeInsets(top: 10.0, left: 0, bottom: 0, right: 0)
    }
}

//MARK: - 请求网路数据
extension FunnyViewController {
    override func loadData() {
        
        baseAnchorVM = self.funnyVM
        
        funnyVM.requsetData {
            self.collectinView.reloadData()
            
            self.stopLoading()
        }
    }
}
