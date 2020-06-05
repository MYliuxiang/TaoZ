//
//  CancleReleseAlert.swift
//  TaoZ
//
//  Created by liuxiang on 2020/6/5.
//  Copyright © 2020 liuxiang. All rights reserved.
//

import UIKit

class CancleReleseAlert: LxCustomAlert {
    
    @IBOutlet weak var btn2: UIButton!
    @IBOutlet weak var btn1: UIButton!
    var btnblock:((_ index:Int) ->())?
    
    @IBAction func btn1AC(_ sender: Any) {
        if btnblock != nil {
            btnblock!(0)
        }
        self.disMiss()
    }
    
    @IBAction func btn2AC(_ sender: Any) {
        disMiss()
    }
}
extension CancleReleseAlert{
    
    convenience init() {
//        self.init()
        self.init(frame:CGRect.zero)
        self.layer.cornerRadius = 10
        self.layer.masksToBounds = true
        self.snp.makeConstraints { (make) in
            make.bottom.equalTo(btn1).offset(25)
            make.width.equalTo(ScreenWidth - 50)
        }
        
        btn1.layer.cornerRadius = 18
        btn1.layer.masksToBounds = true
        btn1.layer.borderColor = color_3.cgColor
        btn1.layer.borderWidth = 1
        
        btn2.layer.cornerRadius = 18
        btn2.layer.masksToBounds = true
        
    }
    
}
