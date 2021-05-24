//
//  RecommendViewConteollerViewController.swift
//  ZO
//
//  Created by yons on 2021/5/19.
//  推荐页

import UIKit


//MARK: 常量定义

//组件间距
let KItemMargin: CGFloat = 10.0
//组件宽度,高度
let KItemWidth: CGFloat = (KScreenW - KItemMargin * 3) / 2
let KItemHeight: CGFloat = KItemWidth * 3 / 4
//组头高度
let KHeaderHeight: CGFloat = 50


let KNormalCell = "KNormalCell"
let KHeaderID = "KHeader"


class RecommendViewConteollerViewController: UIViewController {
    
    //MARK: 属性
    private lazy var collectinView: UICollectionView = {[unowned self] in
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: KItemWidth, height: KItemHeight)
        layout.minimumLineSpacing = 1
        layout.minimumInteritemSpacing = KItemMargin
        layout.sectionInset = UIEdgeInsets(top: 0, left: KItemMargin, bottom: 0, right: KItemMargin)
        layout.headerReferenceSize = CGSize(width: KScreenW, height: KHeaderHeight)
        
        let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.white
        collectionView.register(UINib(nibName: "CollectionNormalCell", bundle: nil), forCellWithReuseIdentifier: KNormalCell)
        collectionView.register(UINib(nibName: "CollectionHeaderView", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: KHeaderID)
        collectionView.dataSource = self
        //宽高自适应
        collectionView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }
    
}

//MARK: 视图
extension RecommendViewConteollerViewController {
    //初始化视图
    func setupUI()  {
        view.addSubview(collectinView)
    }
}

//MARK: UICollectionViewDataSource
extension RecommendViewConteollerViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return  12
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return 8
        }
        return 4
    }
    //Item定义
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: KNormalCell, for: indexPath)
        return cell
    }
    //Header定义
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        //去除headerView
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: KHeaderID, for: indexPath)
        
        return headerView
    }
}
