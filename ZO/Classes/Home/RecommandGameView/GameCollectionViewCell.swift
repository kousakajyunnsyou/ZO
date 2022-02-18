//
//  GameCollectionViewCell.swift
//  ZO
//
//  Created by dousei hann on 2022/2/18.
//

import UIKit

class GameCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var titel: UILabel!
    var anchorGroup: AnchorGroup? {
        didSet {
            titel.text = anchorGroup?.tag_name
            let url = URL(string: anchorGroup?.icon_url ?? "")
            image.kf.setImage(with: url,placeholder: UIImage(named: "home_more_btn"))
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
