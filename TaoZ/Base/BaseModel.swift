//
//  BaseModel.swift
//  GDDZ
//
//  Created by YMK on 2019/7/23.
//  Copyright © 2019 ymk. All rights reserved.
//

import UIKit
import HandyJSON

class BaseModel: HandyJSON {
    
    var code: String? //结果
    var message: String?//提示
    required init() {}
    func mapping(mapper: HelpingMapper) {
       
    }
    
    func didFinishMapping() {
        
    }

}
