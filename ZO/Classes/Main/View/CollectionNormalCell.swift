//
//  CollectionNormalCell.swift
//  ZO
//
//  Created by yons on 2021/5/24.
//  普通主播

import UIKit
import Kingfisher

class CollectionNormalCell: UICollectionViewCell {

    @IBOutlet weak var showImage: UIImageView!
    @IBOutlet weak var onlineMumbers: UIButton!
    @IBOutlet weak var nickName: UILabel!
    @IBOutlet weak var roomName: UILabel!
    @IBOutlet weak var roomIcon: UIImageView!
    
    var anchorInfo : SingleAnchor? {
        didSet {
            nickName.text = anchorInfo?.nickname
            onlineMumbers.setTitle(String(anchorInfo?.online ?? 0), for: .normal)
            roomName.text = anchorInfo?.room_name
            if let showImage_url = URL(string: anchorInfo?.vertical_src ?? "") {
                showImage.kf.setImage(with: showImage_url)
            }else{
                showImage.image = UIImage(named: "live_cell_default_phone")
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        showImage.layer.cornerRadius = 8
        showImage.layer.masksToBounds = true
    }

}
