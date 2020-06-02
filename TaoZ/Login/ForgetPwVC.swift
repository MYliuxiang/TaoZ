//
//  ForgetPwVC.swift
//  TaoZ
//
//  Created by liuxiang on 2020/6/2.
//  Copyright © 2020 liuxiang. All rights reserved.
//

import UIKit

class ForgetPwVC: BaseViewController {

    @IBOutlet weak var aginPwF: LimitedTextField!
    @IBOutlet weak var pwF: LimitedTextField!
    @IBOutlet weak var doneB: UIButton!
    public var phone:String!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        doneB.layer.cornerRadius = 22
        doneB.layer.masksToBounds = true
        navBar.isHidden = true
        
    }

    @IBAction func scureAC(_ sender: Any) {
        let btn = sender as! UIButton
        btn.isSelected = !btn.isSelected
        pwF.isSecureTextEntry = btn.isSelected
        aginPwF.isSecureTextEntry = btn.isSelected
    }
    
    @IBAction func backAC(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    @IBAction func doneAC(_ sender: Any) {
        if pwF.text?.count == 0 {
            MBProgressHUD.showError("请输入密码", to: keywindow)
            return
        }
        if pwF.text!.count < 6 {
            MBProgressHUD.showError("请输入6位数以上密码", to: keywindow)
            return
        }
        if aginPwF.text?.count == 0 {
            MBProgressHUD.showError("请再次输入密码", to: keywindow)
            return
        }
        if aginPwF.text != pwF.text{
            MBProgressHUD.showError("请检查，两次输入不一致", to: keywindow)
            return
        }
        
        
        TZRequest(url_user_resetpwd,bodyDict:["mobile":"\(phone ?? "")","captcha":pwF.text!,"newpassword":aginPwF.text!] ) { (result, code) in
            if code == 0{
                
                MBProgressHUD.showError("设置成功", to: keywindow)
                let vc = self.navigationController?.viewControllers[(self.navigationController?.viewControllers.count)! - 4]
                self.navigationController?.popToViewController(vc!, animated: true)
            }
        }
        
        
    }
   
}
