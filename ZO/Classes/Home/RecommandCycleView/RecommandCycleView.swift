//
//  RecommandCycleView.swift
//  ZO
//
//  Created by dousei hann on 2022/2/15.
//  推荐页上方的无限轮播

import UIKit

let KCycleCellID = "KCycleCellID"


class RecommandCycleView: UIView {

    
    @IBOutlet weak var cycleView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.cycleView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: KCycleCellID)
    }

}

//MARK: - 外部初始化方法
extension RecommandCycleView {
    class func recomandCycle() -> RecommandCycleView {
        return Bundle.main.loadNibNamed("RecommandCycleView", owner: nil, options: nil)?.first as! RecommandCycleView
    }
}

// MARK: - 遵守UICollectionView的数据源协议
extension RecommandCycleView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: KCycleCellID, for: indexPath)
        cell.backgroundColor = UIColor.randomColor()
        return cell
    }
}

// MARK: - 遵守UICollectionViewDelegate
extension RecommandCycleView: UICollectionViewDelegate {
    
}
