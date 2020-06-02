//
//  SetVC.swift
//  TaoZ
//
//  Created by liuxiang on 12/05/2020.
//  Copyright © 2020 liuxiang. All rights reserved.
//

import UIKit

class SetVC: BaseViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var titles = ["设置密码","更改手机","清除缓存","用户协议","隐私条例","退出登录"]
    override func viewDidLoad() {
        super.viewDidLoad()
        navBar.title = "设置"
        
        // Do any additional setup after loading the view.
    }
    
    
    
}

extension SetVC: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let indentifier = "VideoCellID"
        var cell:UITableViewCell! = tableView.dequeueReusableCell(withIdentifier: indentifier)
        if cell == nil {
            cell = UITableViewCell.init(style: .value1, reuseIdentifier: indentifier)
            cell.selectionStyle = .none
            cell.accessoryType = .disclosureIndicator
            
        }
        
        cell.textLabel?.text = titles[indexPath.row]
        cell.textLabel?.textColor = color_3
        cell.textLabel?.font = .systemFont(ofSize: 16)
        cell.detailTextLabel?.textColor = color_9
        cell.detailTextLabel?.font = .systemFont(ofSize: 14)
        if indexPath.row == 2{
            cell.detailTextLabel?.text = "\(YMKBasicTool.defaultIAPHelper.getCacheSize())M"
        }else{
            cell.detailTextLabel?.text = ""
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
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 52
    }
    
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView.init()
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.1
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.row == 2{
            let alertView = UIAlertController(title: nil,message: "确定清空本地缓存记录?", preferredStyle: .alert)
            let alertAction1 = UIAlertAction(title: "确认", style: .default, handler:{[weak self](alertAction:UIAlertAction)->()in
                
                YMKBasicTool.defaultIAPHelper.clearCache()
                self?.tableView.reloadRows(at: [indexPath], with: .none)
                
            })
            let alertAction2 = UIAlertAction(title: "取消", style: .destructive, handler: {
                (alerts: UIAlertAction!)->Void in
                
            })
            alertView.addAction(alertAction1)
            alertView.addAction(alertAction2)
            present(alertView, animated: true, completion: nil)
            
        }
        
        if indexPath.row == 5{
            let alertView = UIAlertController(title: nil,message: "是否确认退出？", preferredStyle: .alert)
            let alertAction1 = UIAlertAction(title: "确认", style: .default, handler:{
                [weak self](alertAction:UIAlertAction)->()in
                TZRequest(url_user_logout) { (result, code) in
                    if code == 0{
                        let nav = BaseNavigationController(rootViewController: LoginVC())
                        
                        nav.modalPresentationStyle = .fullScreen
                        TabBarObject.shareInstance.tabBarController.present(nav, animated: false, completion: nil)
                        
                        UserInfoModel.removeUserInfo()
                        TabBarObject.shareInstance.tabBarController.selectedIndex = 0
                        self?.navigationController?.popToRootViewController(animated: true)
                        
                    }
                }
                
                
            })
            let alertAction2 = UIAlertAction(title: "取消", style: .destructive, handler: {
                (alerts: UIAlertAction!)->Void in
                
            })
            alertView.addAction(alertAction1)
            alertView.addAction(alertAction2)
            present(alertView, animated: true, completion: nil)
        }
    }
}
