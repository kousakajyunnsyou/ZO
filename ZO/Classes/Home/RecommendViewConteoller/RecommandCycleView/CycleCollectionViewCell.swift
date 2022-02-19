//
//  CycleCollectionCellCollectionViewCell.swift
//  ZO
//
//  Created by dousei hann on 2022/2/16.
//

import UIKit

class CycleCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var cycleTitle: UILabel!
    var cycleRoom : CycleModel? {
        didSet {
            cycleTitle.text = cycleRoom?.title
            let cycleImageUrl = URL.init(string: cycleRoom?.pic_url ?? "")
            image.kf.setImage(with: cycleImageUrl, placeholder: UIImage(named: "cycle_Img_default"))
        }
    }
    
//
//    override func awakeFromNib() {
//        super.awakeFromNib()
//        // Initialization code
//    }

}
