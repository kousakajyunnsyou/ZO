//
//  PageTitleView.swift
//  ZO
//
//  Created by yons on 2021/4/23.
//  顶部滑动小标题

import UIKit

class PageTitleView: UIView {

    // MARK: 定义属性
    
    // 标题集合
    var titles : [String]
    // 标题实例
    private lazy var titleLables : [UILabel] = [UILabel]()
    //滚动视图
    private lazy var scrollView : UIScrollView = {
        let scrollView = UIScrollView()
        //水平滚动条不要
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.scrollsToTop = false
        //回弹效果不要
        scrollView.bounces = false
        //不需要调整UIScrollView的内边距
        scrollView.contentInsetAdjustmentBehavior = .never
        return scrollView
    }()
    //滚动标题底部滑块高度
    let scrollLineH: CGFloat = 2.0
    //底部滑块
    private lazy var scrollLine: UIView = {
        let scrollLine = UIView()
        scrollLine.backgroundColor = UIColor.orange
        return scrollLine
    }()
    
    
    /*自定义初始化方法
     *@param frame: 布局
     *@param titles: 展示标题
     */
    init(frame: CGRect, titles: [String]) {
        
        self.titles = titles
        
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: 设置UI界面
extension PageTitleView{
    func setupUI() {
        //添加滚动视图
        addSubview(scrollView)
        scrollView.frame = bounds
        //设置标题导航
        setupTitlesLables()
        //设置底线和滑块
        setBottomLineAndScrollLine()
    }
    
    //设置标题导航
    func setupTitlesLables()  {
        
        //Lable 的布局（通用属性）
        let lableW : CGFloat = frame.width / CGFloat(titles.count)
        let lableH : CGFloat = frame.height - scrollLineH
        let lableY : CGFloat = 0
        
        for (index, title) in titles.enumerated() {
            let lable = UILabel()
            // Lable 属性
            lable.text = title
            lable.tag = index
            lable.textColor = UIColor.darkGray
            lable.font = UIFont.systemFont(ofSize: 16.0)
            lable.textAlignment = .center
            //Lable 的布局
            let lableX : CGFloat = lableW * CGFloat(index)
            lable.frame = CGRect(x: lableX, y: lableY, width: lableW, height: lableH)
            scrollView.addSubview(lable)
            titleLables.append(lable)
        }
    }
    //设置底线和滑块
    func setBottomLineAndScrollLine() {
        //添加底线
        let bottomLine = UIView()
        bottomLine.backgroundColor = UIColor.lightGray
        let lineH:CGFloat = 0.5
        bottomLine.frame = CGRect(x: 0, y: frame.height - lineH, width: frame.width, height: lineH)
        addSubview(bottomLine)
        
        //获取默认显示的第一个小标题
        guard let firtLable = titleLables.first else { return }
        //第一个小标题的为橙色
        firtLable.textColor = UIColor.orange
        let scrollLineW = firtLable.frame.width
        
        //设置底部滑块
        scrollLine.frame = CGRect(x: firtLable.frame.origin.x, y: frame.height - scrollLineH, width: scrollLineW, height: scrollLineH)
        scrollView.addSubview(scrollLine)
    }
}
