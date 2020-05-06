//
//  TabBarIrregularityBasicContentView.swift
//  JZYZApp
//
//  Created by 李江 on 2020/2/23.
//  Copyright © 2020 李江. All rights reserved.
//

import UIKit
import ESTabBarController_swift

class TabBarIrregularityBasicContentView: TabBarBouncesContentView {

     override init(frame: CGRect) {
        super.init(frame: frame)
//        iconColor = UIColor.init(white: 175.0 / 255.0, alpha: 1.0)
//        highlightIconColor = UIColor.init(red: 254/255.0, green: 73/255.0, blue: 42/255.0, alpha: 1.0)
       
        self.renderingMode = UIImage.RenderingMode.alwaysOriginal //设置按原始图片来显示
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func updateLayout() {
        super.updateLayout()
            
        self.imageView.sizeToFit()
        self.imageView.center = CGPoint.init(x: self.bounds.size.width / 2.0, y: self.bounds.size.height / 2.0 - 2)
        self.titleLabel.font = UIFont.customName("SemiBold", size: 9)

    }

}

class TabBarIrregularityContentView: ESTabBarItemContentView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    
        self.imageView.backgroundColor = UIColor.clear
        self.imageView.layer.borderWidth = 2.0
        self.imageView.layer.borderColor = UIColor.clear.cgColor
        self.imageView.layer.cornerRadius = 35
        self.insets = UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 0)
        let transform = CGAffineTransform.identity
        self.imageView.transform = transform
        self.superview?.bringSubviewToFront(self)
        
      
        titleLabel.font = UIFont.systemFont(ofSize: 9)
        //        iconColor = UIColor.init(white: 255.0 / 255.0, alpha: 1.0)
//        highlightIconColor = UIColor.init(white: 255.0 / 255.0, alpha: 1.0)
        self.renderingMode = UIImage.RenderingMode.alwaysOriginal //设置按原始图片来显示
        backdropColor = .clear
        highlightBackdropColor = .clear
        
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        let p = CGPoint.init(x: point.x - imageView.frame.origin.x, y: point.y - imageView.frame.origin.y)
        return sqrt(pow(imageView.bounds.size.width / 2.0 - p.x, 2) + pow(imageView.bounds.size.height / 2.0 - p.y, 2)) < imageView.bounds.size.width / 2.0
    }
            
//    override func updateLayout() {
//        super.updateLayout()
//        self.imageView.sizeToFit()
//        self.imageView.center = CGPoint.init(x: self.bounds.size.width / 2.0, y: self.bounds.size.height / 2.0)
//    }
    
   
    
}
