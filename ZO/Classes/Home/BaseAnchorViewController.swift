//
//  BaseAnchorViewController.swift
//  ZO
//
//  Created by dousei hann on 2022/2/21.
//

import UIKit

//组件间距
let KItemMargin: CGFloat = 10.0
//主播展示组件宽度,高度
let KItemWidth: CGFloat = (KScreenW - KItemMargin * 3) / 2
let KNormalItemHeight: CGFloat = KItemWidth * 3 / 4
let KSpecialItemHeight: CGFloat = KItemWidth * 4 / 3
//组头高度
let KHeaderHeight: CGFloat = 50

let KNormalCell = "KNormalCell"
let KHeaderID = "KHeader"

class BaseAnchorViewController: BaseViewController {
    
    var baseAnchorVM : BaseAnchorViewModel!
    //主播展示
    lazy var collectinView: UICollectionView = {[unowned self] in
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 1
        layout.minimumInteritemSpacing = KItemMargin
        layout.sectionInset = UIEdgeInsets(top: 0, left: KItemMargin, bottom: 0, right: KItemMargin)
        layout.headerReferenceSize = CGSize(width: KScreenW, height: KHeaderHeight)
        
        let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.white
        collectionView.register(UINib(nibName: "CollectionNormalCell", bundle: nil), forCellWithReuseIdentifier: KNormalCell)
        collectionView.register(UINib(nibName: "CollectionHeaderView", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: KHeaderID)
        collectionView.dataSource = self
        collectionView.delegate = self
        //宽高自适应
        collectionView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        return collectionView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        loadData()
        // Do any additional setup after loading the view.
    }
}

//MARK: 视图
extension BaseAnchorViewController {
    //初始化视图
    override func setupUI() {
        self.contentView = collectinView
        
        view.addSubview(collectinView)
        
        super.setupUI()
    }
}

//MARK: 请求数据
extension BaseAnchorViewController {
    @objc func loadData() {
    }
}


//MARK: UICollectionViewDataSource
extension BaseAnchorViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return  self.baseAnchorVM.anchorGroup.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let group = baseAnchorVM.anchorGroup[section]
        return group.anchors.count
    }
    
    //Item定义
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cellOfNormal = collectionView.dequeueReusableCell(withReuseIdentifier: KNormalCell, for: indexPath) as! CollectionNormalCell
        cellOfNormal.anchorInfo = baseAnchorVM.anchorGroup[indexPath.section].anchors[indexPath.item]
        return cellOfNormal
    }
    
    //Header定义
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        //取出headerView
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: KHeaderID, for: indexPath) as! CollectionHeaderView

        headerView.group = baseAnchorVM.anchorGroup[indexPath.section]
        
        return headerView
    }
    //Item Size
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: KItemWidth, height: KNormalItemHeight)
    }
}


//MARK: -
extension BaseAnchorViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let anchor = baseAnchorVM.anchorGroup[indexPath.section].anchors[indexPath.item]
        
        anchor.isVertical == 0 ? pushNormalRoomVC() : modalShowRoomVC()
    }
    
    func pushNormalRoomVC() {
        let normalRoom = NormalRoomViewController()
        
        navigationController?.pushViewController(normalRoom, animated: true)
    }
    
    func modalShowRoomVC() {
        let showRoom = ShowRoomViewController()
        
        present(showRoom, animated: true)
    }
}
