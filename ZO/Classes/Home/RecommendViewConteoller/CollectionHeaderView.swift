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
    @IBOutlet weak var moreButton: UIButton!
    
    var group : AnchorGroup? {
        didSet {
            groupIocn.image = UIImage(named: group?.icon_name ?? "home_header_normal")
            groupLable.text = group?.tag_name
        }
    }
}

//MARK: - 返回一个自身的实例化
extension CollectionHeaderView {
    class func collectionHeaderView() -> CollectionHeaderView {
        return Bundle.main.loadNibNamed("CollectionHeaderView", owner: nil, options: nil)?.first as! CollectionHeaderView
    }
}
