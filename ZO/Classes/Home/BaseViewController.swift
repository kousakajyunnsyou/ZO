//
//  BaseViewController.swift
//  ZO
//
//  Created by dousei hann on 2022/2/24.
//

import UIKit

class BaseViewController: UIViewController {

    var contentView: UIView?
    
    fileprivate lazy var animImage: UIImageView = {[unowned self] in
        let image = UIImageView(image: UIImage(named: "img_loading_1"))
        image.animationImages = [UIImage(named: "img_loading_1")!, UIImage(named: "img_loading_2")!]
        image.center = self.view.center
        image.animationDuration = 0.3
        image.animationRepeatCount = LONG_MAX
        image.autoresizingMask = [.flexibleTopMargin, .flexibleBottomMargin]
        
        return image
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        // Do any additional setup after loading the view.
    }
    
}

extension BaseViewController {
    @objc func setupUI() {
        contentView?.isHidden = true
        
        self.view.addSubview(animImage)
        
        animImage.startAnimating()
    }
    
    //停止加载动画
    func stopLoading() {
        animImage.stopAnimating()
        
        animImage.isHidden = true
        
        contentView?.isHidden = false
    }
}
