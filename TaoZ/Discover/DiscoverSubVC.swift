//
//  DiscoverSubVC.swift
//  TaoZ
//
//  Created by liuxiang on 08/05/2020.
//  Copyright © 2020 liuxiang. All rights reserved.
//

import UIKit

class DiscoverSubVC: BaseViewController {
    
    @IBOutlet weak var uploadB: UIButton!
    @IBOutlet weak var tableView: UITableView!
    var tz_dataList:[DiscoverModel]! = [DiscoverModel]()
    var pageNum = 1
    public var type:Int!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navBar.isHidden = true
        // Do any additional setup after loading the view.
        
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableView.automaticDimension
        
        
        tableView.mj_header = MJRefreshNormalHeader(refreshingBlock: {[weak self] in
            self?.pageNum = 1
            self?.load_data()
        })
        
        tableView.mj_footer = MJRefreshBackNormalFooter(refreshingBlock: {[weak self] in
            self?.load_data()
        })
        
        tableView.mj_header?.beginRefreshing()
        
        self.uploadB.layer.cornerRadius = 27
        self.uploadB.layer.masksToBounds = true
        if type == 0{
            self.uploadB.isHidden = true
        }else{
            self.uploadB.isHidden = false
        }
        
        
        
    }
    
    @IBAction func uploadAC(_ sender: Any) {
    }
    
    
    func load_data() {
        
        var typeStr = "attention"
        if type == 1{
            typeStr = "all"
        }
        
        TZRequest(url_dynamic_selectdynamic,bodyDict: ["type":typeStr,"page":"\(pageNum)","pagesize":"20"],show: false) { (result, code) in
            if code == 0{
//                guard let models = [DiscoverModel].deserialize(from: result?["rows"] as? NSArray)  else {
//                    return
//                }
                 let models =  [DiscoverModel].deserialize(from: result?["data"] as? NSArray) as! [DiscoverModel]
                
                if self.pageNum == 1 {
                    
                    self.tz_dataList = models
                }else{
                    self.tz_dataList += models
                }
                
                self.pageNum += 1
                self.tableView.mj_footer?.endRefreshing()
                self.tableView.mj_header?.endRefreshing()
                //                               if self.dataList.count == 0 {
                //                                   self.tableView.mj_footer?.endRefreshingWithNoMoreData()
                //                               }
                
                
                //添加空白页
                BlankpageHelper.addDateEmpty(self.tableView, config: BlankpageHelper.emptyaSetConfig(tipStr: "桃妹们正忙着拍图，没空发动态了~"))
                self.tableView.reloadData()
                
            }else{
                
                self.tableView.mj_header?.endRefreshing()
                self.tableView.mj_footer?.endRefreshing()
                
            }
        
        
    }
    
}
}


extension DiscoverSubVC: JXSegmentedListContainerViewListDelegate {
    
    func listView() -> UIView {
        return view
    }
    
    func listScrollView() -> UIScrollView {
        return self.tableView
    }
    
}

extension DiscoverSubVC: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tz_dataList?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //说明是图片
        let indentifier = "DiscoverCellID"
        var cell:DiscoverCell! = tableView.dequeueReusableCell(withIdentifier: indentifier) as? DiscoverCell
        if cell == nil {
            cell = Bundle.main.loadNibNamed("DiscoverCell", owner: nil, options: nil)?.last as? DiscoverCell
            cell.selectionStyle = .none
            
        }
        //        cell.model = tz_dataList[indexPath.row]
        cell.tz_configCell(model: tz_dataList[indexPath.row])
        //        cell.model = "3"
        
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
    //
    //    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    //        let model = tz_dataList[indexPath.row]
    ////        let model = "3"
    //
    //        let height = tableView.cellHeight(for: indexPath, model: model, keyPath:"model", cellClass:DiscoverCell.self , contentViewWidth: ScreenWidth)
    ////       let H = Int(self.cellHeight(for: indexPath, cellContentViewWidth: ScreenWidth, tableView: tableView))
    //        return height;
    //    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        print("点击了")
        
    }
}

