//
//  DiscoverSubVC.swift
//  TaoZ
//
//  Created by liuxiang on 08/05/2020.
//  Copyright © 2020 liuxiang. All rights reserved.
//

import UIKit

class DiscoverSubVC: BaseViewController {

    @IBOutlet weak var tableView: UITableView!
    var tz_dataList:[DiscoverModel]! = [DiscoverModel]()
    override func viewDidLoad() {
        super.viewDidLoad()

        navBar.isHidden = true
        // Do any additional setup after loading the view.
        var model1 = DiscoverModel()
        model1.type = 0
        model1.images = ["",""]
        model1.videopath = "s"
        
        var model2 = DiscoverModel()
        model2.type = 1
        model2.images = ["",""]
        model2.videopath = "s"
        
        var model3 = DiscoverModel()
        model3.type = 1
        model3.images = ["","",""]
        model3.videopath = "s"
        
        
        var model4 = DiscoverModel()
        model4.type = 1
        model4.images = ["","","",""]
        model4.videopath = "s"
        
        
        var model5 = DiscoverModel()
        model5.type = 1
        model5.images = ["https://placehold.jp/151x151.png","https://placehold.jp/151x151.png","https://placehold.jp/151x151.png","https://placehold.jp/151x151.png","https://placehold.jp/151x151.png","https://placehold.jp/151x151.png","https://placehold.jp/151x151.png","https://placehold.jp/151x151.png","https://placehold.jp/151x151.png"]
        model5.videopath = "s"
        
        var model6 = DiscoverModel()
        model6.type = 1
        model6.images = ["https://placehold.jp/151x151.png","https://placehold.jp/151x151.png","https://placehold.jp/151x151.png","https://placehold.jp/151x151.png"]
        model6.videopath = "s"
        
        
        tz_dataList?.append(model1)
        tz_dataList?.append(model2)
        tz_dataList?.append(model3)
        tz_dataList?.append(model4)
        tz_dataList?.append(model5)
        tz_dataList?.append(model5)
        tz_dataList?.append(model5)
        tz_dataList?.append(model5)
        tz_dataList?.append(model5)
        tz_dataList?.append(model5)
        tz_dataList?.append(model5)
        tz_dataList?.append(model5)
        tz_dataList?.append(model6)


        
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableView.automaticDimension
        tableView.reloadData()

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

