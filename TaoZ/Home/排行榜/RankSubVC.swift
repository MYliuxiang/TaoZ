//
//  RankSubVC.swift
//  TaoZ
//
//  Created by liuxiang on 2020/6/6.
//  Copyright © 2020 liuxiang. All rights reserved.
//

import UIKit

class RankSubVC: BaseViewController {

    @IBOutlet weak var tableView: UITableView!
    var listViewDidScrollCallback: ((UIScrollView) -> ())?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        navBar.isHidden = true

    }


  

}

extension RankSubVC: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let indentifier = "VideoCellID"
        var cell:RankSubCell! = tableView.dequeueReusableCell(withIdentifier: indentifier) as? RankSubCell
        if cell == nil {
            cell = Bundle.main.loadNibNamed("RankSubCell", owner: nil, options: nil)?.last as? RankSubCell
            cell.selectionStyle = .none
            
        }
        return cell
        
        
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.1
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        
        return view
    }
    
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView.init()
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.1
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
               
        self.listViewDidScrollCallback?(scrollView)
           
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
    }
}
extension RankSubVC: JXPagingViewListViewDelegate {
     func listView() -> UIView {
           return view
       }

       func listViewDidScrollCallback(callback: @escaping (UIScrollView) -> ()) {
           self.listViewDidScrollCallback = callback
       }

       func listScrollView() -> UIScrollView {
           return self.tableView
       }

}

