//
//  VerificationCodeVC.swift
//  TaoZ
//
//  Created by liuxiang on 2020/5/21.
//  Copyright © 2020 liuxiang. All rights reserved.
//

import UIKit

let countDownSeconds: Int = 60

enum CodeEnum:String {
    
    ///注册
    case register = "register"
    ///修改手机号
    case changemobile = "changemobile"
    ///修改密码
    case changepwd = "changepwd"
    ///设置密码
    case resetpwd = "resetpwd"
    ///手机验证码登录
    case mobilelogin = "mobilelogin"
    ///sdkbindphone
    case sdkbindphone = "sdkbindphone"
    
    
//    var image: UIImage {
//        switch self {
//        case .newCar:
//            return  UIImage(named: "category2") ?? UIImage()
//        case .usedCar:
//            return  UIImage(named: "category1") ?? UIImage()
//        case .boutiqueAccessories:
//            return UIImage(named: "category1") ?? UIImage()
//        case .zeroPurchase:
//            return UIImage(named: "category6") ?? UIImage()
//        default:
//            return UIImage()
//        }
//    }
    
}

class VerificationCodeVC: BaseViewController {

    @IBOutlet weak var tipLab: UILabel!
    @IBOutlet weak var aginBtn: UIButton!
    @IBOutlet weak var codeTextField: LimitedTextField!
    var phoneStr:String?
    var type:String?
    var sdkid:String?
    var sdkType:String?
    let timer = Observable<Int>.timer(DispatchTimeInterval.seconds(0), period: DispatchTimeInterval.seconds(1), scheduler: MainScheduler.instance)
    let countDownStopped = BehaviorRelay(value: true)


    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        navBar.isHidden = true
        tipLab.isHidden = true
        aginBtn.layer.cornerRadius = 22
        aginBtn.layer.masksToBounds = true
        
        daojishiAC()
        

        codeTextField.rx.text.orEmpty.throttle(DispatchTimeInterval.seconds(1),scheduler: MainScheduler.instance).observeOn(MainScheduler.asyncInstance).subscribe(onNext: { [weak self](text) in
            if text.count == 4{
//                self?.doneAC()
            }else if text.count > 4{
                self?.codeTextField.text = text.ex_substring(to: 4)
            }else{
                self?.tipLab.isHidden = true
            }
            
        }).disposed(by: rx.disposeBag)
       

        
        codeTextField.rx.controlEvent([.editingChanged]) //状态可以组合
            .asObservable().subscribe(onNext: { [weak self] _ in
                if self?.codeTextField.text?.count == 4{
                    self?.doneAC()

                }
            }).disposed(by: rx.disposeBag)

       
    }
    
    func doneAC(){
        //验证码登录
        if type == "mobilelogin" {
            mobileloginAC()
        }else if type == "sdkbindphone"{
            sdkBindPhone()
        }else{
            let vc = ForgetPwVC()
            vc.phone = phoneStr
            navigationController?.pushViewController(vc, animated: true)
        }
        
    }
    
    @IBAction func aginAC(_ sender: Any) {
        
        loadCode()
    }
    func daojishiAC(){
        self.aginBtn.isEnabled = false
        countDownStopped.accept(false)
        
       
        self.timer.takeUntil(self.countDownStopped.asObservable().filter{$0}).observeOn(MainScheduler.asyncInstance).subscribe(onNext: { [weak self](timer) in
            self?.aginBtn.setTitle("重新发送 (\(5 - timer)s)", for: .normal)
            if timer == 5{
                self!.countDownStopped.accept(true)
                self?.aginBtn.isEnabled = true
                self?.aginBtn.setTitle("重新发送", for: .normal)
            }
            
            
        }).disposed(by: rx.disposeBag)

    }
    
    func loadCode(){
        
        
        TZRequest(url_Sms_send,bodyDict:["mobile":phoneStr!,"event":type!] ) { (result, code) in
            if code == 0{
                self.daojishiAC()
            }
        }
       
    }
    
    func mobileloginAC(){
        
        view.endEditing(true)

        var postDic:[String:Any] = ["mobile":phoneStr!,"captcha":codeTextField.text!,"uuid":DeviceId ?? "","ts":Date().timeStamp]
        var signStr = ""
            
        signStr.append("captcha=\(postDic["captcha"] as! String)&mobile=\(postDic["mobile"] as! String)&ts=\(postDic["ts"] as! String)&uuid=\(postDic["uuid"] as! String)")
        
        let hmac = try! HMAC(key: SignKey.bytes, variant: .sha256).authenticate(signStr.bytes).toHexString()
        postDic["sign"] = hmac
        
        
        TZRequest(url_User_mobilelogin,bodyDict: postDic) { (result, code) in
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
            }else{
                self.tipLab.isHidden = false
            }
        }
                
        
        
    }
    
    func sdkBindPhone(){
        view.endEditing(true)

        let postDic:[String:String] = ["mobile":phoneStr!,"type":self.sdkType!,"sdkid":self.sdkid!,"ts":Date().timeStamp]
        
        
        TZRequest(url_User_sdkbindphone,bodyDict:postDic ) { (result, code) in
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
                
                
            }else{
                
                self.tipLab.isHidden = false
                self.view.makeToast(result?["msg"] as? String, duration: 0.35, position: .center)
                
            }
        }
      
    }


    @IBAction func backAC(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    

}
