//
//  CollectionHeaderView.swift
//  ZO
//
//  Created by yons on 2021/5/22.
//  视频的分组标题

import UIKit

class CollectionHeaderView: UICollectionReusableView {
    
    
    
    
    @IBOutlet weak var groupIocn: UIImageView!
    @IBOutlet weak var groupLable: UILabel!
    
    var group : AnchorGroup? {
        didSet {
            groupIocn.image = UIImage(named: group?.icon_name ?? "home_header_normal")
            groupLable.text = group?.tag_name
        }
    }
    

//    override func awakeFromNib() {
//        super.awakeFromNib()
//        // Initialization code
//    }
//
}
