//
//  CommentVC.swift
//  TaoZ
//
//  Created by liuxiang on 14/05/2020.
//  Copyright © 2020 liuxiang. All rights reserved.
//

import UIKit

class CommentVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func longFormHeight() -> PanModalHeight {
        return PanModalHeight(type: .content, height: ScreenHeight - 246)
    }
    
    override func showDragIndicator() -> Bool {
           return false
       }
    override func backgroundAlpha() -> CGFloat {
        return 0.3
    }
   

}
