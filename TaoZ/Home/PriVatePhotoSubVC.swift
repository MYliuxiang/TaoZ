//
//  PriVatePhotoSubVC.swift
//  TaoZ
//
//  Created by liuxiang on 07/05/2020.
//  Copyright © 2020 liuxiang. All rights reserved.
//

import UIKit

class PriVatePhotoSubVC: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension PriVatePhotoSubVC: JXSegmentedListContainerViewListDelegate {
    
    func listView() -> UIView {
        return view
    }

   
//    func listScrollView() -> UIScrollView {
//        return self.tableView
//    }

}
