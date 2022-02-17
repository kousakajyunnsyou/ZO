//
//  RecommandCycleView.swift
//  ZO
//
//  Created by dousei hann on 2022/2/15.
//  推荐页上方的无限轮播

import UIKit
import CoreMedia

let KCycleCellID = "KCycleCellID"


class RecommandCycleView: UIView {

    
    @IBOutlet weak var cycleView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    var cycleTimer : Timer?
    
    var cycleModels : [CycleModel]? {
        didSet {
            cycleView.reloadData()
            pageControl.numberOfPages = cycleModels?.count ?? 0
            
            //设置初始位置（* 10 ：防止左滑无显示）
//            layoutIfNeeded()
//            let indexPath = IndexPath(item: (cycleModels?.count ?? 0) * 10, section: 0)
//            cycleView.scrollToItem(at: indexPath, at: .left, animated: false)
            
            let offSetX = CGFloat((cycleModels?.count ?? 0) * 10) * cycleView.bounds.width
            cycleView.setContentOffset(CGPoint(x: offSetX, y: 0), animated: false)
            
            //添加定时滚动
//            removeTimer()
//            addTimer()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        cycleView.register(UINib(nibName: "CyclelCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: KCycleCellID)
    }
    
    override func layoutSubviews() {
        //设置轮播布局与大小
        let cycleLayout = cycleView.collectionViewLayout as! UICollectionViewFlowLayout
        cycleLayout.itemSize = cycleView.bounds.size
    }

}

//MARK: - 对外部暴露的初始化方法
extension RecommandCycleView {
    class func recomandCycle() -> RecommandCycleView {
        return Bundle.main.loadNibNamed("RecommandCycleView", owner: nil, options: nil)?.first as! RecommandCycleView
    }
}

// MARK: - 遵守UICollectionView的数据源协议
extension RecommandCycleView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (cycleModels?.count ?? 0) * 10000
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: KCycleCellID, for: indexPath) as! CycleCollectionViewCell
        cell.cycleRoom = self.cycleModels?[indexPath.item % (cycleModels?.count ?? 1)]
        return cell
    }
}

// MARK: - 遵守UICollectionViewDelegate
extension RecommandCycleView: UICollectionViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        //增加宽度的一半，则在翻到一般时，pageControl即可发生动作
        let offsetX = scrollView.contentOffset.x + scrollView.bounds.width * 0.5
        
        pageControl.currentPage = Int(offsetX / scrollView.bounds.width) % (cycleModels?.count ?? 1)
    }
}

//MARK: - 对定时器的操作方法
extension RecommandCycleView {
    fileprivate func addTimer() {
        cycleTimer = Timer(timeInterval: 3.0, target: self, selector: #selector(scrollToNext), userInfo: nil, repeats: true)
        RunLoop.main.add(cycleTimer!, forMode: .common)
    }
    
    fileprivate func removeTimer() {
        cycleTimer?.invalidate() //从运行循环中去除
        cycleTimer = nil
    }
    
    @objc fileprivate func scrollToNext() {
        let currentOffsetX = cycleView.contentOffset.x
        let offSetX = currentOffsetX + cycleView.bounds.width
        cycleView.setContentOffset(CGPoint(x: offSetX, y: 0), animated: true)
    }
}


