//
//  VideoSubVC.swift
//  TaoZ
//
//  Created by liuxiang on 07/05/2020.
//  Copyright © 2020 liuxiang. All rights reserved.
//

import UIKit

class VideoSubVC: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }


    

}


extension VideoSubVC: JXSegmentedListContainerViewListDelegate {
    
    func listView() -> UIView {
        return view
    }

   
//    func listScrollView() -> UIScrollView {
//        return self.tableView
//    }

}
