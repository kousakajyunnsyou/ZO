//
//  AmuseMenuCollectionViewCell.swift
//  ZO
//
//  Created by dousei hann on 2022/2/22.
//

import UIKit
import SwiftUI

private let meunSubCellID = "meunSubCellID"

class AmuseMenuCollectionViewCell: UICollectionViewCell {
    
    var groups: [AnchorGroup]? {
        didSet {
            collectionView.reloadData()
        }
    }

    @IBOutlet weak var collectionView: UICollectionView!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        collectionView.register(UINib(nibName: "GameCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: meunSubCellID)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        let itemW = collectionView.bounds.width / 4
        let itemH = collectionView.bounds.height / 2
        layout.itemSize = CGSize(width: itemW, height: itemH)
        
    }
    
}

extension AmuseMenuCollectionViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return groups?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: meunSubCellID, for: indexPath) as! GameCollectionViewCell
        cell.baseGroup = groups?[indexPath.item]
        cell.clipsToBounds = true
        return cell
    }
}
