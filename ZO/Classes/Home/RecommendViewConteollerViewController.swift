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
//主播展示组件宽度,高度
let KItemWidth: CGFloat = (KScreenW - KItemMargin * 3) / 2
let KNormalItemHeight: CGFloat = KItemWidth * 3 / 4
let KSpecialItemHeight: CGFloat = KItemWidth * 4 / 3
//无限轮播组件宽高
let KCycleViewH: CGFloat = KScreenW * 3 / 8


//组头高度
let KHeaderHeight: CGFloat = 50


let KNormalCell = "KNormalCell"
let KSpecialCell = "KSpecialCell"
let KHeaderID = "KHeader"


class RecommendViewConteollerViewController: UIViewController {
    
    //MARK: 属性
    private lazy var recommendVM : RecommendViewModel = RecommendViewModel()
    //主播展示
    private lazy var collectinView: UICollectionView = {[unowned self] in
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 1
        layout.minimumInteritemSpacing = KItemMargin
        layout.sectionInset = UIEdgeInsets(top: 0, left: KItemMargin, bottom: 0, right: KItemMargin)
        layout.headerReferenceSize = CGSize(width: KScreenW, height: KHeaderHeight)
        
        let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.white
        collectionView.register(UINib(nibName: "CollectionNormalCell", bundle: nil), forCellWithReuseIdentifier: KNormalCell)
        collectionView.register(UINib(nibName: "CollectionSpecialCell", bundle: nil), forCellWithReuseIdentifier: KSpecialCell)
        collectionView.register(UINib(nibName: "CollectionHeaderView", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: KHeaderID)
        collectionView.dataSource = self
        collectionView.delegate = self
        //宽高自适应
        collectionView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        return collectionView
    }()
    //无限轮播
    private lazy var cycleView: RecommandCycleView = {
        let cycleView = RecommandCycleView.recomandCycle()
        cycleView.frame = CGRect(x: 0, y: -KCycleViewH, width: KScreenW, height: KCycleViewH)
        return cycleView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        
        loadData()
    }
    
}

//MARK: 视图
extension RecommendViewConteollerViewController {
    //初始化视图
    func setupUI()  {
        view.addSubview(collectinView)
        
        //添加无限轮播
        collectinView.addSubview(cycleView)
        collectinView.contentInset = UIEdgeInsets(top: KCycleViewH, left: 0, bottom: 0, right: 0)
    }
}

//MARK: UICollectionViewDataSource, UICollectionViewDelegate
extension RecommendViewConteollerViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return  self.recommendVM.anchorGroup.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let group = recommendVM.anchorGroup[section]
        return group.anchors.count
    }
    
    //Item定义
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        var cell : UICollectionViewCell
        if indexPath.section == 1 {
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: KSpecialCell, for: indexPath)
            return cell
        }
        let cellOfNormal = collectionView.dequeueReusableCell(withReuseIdentifier: KNormalCell, for: indexPath) as! CollectionNormalCell
        cellOfNormal.anchorInfo = recommendVM.anchorGroup[indexPath.section].anchors[indexPath.item]
        return cellOfNormal
    }
    
    //Item Size变化
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 1 {
            return CGSize(width: KItemWidth, height: KSpecialItemHeight)
        }
        return CGSize(width: KItemWidth, height: KNormalItemHeight)
    }
    
    //Header定义
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        //取出headerView
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: KHeaderID, for: indexPath) as! CollectionHeaderView

        headerView.group = recommendVM.anchorGroup[indexPath.section]
        
        return headerView
    }
}
//MARK: 请求数据
extension RecommendViewConteollerViewController {
    
    private func loadData() {
        recommendVM.requsetData {
            self.collectinView.reloadData()
        }
    }
}
