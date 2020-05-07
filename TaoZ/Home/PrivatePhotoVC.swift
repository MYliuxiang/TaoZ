//
//  PrivatePhotoVC.swift
//  TaoZ
//
//  Created by liuxiang on 07/05/2020.
//  Copyright © 2020 liuxiang. All rights reserved.
//

import UIKit

class PrivatePhotoVC: BaseViewController {

    lazy var segmentedView: JXSegmentedView = JXSegmentedView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: CGFloat(44)))
    lazy var listContainerView: JXSegmentedListContainerView! = {
           return JXSegmentedListContainerView(dataSource: self)
       }()
    var titles = ["全部", "制服", "宅男女神", "妩媚", "清纯"]
    let dataSource: JXSegmentedTitleDataSource = JXSegmentedTitleDataSource()
    override func viewDidLoad() {
        super.viewDidLoad()
        navBar.isHidden = true
        view.addSubview(segmentedView)
                     
        segmentedView.backgroundColor = UIColor.clear
        segmentedView.delegate = self
        segmentedView.isContentScrollViewClickTransitionAnimationEnabled = false
        dataSource.titles = titles
        dataSource.titleSelectedColor = color_theme
        dataSource.titleSelectedFont = UIFont.systemFont(ofSize: 14)
        dataSource.titleNormalColor = color_6
        dataSource.titleNormalFont = UIFont.systemFont(ofSize: 14)
        dataSource.isTitleColorGradientEnabled = true
        dataSource.isTitleZoomEnabled = false
        dataSource.isItemSpacingAverageEnabled = false
        dataSource.itemWidthIncrement = 17
        segmentedView.dataSource = dataSource
        segmentedView.contentEdgeInsetLeft = 23.5
                      
               
        let lineView = JXSegmentedIndicatorBackgroundView()
        lineView.indicatorHeight = 27
        lineView.backgroundWidthIncrement = 17
        lineView.indicatorColor = UIColor.colorWithHexStr("#F7F7F7")
        segmentedView.indicators = [lineView]
        segmentedView.listContainer = listContainerView
        view.addSubview(listContainerView)

    }
    
    override func viewDidLayoutSubviews() {
                 super.viewDidLayoutSubviews()

           segmentedView.frame = CGRect(x: 0, y: 0, width: view.bounds.size.width, height: 44)
           listContainerView.frame = CGRect(x: 0, y:44, width: ScreenWidth, height: ScreenHeight - YMKDvice.tabBarHeight() - YMKDvice.navBarHeight() - 44)
             }

}

extension PrivatePhotoVC:JXSegmentedViewDelegate
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

extension PrivatePhotoVC: JXSegmentedListContainerViewDataSource {
    func numberOfLists(in listContainerView: JXSegmentedListContainerView) -> Int {
        if let titleDataSource = segmentedView.dataSource as? JXSegmentedBaseDataSource {
            return titleDataSource.dataSource.count
        }
        return 0
    }

    func listContainerView(_ listContainerView: JXSegmentedListContainerView, initListAt index: Int) -> JXSegmentedListContainerViewListDelegate {
        
            let vc = PriVatePhotoSubVC()
            return vc
        
    }
        
}

extension PrivatePhotoVC: JXSegmentedListContainerViewListDelegate {
    
    func listView() -> UIView {
        return view
    }

   
//    func listScrollView() -> UIScrollView {
//        return self.tableView
//    }

}
