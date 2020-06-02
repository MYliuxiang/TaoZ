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
    
    @IBOutlet weak var titleL: UILabel!
    var sdkid:String?
    var type:String?
    public var typeStr:String!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        phonLoginBtn.layer.cornerRadius = 22
        phonLoginBtn.layer.masksToBounds = true
        navBar.isHidden = true
        
        titleL.text = typeStr
        
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

    @IBAction func backAC(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func codeAC(_ sender: Any) {
        view.endEditing(true)
        if !(phoneTextField.text?.ex_isPhoneNumber ?? false){
            
            self.view.makeToast("请输入正确的手机号码", duration: 0.35, position: .center)
            return
        }
        
        var dic = [String:Any]()
        if typeStr == "请绑定手机号" {
            dic = ["mobile":phoneTextField.text!,"event":"sdkbindphone"]
        }else{
            dic = ["mobile":phoneTextField.text!,"event":"changepwd"]
        }
        
        TZRequest(url_Sms_send,bodyDict: dic) { (result, code) in
            if code == 0{
                if self.typeStr == "请绑定手机号" {
                    let vc = VerificationCodeVC()
                    vc.phoneStr = self.phoneTextField.text!
                    vc.type = "sdkbindphone"
                    vc.sdkid = self.sdkid
                    vc.sdkType = self.type
                    self.navigationController?.pushViewController(vc, animated: true)
                }else{
                    let vc = VerificationCodeVC()
                    vc.phoneStr = self.phoneTextField.text!
                    vc.type = "changepwd"
                    self.navigationController?.pushViewController(vc, animated: true)
                    
                    
                }
              
            }
        }
        
    }
    
}
