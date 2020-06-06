//
//  RecommendVC.swift
//  TaoZ
//
//  Created by liuxiang on 07/05/2020.
//  Copyright © 2020 liuxiang. All rights reserved.
//

import UIKit

class RecommendVC: BaseViewController {

    @IBOutlet var headerView: UIView!
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        navBar.isHidden = true

        headerView.height = (ScreenWidth - 30) / 345 * 154 + 15 + 55 + 15
        tableView.tableHeaderView = headerView
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableView.automaticDimension

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func vipVC(_ sender: Any) {
        self.navigationController?.pushViewController(VipCenterVC(), animated: true)
    }
    
    @IBAction func signAC(_ sender: Any) {
    }
    
    @IBAction func paihAC(_ sender: Any) {
        navigationController?.pushViewController(RankingVC(), animated: true)
    }
    

}

extension RecommendVC: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //说明是图片
        if indexPath.row % 2 == 0 {
            let indentifier = "PhotoCellID"
            var cell:PhotoCell! = tableView.dequeueReusableCell(withIdentifier: indentifier) as? PhotoCell
            if cell == nil {
                cell = Bundle.main.loadNibNamed("PhotoCell", owner: nil, options: nil)?.last as? PhotoCell
                cell.selectionStyle = .none
                
            }
            return cell
        }else{
            
            let indentifier = "VideoCellID"
            var cell:VideoCell! = tableView.dequeueReusableCell(withIdentifier: indentifier) as? VideoCell
            if cell == nil {
                cell = Bundle.main.loadNibNamed("VideoCell", owner: nil, options: nil)?.last as? VideoCell
                cell.selectionStyle = .none
                
            }
            return cell
        }
        
        
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 44
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        let lab = UILabel()
        lab.font = UIFont.boldSystemFont(ofSize: 18)
        lab.text = "桃汁推荐"
        lab.textColor = color_3
        view.addSubview(lab)
        lab.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(15)
            make.bottom.equalToSuperview()
        }
                
        return view
    }
    
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView.init()
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.1
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        print("点击了")
        
    }
}


extension RecommendVC: JXSegmentedListContainerViewListDelegate {
    
    func listView() -> UIView {
        return view
    }

   
    func listScrollView() -> UIScrollView {
        return self.tableView
    }

}
