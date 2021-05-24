//
//  CollectionNormalCell.swift
//  ZO
//
//  Created by yons on 2021/5/24.
//  普通主播

import UIKit

class CollectionNormalCell: UICollectionViewCell {

    @IBOutlet weak var showImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        showImage.layer.cornerRadius = 8
        showImage.layer.masksToBounds = true
    }

}
