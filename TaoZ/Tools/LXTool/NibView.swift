//
//  NibView.swift
//  JZYZApp
//
//  Created by liuxiang on 2020/3/31.
//  Copyright © 2020 李江. All rights reserved.
//

import UIKit

class NibView: UIView {

    var view:UIView!
    override init(frame: CGRect) {
        super.init(frame: frame)
        xibSetup()
        
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        xibSetup()

    }

}

private extension NibView{
    
    func xibSetup(){
        backgroundColor = UIColor.clear
        view = loadNib()
        view.frame = bounds
        addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[childView]|",
                                                      options: [],
                                                      metrics: nil,
                                                      views: ["childView": view]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[childView]|",
                                                      options: [],
                                                      metrics: nil,
                                                      views: ["childView": view]))
        
    }
}

extension UIView {

    func loadNib() -> UIView {
        let bundle = Bundle(for: type(of: self));
        let nibName = type(of: self).description().components(separatedBy: ".").last!
        let nib = UINib(nibName: nibName, bundle: bundle)
        return nib.instantiate(withOwner: self, options: nil).first as! UIView
    }
}
