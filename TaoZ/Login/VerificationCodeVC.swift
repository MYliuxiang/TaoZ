//
//  VerificationCodeVC.swift
//  TaoZ
//
//  Created by liuxiang on 2020/5/21.
//  Copyright © 2020 liuxiang. All rights reserved.
//

import UIKit

class VerificationCodeVC: BaseViewController {

    @IBOutlet weak var tipLab: UILabel!
    @IBOutlet weak var aginBtn: UIButton!
    @IBOutlet weak var codeTextField: LimitedTextField!
    var phoneStr:String?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        navBar.isHidden = true
        tipLab.isHidden = true
        aginBtn.layer.cornerRadius = 22
        aginBtn.layer.masksToBounds = true
        

        codeTextField.rx.text.orEmpty.throttle(0.3,scheduler: MainScheduler.instance).subscribe(onNext: { [weak self](text) in
            if text.count == 4{
                self?.loginAC()
            }else if text.count > 4{
                self?.codeTextField.text = text.ex_substring(to: 4)
            }else{
                self?.tipLab.isHidden = true
            }
            
        }).disposed(by: rx.disposeBag)
        
       
    }
    
    func loginAC(){
        
        view.endEditing(true)

        var postDic:[String:Any] = ["mobile":phoneStr!,"captcha":codeTextField.text!,"uuid":DeviceId ?? "","ts":Date().timeStamp]
        var signStr = ""
            
        signStr.append("captcha=\(postDic["captcha"] as! String)&mobile=\(postDic["mobile"] as! String)&ts=\(postDic["ts"] as! String)&uuid=\(postDic["uuid"] as! String)")
        
        let hmac = try! HMAC(key: SignKey.bytes, variant: .sha256).authenticate(signStr.bytes).toHexString()
        postDic["sign"] = hmac
                
        _ = sendPostRequest(User_mobilelogin,postDict: postDic, success: { (result) in
            if result!["code"] as! Int == 0{
                //实例对象转换成Data
                let dic = result!["data"] as? [String:Any]
                let modelData = NSKeyedArchiver.archivedData(withRootObject: dic!["userinfo"] as Any)
                //存储Data对象
                 UserDefaults.standard.set(modelData, forKey: userDefaults_userInfo)
                 UserDefaults.standard.set(true, forKey: isLogin)
                 UserDefaults.standard.synchronize()
                TabBarObject.shareInstance.tabBarController.selectedIndex = 0
                let vcs = TabBarObject.shareInstance.tabBarController.viewControllers ?? []
                for vc in vcs  {
                   let navVC = vc as? BaseNavigationController
                    navVC?.popToRootViewController(animated: true)
                }
                
                self.navigationController?.dismiss(animated: true, completion: nil)
                

            }else{
                
                self.tipLab.isHidden = false
                self.view.makeToast(result?["msg"] as? String, duration: 0.35, position: .center)

            }
        }, failure: { (error) in

        })
        
    }


    @IBAction func backAC(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    

}
