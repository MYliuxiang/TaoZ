//
//  LoginVC.swift
//  MayBe
//
//  Created by liuxiang on 09/04/2020.
//  Copyright © 2020 liuxiang. All rights reserved.
//

import UIKit

class LoginVC: BaseViewController {

    @IBOutlet weak var phoneTextField: LimitedTextField!
    @IBOutlet weak var agreeLab: YYLabel!
    @IBOutlet weak var tiplab: UILabel!
    @IBOutlet weak var tipImg: UIImageView!
    @IBOutlet weak var agreementLab: UILabel!
    @IBOutlet weak var phonLoginBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        navBar.isHidden = true
        // Do any additional setup after loading the view.
        setUI()
                
        phoneTextField.rx.text.orEmpty.asObservable()
                   .subscribe(onNext: { [weak self] in
                    
                    if $0.count == 11{
                        if $0.ex_isPhoneNumber{
                        //是手机号码正确
                            self?.tipImg.isHidden = false
                            self?.tiplab.isHidden = true
                        }else{
                            self?.tipImg.isHidden = true
                            self?.tiplab.isHidden = false
                        }
                    }else if($0.count > 11){
                        self?.phoneTextField.text = $0.ex_substring(to: 11)
                    }else{
                        self?.tipImg.isHidden = true
                        self?.tiplab.isHidden = true
                    }
                    
                   
                   })
            .disposed(by: rx.disposeBag)
                
        
    }
    
    @IBAction func loaginAC(_ sender: Any) {
        
       
        view.endEditing(true)
        if !(phoneTextField.text?.ex_isPhoneNumber ?? false){

            MBProgressHUD.showError("请输入正确的手机号码", to: keywindow)
            return
        }
        
        TZRequest(Sms_send, method: .post, bodyDict: ["mobile":phoneTextField.text!,"event":"mobilelogin"]) { (result, code) in
            if code == 0{
                let vc = VerificationCodeVC()
                vc.phoneStr = self.phoneTextField.text!
                vc.type = "mobilelogin"
                self.navigationController?.pushViewController(vc, animated: true)
            }
            
        }
 
    }
    
    func setUI(){
        phonLoginBtn.layer.cornerRadius = 22
        phonLoginBtn.layer.masksToBounds = true
        
        let text = NSMutableAttributedString(string: agreeLab.text!)
        text.yy_color = UIColor.colorWithHexStr("#B6B4B4")
        text.yy_setTextHighlight(NSRange(location: 8,length: 11), color: UIColor.colorWithHexStr("#999999"), backgroundColor: .white) { (view, attrString, range, rect) in

            print("点击了用户协议")
        }
        agreeLab.attributedText = text
        agreeLab.isUserInteractionEnabled = true
        
        
    }

    @IBAction func weiLoginAC(_ sender: Any) {
        
        ThirdloginHelper.defaultIAPHelper.loginGetUserInfo(loginType: .weixin, successHandler: { (response, iDCredential) in
            
            let postDic = ["sdkid":(response?.uid)! as String,"type":"wechat","ts":Date().timeStamp]
            
            TZRequest(User_sdklogin, method: .post ,bodyDict: postDic) { (result, code) in
                if code == 0{
                    let dic = result!["data"] as? [String:Any]
                    if dic == nil{
                        
                        let vc = BindePhoneVC()
                        vc.type = "wechat"
                        vc.sdkid = (response?.uid)! as String
                        self.navigationController?.pushViewController(vc, animated: true)
                        
                    }else{
                        
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
            
            
            
        }) { (erroe) in
            
        }
    }
    
    @IBAction func qqLoginAC(_ sender: Any) {
        
        ThirdloginHelper.defaultIAPHelper.loginGetUserInfo(loginType: .qq, successHandler: { (response, iDCredential) in
                   
               }) { (erroe) in
                   
               }
    }
    

}
