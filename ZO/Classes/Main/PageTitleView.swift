//
//  PageTitleView.swift
//  ZO
//
//  Created by yons on 2021/4/23.
//  顶部滑动小标题

import UIKit

protocol PageTitleViewDelegate : class {
    //更改展示的与小标题对应的内容
    func changePageContent(selectedIndex index: Int)
}

class PageTitleView: UIView {

    // MARK: 定义属性
    
    weak var delegate : PageTitleViewDelegate?
    // 标题集合
    var titles : [String]
    // 当前选中的标题（Lable），默认为0（第一个）
    var currentLableindex: Int = 0
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
        //初始化标题导航
        setupTitlesLables()
        //初始化底线和滑块
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
            lable.textColor = UIColor(red: KNormalColor.0, green: KNormalColor.1, blue: KNormalColor.2)
            lable.font = UIFont.systemFont(ofSize: 16.0)
            lable.textAlignment = .center
            //Lable 的布局
            let lableX : CGFloat = lableW * CGFloat(index)
            lable.frame = CGRect(x: lableX, y: lableY, width: lableW, height: lableH)
            //添加lable
            scrollView.addSubview(lable)
            titleLables.append(lable)
            //添加手势以响应点击事件
            let tapGes = UITapGestureRecognizer(target: self, action: #selector(self.titleLableClick(tapGes:)))
            lable.isUserInteractionEnabled = true
            lable.addGestureRecognizer(tapGes)
        }
    }
    //初始化底线和滑块
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
        firtLable.textColor = UIColor(red: KSelectColor.0, green: KSelectColor.1, blue: KSelectColor.2)
        let scrollLineW = firtLable.frame.width
        
        //设置底部滑块
        scrollLine.frame = CGRect(x: firtLable.frame.origin.x, y: frame.height - scrollLineH, width: scrollLineW, height: scrollLineH)
        scrollView.addSubview(scrollLine)
    }
}

//MARK: 监听lable的点击事件
extension PageTitleView {
    @objc private func titleLableClick(tapGes: UITapGestureRecognizer) {
        //获取lable的下标值
        guard let currentLable = tapGes.view as? UILabel else { return }
        
        let oldLable = titleLables[currentLableindex]
        //lable属性变更
        currentLable.textColor = UIColor(red: KSelectColor.0, green: KSelectColor.1, blue: KSelectColor.2)
        oldLable.textColor = UIColor(red: KNormalColor.0, green: KNormalColor.1, blue: KNormalColor.2)
        
        //更新当前lable
        currentLableindex = currentLable.tag
        
        //滑块位置变动
        let scrollLineX = CGFloat(currentLableindex) * scrollLine.frame.width
        UIView.animate(withDuration: 0.1) {
            self.scrollLine.frame.origin.x = scrollLineX
        }
        
        //对应的展示内容
        self.delegate?.changePageContent(selectedIndex: currentLableindex)
    }
}

//MARK: 对外暴露的方法
//响应pageContentView的滑动事件
extension PageTitleView {
    func ChangeTitleStateWithProgress(progress: CGFloat,sourceIndex: Int,targetIndex: Int) {
        //确定title
        let sourceLable = titleLables[sourceIndex]
        let tatgetLable = titleLables[targetIndex]
        
        // 滑块滑动逻辑
        let moveTotalX = tatgetLable.frame.origin.x - sourceLable.frame.origin.x
        let moveX = moveTotalX * progress
        scrollLine.frame.origin.x  = sourceLable.frame.origin.x + moveX
        
        //颜色的渐变
        let colorChange = (KSelectColor.0 - KNormalColor.0, KSelectColor.1 - KNormalColor.1, KSelectColor.2 - KNormalColor.2)
        
        sourceLable.textColor = UIColor(red: KSelectColor.0 - colorChange.0 * progress, green: KSelectColor.1 - colorChange.1 * progress, blue: KSelectColor.2 - colorChange.2 * progress)
        tatgetLable.textColor = UIColor(red: KNormalColor.0 + colorChange.0 * progress, green: KNormalColor.1 + colorChange.1 * progress, blue: KNormalColor.2 + colorChange.2 * progress)
        
        currentLableindex = targetIndex
    }
}
