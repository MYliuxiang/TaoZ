//
//  LoginVC.swift
//  MayBe
//
//  Created by liuxiang on 09/04/2020.
//  Copyright © 2020 liuxiang. All rights reserved.
//

import UIKit

class LoginVC: BaseViewController {

    @IBOutlet weak var agreeLab: YYLabel!
    @IBOutlet weak var agreementLab: UILabel!
    @IBOutlet weak var phonLoginBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        navBar.isHidden = true
        // Do any additional setup after loading the view.
       
        
        setUI()
    }
    
    @IBAction func loaginAC(_ sender: Any) {
        
        UserDefaultsStandard.set(true, forKey: isLogin)
        navigationController?.dismiss(animated: true, completion: nil)
        
    }
    func setUI(){
        phonLoginBtn.layer.cornerRadius = 22
        phonLoginBtn.layer.masksToBounds = true
        
        let text = NSMutableAttributedString(string: agreeLab.text!)
        text.yy_color = UIColor.colorWithHexStr("#B6B4B4")
        text.yy_setTextHighlight(NSRange(location: 8,length: 11), color: color_theme, backgroundColor: .white) { (view, attrString, range, rect) in

            print("点击了用户协议")
        }
        agreeLab.attributedText = text
        agreeLab.isUserInteractionEnabled = true
        
        
    }

    @IBAction func weiLoginAC(_ sender: Any) {
        
        ThirdloginHelper.defaultIAPHelper.loginGetUserInfo(loginType: .weixin, successHandler: { (response, iDCredential) in
            
        }) { (erroe) in
            
        }
    }
    
    @IBAction func qqLoginAC(_ sender: Any) {
        
        ThirdloginHelper.defaultIAPHelper.loginGetUserInfo(loginType: .qq, successHandler: { (response, iDCredential) in
                   
               }) { (erroe) in
                   
               }
    }
    

}
