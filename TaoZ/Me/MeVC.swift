//
//  MeVC.swift
//  MayBe
//
//  Created by liuxiang on 09/04/2020.
//  Copyright © 2020 liuxiang. All rights reserved.
//

import UIKit

class MeVC: BaseViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet var headerView: UIView!
    var titles:[String]?
    var model:UserInfoModel!
    override func viewDidLoad() {
        super.viewDidLoad()

        navBar.isHidden = true
        // Do any additional setup after loading the view.
        model = UserInfoModel.loadUserInfo()
        headerView.height = 64 + 44 + 92
        self.tableView.tableHeaderView = headerView
        titles = ["关注","相册","收藏","钱包","作品","动态","客服","设置"]
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadData()
    }
    
    func loadData(){
        TZRequest(url_user_userinfo, bodyDict: ["user_id":model.user_id ?? "","friend_id":model.user_id ?? ""],show:false) { (result, code) in
            if code == 0{
                let dic = result?["data"] as? [String : Any]
                guard let model = UserInfoModel.deserialize(from: dic?["userInfo"] as? [String:Any]) else {
                    return
                }
                self.model  = model
                UserInfoModel.saveUserInfo(model)
                self.tableView.reloadData()
            }
        }
        
    }


   
    @IBAction func headerAC(_ sender: Any) {
        
        navigationController?.pushViewController(PersonalVC(), animated: true)
    }
    
}

extension MeVC: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titles?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //说明是图片
        
        let indentifier = "CellID"
        var cell:MeCell! = tableView.dequeueReusableCell(withIdentifier: indentifier) as? MeCell
        if cell == nil {
            cell = Bundle.main.loadNibNamed("MeCell", owner: nil, options: nil)?.last as? MeCell
            cell.selectionStyle = .none
            cell.accessoryType = .disclosureIndicator
            
        }
        cell.contentLab.text = titles?[indexPath.row]
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = UIColor.colorWithHexStr("#f7f7f7")
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
          return 0.1
      }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView.init()
    }
    
  
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        print("点击了")
        
//  ["关注","相册","收藏","钱包","作品","动态","客服","设置"]

        switch indexPath.row {
        case 0:
            navigationController?.pushViewController(MyFollow(), animated: true)
            break
        case 1:
            navigationController?.pushViewController(MyAlbumVC(), animated: true)
            break
        case 2:
            navigationController?.pushViewController(MyCollectionVC(), animated: true)

            break
        case 3:
            navigationController?.pushViewController(MyWalletVC(), animated: true)

            break
        case 4:
            navigationController?.pushViewController(MyWorksVC(), animated: true)

            break
        case 5:
            navigationController?.pushViewController(MyDynamicVC(), animated: true)

            break
        case 6:
            navigationController?.pushViewController(CustomerVC(), animated: true)

            break
        case 7:
            navigationController?.pushViewController(SetVC(), animated: true)

            break

        default:
            break
        }
        if indexPath.row == 0{
            
        }
        
    }
}

