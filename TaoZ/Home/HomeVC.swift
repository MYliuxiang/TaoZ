//
//  HomeVC.swift
//  TaoZ
//
//  Created by liuxiang on 07/05/2020.
//  Copyright © 2020 liuxiang. All rights reserved.
//

import UIKit


class HomeVC: BaseViewController {

    lazy var segmentedView: JXSegmentedView = JXSegmentedView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: CGFloat(44)))
       lazy var listContainerView: JXSegmentedListContainerView! = {
              return JXSegmentedListContainerView(dataSource: self)
          }()
       var titles = ["关注", "推荐", "私照", "视频"]
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
        dataSource.isItemSpacingAverageEnabled = false
        segmentedView.dataSource = dataSource
        segmentedView.contentEdgeInsetLeft = 15

               
        let lineView = JXSegmentedIndicatorLineView()
        lineView.indicatorColor = color_theme
        lineView.indicatorHeight = 4
        lineView.indicatorWidth = 18
        lineView.indicatorCornerRadius = 2
        segmentedView.indicators = [lineView]
                 
        segmentedView.listContainer = listContainerView
               view.addSubview(listContainerView)
        
    }
    
    override func viewDidLayoutSubviews() {
              super.viewDidLayoutSubviews()

        segmentedView.frame = CGRect(x: 0, y: YMKDvice.statusBarHeight(), width: view.bounds.size.width, height: 44)
        listContainerView.frame = CGRect(x: 0, y:YMKDvice.navBarHeight(), width: ScreenWidth, height: ScreenHeight - YMKDvice.tabBarHeight() - YMKDvice.navBarHeight())
          }


 

}

extension HomeVC:JXSegmentedViewDelegate
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

extension HomeVC: JXSegmentedListContainerViewDataSource {
    func numberOfLists(in listContainerView: JXSegmentedListContainerView) -> Int {
        if let titleDataSource = segmentedView.dataSource as? JXSegmentedBaseDataSource {
            return titleDataSource.dataSource.count
        }
        return 0
    }

    func listContainerView(_ listContainerView: JXSegmentedListContainerView, initListAt index: Int) -> JXSegmentedListContainerViewListDelegate {
        
        if index == 0 {
            let vc = FollowVC()
            return vc
        }else if index == 1{
            let vc = RecommendVC()
                       return vc
        }else if index == 2{
            let vc = PrivatePhotoVC()
                       return vc
        }else{
            let vc = VideoVC()
                       return vc
        }
    }
        
}

