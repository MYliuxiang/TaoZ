//
//  RankingVC.swift
//  TaoZ
//
//  Created by liuxiang on 2020/6/6.
//  Copyright © 2020 liuxiang. All rights reserved.
//

import UIKit

class RankingVC: BaseViewController {
    
    lazy var segmentedView: JXSegmentedView = JXSegmentedView(frame: CGRect(x: 0, y: 0, width: 180, height: CGFloat(44)))
    lazy var listwContainerView: JXSegmentedListContainerView! = {
        return JXSegmentedListContainerView(dataSource: self)
    }()
    var titles = ["桃气榜", "壕气榜"]
    let dataSource: JXSegmentedTitleDataSource = JXSegmentedTitleDataSource()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        navBar.addSubview(segmentedView)
        
        segmentedView.backgroundColor = UIColor.clear
        segmentedView.delegate = self
        segmentedView.isContentScrollViewClickTransitionAnimationEnabled = false
        dataSource.titles = titles
        dataSource.titleSelectedColor = color_3
        dataSource.titleSelectedFont = UIFont.boldSystemFont(ofSize: 22)
        dataSource.titleNormalColor = color_3
        dataSource.titleNormalFont = UIFont.systemFont(ofSize: 16)
        dataSource.isTitleColorGradientEnabled = true
        dataSource.isTitleZoomEnabled = true
        dataSource.isItemSpacingAverageEnabled = true
        segmentedView.dataSource = dataSource
        
        
        let lineView = JXSegmentedIndicatorLineView()
        lineView.indicatorColor = color_theme
        lineView.indicatorHeight = 4
        lineView.indicatorWidth = 18
        lineView.indicatorCornerRadius = 2
        segmentedView.indicators = [lineView]
        segmentedView.listContainer = listwContainerView
        view.addSubview(listwContainerView)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        segmentedView.frame = CGRect(x: (ScreenWidth - 180) / 2.0, y: YMKDvice.statusBarHeight(), width: 200, height: 44)
        listwContainerView.frame = CGRect(x: 0, y:YMKDvice.navBarHeight(), width: ScreenWidth, height: ScreenHeight -  YMKDvice.navBarHeight())
    }
    
    
    
    
    
    
}

extension RankingVC:JXSegmentedViewDelegate
{
    
    // ************** JXPagingMainTableViewGestureDelegate **************
    func mainTableViewGestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        //禁止segmentedView左右滑动的时候，上下和左右都可以滚动
        if otherGestureRecognizer == segmentedView.collectionView.panGestureRecognizer {
            return false
        }
        return gestureRecognizer.isKind(of: UIPanGestureRecognizer.self) && otherGestureRecognizer.isKind(of: UIPanGestureRecognizer.self)
    }
}

extension RankingVC: JXSegmentedListContainerViewDataSource {
    func numberOfLists(in listContainerView: JXSegmentedListContainerView) -> Int {
        if let titleDataSource = segmentedView.dataSource as? JXSegmentedBaseDataSource {
            return titleDataSource.dataSource.count
        }
        return 0
    }
    
    func listContainerView(_ listContainerView: JXSegmentedListContainerView, initListAt index: Int) -> JXSegmentedListContainerViewListDelegate {
        
            let vc = RankingListVC()
            return vc
       
    }
    
}

