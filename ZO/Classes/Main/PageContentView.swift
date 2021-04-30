//
//  PageContentView.swift
//  ZO
//
//  Created by yons on 2021/4/28.
//  与滚动小标题对应的展示内容

import UIKit

class PageContentView: UIView {

    //MARK: 定义常量
    private let ContentCellID = "ContentCellID"
    
    //MARK: 定义属性
    
    //子控制器
    private var childViews: [UIViewController]
    //父控制器(弱引用：两个互相作用的强引用导致无法释放)
    private weak var paraentView: UIViewController?
    //用于包容子控制器
    private lazy var collectionView: UICollectionView = {[weak self] in
        //创建layout
        let layout = UICollectionViewFlowLayout()
        //大小
        layout.itemSize = (self?.bounds.size)!
        //行间距
        layout.minimumLineSpacing = 0
        //item间距
        layout.minimumInteritemSpacing = 0
        //滚动间距: 水平
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        //水平指示器：不需要
        collectionView.showsHorizontalScrollIndicator = false
        //分页：是
        collectionView.isPagingEnabled = true
        //不超出内部滚动区域
        collectionView.bounces = false
        //设置数据源
        collectionView.dataSource = self
        //注册cell
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: ContentCellID)
        
        return collectionView
    }()
    
    /*自定义初始化方法
     *@param frame: 布局
     *@param childViews: 每个小标题对应的控制器
     *@param paraentView: 用于规定本视图从属的父控制器
     */
    init(frame: CGRect, childViews: [UIViewController], paraentView: UIViewController?) {
        self.childViews = childViews
        self.paraentView = paraentView
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

//MARK: UICollectionViewDataSource
extension PageContentView: UICollectionViewDataSource {

    
    //MARK: 设置UI
    func setupUI() {
        //将子控制器添加到父控制器
        for VC in childViews {
            paraentView?.addChild(VC)
        }
        
        //添加collectionView,在cell中存放子控制器的View
        addSubview(collectionView)
        collectionView.frame = bounds
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return childViews.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //创建cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ContentCellID, for: indexPath)
        
        //为防止view被重复加载，每次加载前移除
        for view in cell.contentView.subviews {
            view.removeFromSuperview()
        }
        //为cell设置内容
        let VC = childViews[indexPath.item]
        VC.view.frame = cell.contentView.bounds
        cell.contentView.addSubview(VC.view)
        
        return cell
    }
}

//MARK: 暴露给外部的方法
extension PageContentView {
    //响应小标题的点击事件
    public func steupContentForTitleChange(currentIndex: Int) {
        let offsetX = CGFloat(currentIndex) * collectionView.frame.width
        collectionView.setContentOffset(CGPoint(x: offsetX, y: 0), animated: true)
    }
}
