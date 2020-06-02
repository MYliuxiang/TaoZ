//
//  PasswordLoginVC.swift
//  TaoZ
//
//  Created by liuxiang on 2020/5/22.
//  Copyright © 2020 liuxiang. All rights reserved.
//

import UIKit

class PasswordLoginVC: BaseViewController {
    
    @IBOutlet weak var agreeL: YYLabel!
    @IBOutlet weak var loginB: UIButton!
    @IBOutlet weak var pwF: LimitedTextField!
    @IBOutlet weak var phoneF: LimitedTextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        navBar.isHidden = true
        loginB.layer.cornerRadius = 22
        loginB.layer.masksToBounds = true
        
        let text = NSMutableAttributedString(string: agreeL.text!)
        text.yy_color = UIColor.colorWithHexStr("#B6B4B4")
        text.yy_setTextHighlight(NSRange(location: 8,length: 11), color: UIColor.colorWithHexStr("#999999"), backgroundColor: .white) { (view, attrString, range, rect) in
            
            print("点击了用户协议")
        }
        agreeL.attributedText = text
        agreeL.isUserInteractionEnabled = true
    }
    
    @IBAction func sect(_ sender: UIButton) {
        
        sender.isSelected = !sender.isSelected
        pwF.isSecureTextEntry = sender.isSelected
    }
    
    @IBAction func loginAC(_ sender: Any) {
        if phoneF.text?.count == 0{
            MBProgressHUD.showError("请输入手机号码", to: keywindow)
            return
        }
        if !(phoneF.text?.ex_isPhoneNumber ?? true){
            MBProgressHUD.showError("请输入正确手机号码", to: keywindow)
            return
        }
        if pwF.text?.count == 0{
            MBProgressHUD.showError("请输入密码", to: keywindow)
            return
        }
        
        view.endEditing(true)

        var postDic:[String:Any] = ["mobile":phoneF.text!,"password":pwF.text!,"uuid":DeviceId ?? "","ts":Date().timeStamp]
        var signStr = ""
            
        signStr.append("mobile=\(postDic["mobile"] as! String)&password=\(postDic["password"] as! String)&ts=\(postDic["ts"] as! String)&uuid=\(postDic["uuid"] as! String)")
        let hmac = try! HMAC(key: SignKey.bytes, variant: .sha256).authenticate(signStr.bytes).toHexString()
        postDic["sign"] = hmac
        
        
        TZRequest(url_user_login,bodyDict: postDic) { (result, code) in
            if code == 0{
                let dic = result!["data"] as? [String:Any]
                guard let model = UserInfoModel.deserialize(from: dic?["userinfo"] as? NSDictionary ) else {
                    return
                }
                
                UserInfoModel.saveUserInfo(model)
                TabBarObject.shareInstance.tabBarController.selectedIndex = 0
                let vcs = TabBarObject.shareInstance.tabBarController.viewControllers ?? []
                for vc in vcs  {
                    let navVC = vc as? BaseNavigationController
                    navVC?.popToRootViewController(animated: true)
                }
                
                self.navigationController?.dismiss(animated: true, completion: nil)
            }
            
        }        
        
    }
    
    @IBAction func findpwAC(_ sender: Any) {
        let vc = BindePhoneVC()
        vc.typeStr = "验证手机号"
        vc.type = "pw"
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    
    @IBAction func backAC(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
}
