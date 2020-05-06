//
//  TabBarBasicContentView.swift
//  JZYZApp
//
//  Created by 李江 on 2020/2/23.
//  Copyright © 2020 李江. All rights reserved.
//

import UIKit
import ESTabBarController_swift

//设置tabbar选中颜色
class TabBarBasicContentView: ESTabBarItemContentView {

    override init(frame: CGRect) {
        super.init(frame: frame)

        textColor = UIColor.colorWithHexStr("#C3CFCF")
        highlightTextColor = UIColor.colorWithHexStr("#051724")


    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
   
    
}
