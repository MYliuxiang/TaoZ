//
//  UIAlertController+TapGesAlertController.swift
//  TaoZ
//
//  Created by liuxiang on 12/05/2020.
//  Copyright © 2020 liuxiang. All rights reserved.
//

import Foundation

extension UIAlertController:UIGestureRecognizerDelegate{
    
    func tapGesAlert(){
        let arrayViews = UIApplication.shared.keyWindow?.subviews
        if (arrayViews!.count > 0) {
               
            let backView = arrayViews?.last
            backView!.isUserInteractionEnabled = true
            let tap = UITapGestureRecognizer(target: self, action: #selector(tapAC))
            backView!.addGestureRecognizer(tap)
            
        }

    }
    
    @objc func tapAC(){
        
        self.dismiss(animated: true, completion: nil)
    }
    
    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        let tapView = gestureRecognizer.view
        let point = touch.location(in: tapView)
        let conPoint = self.view.convert(point, to: tapView)
        let isContains = self.view.bounds.contains(conPoint);
        if (isContains) {
            // 单击点包含在alert区域内 不响应tap手势
            return false;
        }
        return true;
    }
}
