//
//  AmuseMenuView.swift
//  ZO
//
//  Created by dousei hann on 2022/2/22.
//

import UIKit

private let KAmuseCellID = "KAmuseCellID"

class AmuseMenuView: UIView {

    var groups: [AnchorGroup]? {
        didSet {
            collectionView.reloadData()
        }
    }
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageCon: UIPageControl!
    override class func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        collectionView.register(UINib(nibName: "AmuseMenuCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: KAmuseCellID)
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        
        layout.itemSize = collectionView.bounds.size
    }
    
}

//MARK: - 对外暴露的初始化方法
extension AmuseMenuView {
    class func amuseMenuView() -> AmuseMenuView {
        return Bundle.main.loadNibNamed("AmuseMenuView", owner: nil, options: nil)?.first as! AmuseMenuView
    }
}

//MARK: - UICollectionViewDataSource
extension AmuseMenuView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let groups = groups else { return 0 }
        
        let numOfPages = (groups.count - 1) / 8 + 1
        pageCon.numberOfPages = numOfPages
        return numOfPages
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: KAmuseCellID, for: indexPath) as! AmuseMenuCollectionViewCell
        setSubCellData(cell: cell, indexPath: indexPath)
        return cell
    }
    
    
    private func setSubCellData(cell: AmuseMenuCollectionViewCell, indexPath: IndexPath) {
        // 0页：0 ~ 7 ， 1页： 8 ~ 15 ，2页： 16 ~ 23
        let startIndex = indexPath.item * 8
        var endIndex = (indexPath.item + 1) * 8 - 1
        
        if endIndex > groups!.count - 1 {
            endIndex = groups!.count - 1
        }
        
        cell.groups = Array(groups![startIndex...endIndex])
    }
}

extension AmuseMenuView: UICollectionViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetX = scrollView.contentOffset.x
        
        pageCon.currentPage = Int(offsetX / scrollView.bounds.width)
    }
}
