//
//  RecommandGameView.swift
//  ZO
//
//  Created by dousei hann on 2022/2/18.
//

import UIKit
import CoreMedia

let KGameCellID = "KGameCellID"
class RecommandGameView: UIView {

    @IBOutlet weak var collection: UICollectionView!
    
    var anchorGroups: [AnchorGroup]? {
        didSet {
            collection.reloadData()
        }
    }
    override func awakeFromNib() {
        autoresizingMask = []
        collection.register(UINib(nibName: "GameCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: KGameCellID)
        collection.contentInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
    }
}

//MARK: - 对外暴露的初始化方法
extension RecommandGameView {
    class func recommandGameView() -> RecommandGameView {
        return Bundle.main.loadNibNamed("RecommandGameView", owner: nil, options: nil)?.first as! RecommandGameView
    }
}

//MARK: - UICollectionViewDataSource实现
extension RecommandGameView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return anchorGroups?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collection.dequeueReusableCell(withReuseIdentifier: KGameCellID, for: indexPath) as! GameCollectionViewCell
        cell.baseGroup = anchorGroups?[indexPath.item]
        return cell
    }
}
