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
            
            let indexPath = IndexPath(item: (cycleModels?.count ?? 0) * 10, section: 0)
            cycleView.scrollToItem(at: indexPath, at: .left, animated: false)
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
