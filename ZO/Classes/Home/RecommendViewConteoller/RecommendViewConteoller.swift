//
//  RecommendViewConteollerViewController.swift
//  ZO
//
//  Created by yons on 2021/5/19.
//  推荐页

import UIKit


//MARK: 常量定义
//无限轮播组件宽高
let KCycleViewH: CGFloat = KScreenW * 3 / 8
//游戏推荐组件宽高
let KGameViewH: CGFloat = 90.0

let KSpecialCell = "KSpecialCell"

class RecommendViewConteoller: BaseAnchorViewController {
    
    //MARK: 属性
    private lazy var recommendVM : RecommendViewModel = RecommendViewModel()

    //无限轮播
    private lazy var cycleView: RecommandCycleView = {
        let cycleView = RecommandCycleView.recomandCycle()
        cycleView.frame = CGRect(x: 0, y: -(KCycleViewH + KGameViewH), width: KScreenW, height: KCycleViewH)
        return cycleView
    }()
    //游戏推荐
    private lazy var gameView: RecommandGameView = {
        let view = RecommandGameView.recommandGameView()
        view.frame = CGRect(x: 0, y: -KGameViewH, width: KScreenW, height: KGameViewH)
        return view
    }()
    
}

//MARK: 视图
extension RecommendViewConteoller {
    //初始化视图
    override func setupUI()  {
        super.setupUI()
        collectinView.register(UINib(nibName: "CollectionSpecialCell", bundle: nil), forCellWithReuseIdentifier: KSpecialCell)
        //添加无限轮播
        collectinView.addSubview(cycleView)
        collectinView.contentInset = UIEdgeInsets(top: KCycleViewH + KGameViewH, left: 0, bottom: 0, right: 0)
        
        //添加游戏推荐
        collectinView.addSubview(gameView)
    }
}

//MARK: UICollectionViewDataSource, UICollectionViewDelegate
extension RecommendViewConteoller {
    //Item定义
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 1 {
            let specialCell = collectionView.dequeueReusableCell(withReuseIdentifier: KSpecialCell, for: indexPath) as! CollectionSpecialCell
            specialCell.anchorInfo = recommendVM.anchorGroup[indexPath.section].anchors[indexPath.item]
            return specialCell
        }else {
           return super.collectionView(collectionView, cellForItemAt: indexPath)
        }
    }
    
    //Item Size变化
    override func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 1 {
            return CGSize(width: KItemWidth, height: KSpecialItemHeight)
        }
        return CGSize(width: KItemWidth, height: KNormalItemHeight)
    }
}
//MARK: 请求数据
extension RecommendViewConteoller {
    
    override func loadData() {
        baseAnchorVM = recommendVM
        
        recommendVM.requsetData {
            
            //展示主播数据
            self.collectinView.reloadData()
            
            //将游戏分组传递给RecommandGameView
            var group = self.recommendVM.anchorGroup
            group.removeFirst() //移除前两组
            group.removeFirst()
            group.append({ () -> AnchorGroup in
                let anchorGroup = AnchorGroup()
                anchorGroup.tag_name = "更多"
                return anchorGroup
            }())
            self.gameView.anchorGroups = group
            
            self.stopLoading()
        }
        
        recommendVM.requestCycleData {
            self.cycleView.cycleModels = self.recommendVM.cycleDatas
        }
    }
}
