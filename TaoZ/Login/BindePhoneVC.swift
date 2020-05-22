//
//  BindePhoneVC.swift
//  TaoZ
//
//  Created by liuxiang on 2020/5/21.
//  Copyright © 2020 liuxiang. All rights reserved.
//

import UIKit

class BindePhoneVC: BaseViewController {

    @IBOutlet weak var tipImg: UIImageView!
    @IBOutlet weak var phonLoginBtn: UIButton!
    @IBOutlet weak var tipLab: UILabel!
    @IBOutlet weak var phoneTextField: LimitedTextField!
    var sdkid:String?
    var type:String?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        phonLoginBtn.layer.cornerRadius = 22
        phonLoginBtn.layer.masksToBounds = true
        navBar.isHidden = true
        
        phoneTextField.rx.text.orEmpty.asObservable()
                          .subscribe(onNext: { [weak self] in
                          
                            if $0.count == 11{
                               if $0.ex_isPhoneNumber{
                               //是手机号码正确
                                   self?.tipImg.isHidden = false
                                   self?.tipLab.isHidden = true
                               }else{
                                   self?.tipImg.isHidden = true
                                   self?.tipLab.isHidden = false
                               }
                           }else if($0.count > 11){
                               self?.phoneTextField.text = $0.ex_substring(to: 11)
                           }else{
                               self?.tipImg.isHidden = true
                               self?.tipLab.isHidden = true
                           }
                           
                         
                          })
                   .disposed(by: rx.disposeBag)
                       

    }

   
    @IBAction func codeAC(_ sender: Any) {
        view.endEditing(true)
        if !(phoneTextField.text?.ex_isPhoneNumber ?? false){
            
            self.view.makeToast("请输入正确的手机号码", duration: 0.35, position: .center)
            return
        }

        _ = sendPostRequest(Sms_send,postDict:["mobile":phoneTextField.text!,"event":"sdkbindphone"],  success: { (result) in
            if result!["code"] as! Int == 0{
                
                let vc = VerificationCodeVC()
                vc.phoneStr = self.phoneTextField.text!
                vc.type = "sdkbindphone"
                vc.sdkid = self.sdkid
                vc.sdkType = self.type
                self.navigationController?.pushViewController(vc, animated: true)

            }else{
                self.view.makeToast(result?["msg"] as? String, duration: 0.35, position: .center)
                
            }
            
        }, failure: { (error) in
            
            self.view.makeToast("系统异常", duration: 0.35, position: .center)

        })
        
    }
    
}
