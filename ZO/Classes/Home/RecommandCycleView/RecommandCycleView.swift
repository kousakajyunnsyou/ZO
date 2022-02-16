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
    var cycleModels : [CycleModel]? {
        didSet {
            cycleView.reloadData()
            pageControl.numberOfPages = cycleModels?.count ?? 0
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        cycleView.register(UINib(nibName: "CyclelCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: KCycleCellID)
    }
    
    override func layoutSubviews() {
        let cycleLayout = cycleView.collectionViewLayout as! UICollectionViewFlowLayout
        cycleLayout.itemSize = cycleView.bounds.size
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
        return cycleModels?.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: KCycleCellID, for: indexPath) as! CycleCollectionViewCell
        cell.cycleRoom = self.cycleModels?[indexPath.item]
        return cell
    }
}

// MARK: - 遵守UICollectionViewDelegate
extension RecommandCycleView: UICollectionViewDelegate {
    
}
