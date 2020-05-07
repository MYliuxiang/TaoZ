//
//  FollowVC.swift
//  TaoZ
//
//  Created by liuxiang on 07/05/2020.
//  Copyright © 2020 liuxiang. All rights reserved.
//

import UIKit

class FollowVC: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        navBar.isHidden = true
        // Do any additional setup after loading the view.
        
        let im = UIImageView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        im.image = UIImage.init(color: .red)
        view.addSubview(im)
        
        
        
    }




}

extension FollowVC: JXSegmentedListContainerViewListDelegate {
    
    func listView() -> UIView {
        return view
    }

   
//    func listScrollView() -> UIScrollView {
//        return self.tableView
//    }

}
