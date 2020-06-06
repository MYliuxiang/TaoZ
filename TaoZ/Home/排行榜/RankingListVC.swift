//
//  RankingListVC.swift
//  TaoZ
//
//  Created by liuxiang on 2020/6/6.
//  Copyright © 2020 liuxiang. All rights reserved.
//

import UIKit



class RankingListVC: BaseViewController {
    
    @IBOutlet var headerView: UIView!
    lazy var pagingView: JXPagingView = JXPagingListRefreshView(delegate: self, listContainerType: .scrollView)
    var titles = ["日榜","周榜","总榜"]
    var headerInSectionHeight: Int = 54
    lazy var segmentedView: JXSegmentedView = JXSegmentedView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: CGFloat(headerInSectionHeight)))
       let dataSource: JXSegmentedTitleDataSource = JXSegmentedTitleDataSource()
    override func viewDidLoad() {
        super.viewDidLoad()
        navBar.isHidden = true
        
        // Do any additional setup after loading the view.
        dataSource.titles = titles
        dataSource.titleSelectedColor = color_3
        dataSource.titleSelectedFont = UIFont.boldSystemFont(ofSize: 22)
        dataSource.titleNormalColor = color_3
        dataSource.titleNormalFont = UIFont.systemFont(ofSize: 16)
        dataSource.isTitleColorGradientEnabled = true
        dataSource.isTitleZoomEnabled = true
        dataSource.isItemSpacingAverageEnabled = false
        segmentedView.dataSource = dataSource
        segmentedView.contentEdgeInsetLeft = 12
        segmentedView.isContentScrollViewClickTransitionAnimationEnabled = false



        let lineView = JXSegmentedIndicatorLineView()
        lineView.indicatorColor = color_theme
        lineView.indicatorHeight = 4
        lineView.indicatorWidth = 18
        lineView.indicatorCornerRadius = 2
        lineView.verticalOffset = 5
        segmentedView.indicators = [lineView]

        pagingView.mainTableView.gestureDelegate = self
        pagingView.listContainerView.isCategoryNestPagingEnabled = true

        self.view.addSubview(pagingView)

        segmentedView.listContainer = pagingView.listContainerView
        //扣边返回处理，下面的代码要加上
        pagingView.listContainerView.scrollView.panGestureRecognizer.require(toFail: self.navigationController!.interactivePopGestureRecognizer!)
        pagingView.mainTableView.panGestureRecognizer.require(toFail: self.navigationController!.interactivePopGestureRecognizer!)

    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        pagingView.frame =  CGRect(x: 0, y: 0, width: ScreenWidth, height: ScreenHeight - YMKDvice.navBarHeight())
    }
    
    
}

extension RankingListVC: JXPagingViewDelegate {
    func pagingView(_ pagingView: JXPagingView, initListAtIndex index: Int) -> JXPagingViewListViewDelegate {
        return RankSubVC()
    }
    
    
    func tableHeaderViewHeight(in pagingView: JXPagingView) -> Int {
        return 216
    }
    
    func tableHeaderView(in pagingView: JXPagingView) -> UIView {
        return self.headerView
    }
    
    func heightForPinSectionHeader(in pagingView: JXPagingView) -> Int {
        return headerInSectionHeight
    }
    
    func viewForPinSectionHeader(in pagingView: JXPagingView) -> UIView {
        return segmentedView
    }
    
    func numberOfLists(in pagingView: JXPagingView) -> Int {
        return titles.count
    }
    

}

extension RankingListVC: JXSegmentedViewDelegate {
    func segmentedView(_ segmentedView: JXSegmentedView, didSelectedItemAt index: Int) {
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = (index == 0)
    }
}

extension RankingListVC: JXPagingMainTableViewGestureDelegate {
    func mainTableViewGestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        //禁止segmentedView左右滑动的时候，上下和左右都可以滚动
        if otherGestureRecognizer == segmentedView.collectionView.panGestureRecognizer {
            return false
        }
        return gestureRecognizer.isKind(of: UIPanGestureRecognizer.self) && otherGestureRecognizer.isKind(of: UIPanGestureRecognizer.self)
    }
}

extension RankingListVC: JXSegmentedListContainerViewListDelegate {

    func listView() -> UIView {
        return view
    }

}
