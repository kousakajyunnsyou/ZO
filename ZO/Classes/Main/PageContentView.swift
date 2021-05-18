//
//  PageContentView.swift
//  ZO
//
//  Created by yons on 2021/4/28.
//  与滚动小标题对应的展示内容

import UIKit

protocol PageContentViewDelegete: class {
    func ChangeTitleState(contentView: PageContentView,progress: CGFloat,sourceIndex: Int,targetIndex: Int)
}

class PageContentView: UIView {

    //MARK: 定义参数
    private let ContentCellID = "ContentCellID"
    private var startOffset: CGFloat = 0
    
    //MARK: 定义属性
    
    //代理
    weak var delegete : PageContentViewDelegete?
    //是否滚动事件(UICollectionViewDelegate)禁用代理
    var isForbidDelegate : Bool = false
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
        collectionView.delegate = self
        
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
        //点击title时，不期望响应滚动事件
        isForbidDelegate = true
        
        let offsetX = CGFloat(currentIndex) * collectionView.frame.width
        collectionView.setContentOffset(CGPoint(x: offsetX, y: 0), animated: true)
    }
}

//MARK: 遵循UICollectionViewDelegate
extension PageContentView : UICollectionViewDelegate {
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        startOffset = scrollView.contentOffset.x
        //主动滑动时，启用
        isForbidDelegate = false
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        //判断是否响应
        if isForbidDelegate { return }
        
        // 滑动进度定义
        var progress: CGFloat = 0
        // 起始滑动点定义
        var sourceTndex: Int = 0
        // 目标滑动点定义
        var targetIndex: Int = 0
        
        let currentOffset = scrollView.contentOffset.x
        let scrollViewW = scrollView.bounds.width
        if currentOffset > startOffset {// 左向滑动
            progress = (currentOffset.truncatingRemainder(dividingBy: scrollViewW)) / scrollViewW
            
            sourceTndex = Int(currentOffset / scrollViewW)
            
            targetIndex = sourceTndex + 1
            if targetIndex >= childViews.count {
                targetIndex = childViews.count - 1
            }
            
            //如果滑动完成
            if (currentOffset - startOffset) == scrollViewW {
                progress = 1.0 // 如果不进行处理，会被置为0
                targetIndex = sourceTndex
            }
        }else {// 右向滑动
            progress = 1.0 - (currentOffset.truncatingRemainder(dividingBy: scrollViewW) / scrollViewW)
            
            targetIndex = Int(currentOffset / scrollViewW)
            
            sourceTndex = targetIndex + 1
            if sourceTndex >= childViews.count + 1 {
                sourceTndex = childViews.count - 1
            }
        }
        //将progress，sourceTndex，targetIndex传递给titleView
        delegete?.ChangeTitleState(contentView: self, progress: progress, sourceIndex: sourceTndex, targetIndex: targetIndex)
    }
}
