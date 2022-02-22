//
//  GameViewController.swift
//  ZO
//
//  Created by dousei hann on 2022/2/19.
//

import UIKit

//组件间距
let KEdgeMargin: CGFloat = 10.0
let KItemW: CGFloat = (KScreenW - KEdgeMargin * 2) / 3
let KItemH: CGFloat = KScreenW * 2 / 7

let KTopHeaderH: CGFloat = 50.0
let KTopGameViewH: CGFloat = 90.0

let KGameViewCellID = "KGameViewCellID"
let KCollectionHeaderID = "KCollectionHeaderID"

class GameViewController: UIViewController {
    
    fileprivate lazy var gameVM: GameViewModel = GameViewModel()
    
    //所有的游戏
    fileprivate lazy var collectionView: UICollectionView = {[unowned self] in
        //创建布局
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: KItemW, height: KItemH)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = UIEdgeInsets(top: 0, left: KEdgeMargin, bottom: 0, right: KEdgeMargin)
        layout.headerReferenceSize = CGSize(width: KScreenW, height: 50.0)
        
        //创建collectionView
        let view = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        view.register(UINib(nibName: "GameCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: KGameViewCellID)
        view.register(UINib(nibName: "CollectionHeaderView", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: KCollectionHeaderID)
        
        view.dataSource = self
        view.delegate = self
        
        view.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        return view
    }()
    //顶部常看的游戏
    fileprivate lazy var topHeaderView: CollectionHeaderView = {
        let view = CollectionHeaderView.collectionHeaderView()
        view.frame = CGRect(x: 0, y: -(KTopHeaderH + KTopGameViewH), width: KScreenW, height: KTopHeaderH)
        view.groupLable.text = "常用"
        view.moreButton.isHidden = true
        view.groupIocn.image = UIImage(named: "Img_orange")
        return view
    }()
    fileprivate lazy var topGameView: RecommandGameView = {
        let view = RecommandGameView.recommandGameView()
        view.frame = CGRect(x: 0, y: -KTopGameViewH, width: KScreenW, height: KTopGameViewH)
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        loadData()
    }
}

//MARK: - 设置UI界面
extension GameViewController {
    func setupUI() {
        view.addSubview(collectionView)
        
        collectionView.addSubview(topHeaderView)
        collectionView.addSubview(topGameView)
        
        collectionView.contentInset = UIEdgeInsets(top: KTopHeaderH + KTopGameViewH, left: 0, bottom: 0, right: 0)
    }
}

//MARK: - 请求数据
extension GameViewController {
    fileprivate func loadData() {
        gameVM.requestGameData {
            self.collectionView.reloadData()
            
            self.topGameView.anchorGroups = Array(self.gameVM.games[0..<10])
        }
    }
}

//MARK: - 遵守UICollectionView数据源协议&代理
extension GameViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return gameVM.games.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: KGameViewCellID, for: indexPath) as! GameCollectionViewCell
        cell.baseGroup = gameVM.games[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: KCollectionHeaderID, for: indexPath) as! CollectionHeaderView
        headerView.groupIocn.image = UIImage(named: "Img_orange")
        headerView.groupLable.text = "全部"
        headerView.moreButton.isHidden = true
        
        return headerView
    }
}


extension GameViewController: UICollectionViewDelegate {
    
}

