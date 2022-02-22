//
//  CollectionSpecialCell.swift
//  ZO
//
//  Created by yons on 2021/5/24.
//  特别主播（例：颜值系列）

import UIKit

class CollectionSpecialCell: UICollectionViewCell {
    
    @IBOutlet weak var showImage: UIImageView!
    @IBOutlet weak var roomName: UILabel!
    @IBOutlet weak var onlineMumbers: UILabel!
    @IBOutlet weak var city: UIButton!
    
    var anchorInfo : SingleAnchor? {
        didSet {
            onlineMumbers.text = String(anchorInfo?.online ?? 0)
            roomName.text = anchorInfo?.room_name
            city.setTitle(anchorInfo?.anchor_city ?? "未知", for: .normal)
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
    }
}
