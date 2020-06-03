//
//  Global.swift
//  TaoZ
//
//  Created by liuxiang on 2020/6/3.
//  Copyright © 2020 liuxiang. All rights reserved.
//

import Foundation
import UIKit
import Kingfisher
import SnapKit

//MARK: Kingfisher
extension KingfisherWrapper where Base: ImageView {
    
    
    
    @discardableResult
    public func setImage(urlString:String?,placeholder:Placeholder? = UIImage(named: "normal_placeholder_h"),options:KingfisherOptionsInfo? = nil,progressBlock: DownloadProgressBlock? = nil,completionHandler: ((Result<RetrieveImageResult, KingfisherError>) -> Void)? = nil) ->DownloadTask?{
        
        return setImage(with: URL(string: imageBaseUrl + (urlString ?? "")), placeholder: placeholder, options: options, progressBlock: progressBlock, completionHandler: completionHandler)
    }
    
       
}

extension KingfisherWrapper where Base: Button {
    @discardableResult
    public func setImage(urlString: String?, for state: UIControl.State, placeholder: UIImage? = UIImage(named: "normal_placeholder_h")) -> DownloadTask? {
        return setImage(with: URL(string: urlString ?? ""),
                        for: state,
                        placeholder: placeholder,
                        options: [.transition(.fade(0.5))])

    }
}

extension String{
    
    public func getTZCountStr()->String{
        let views = Double(self) ?? 0
        if views < 10000 {
            return String(format: "%.f", views)
        } else {
            return String(format: "%.2f万", views*0.0001)
        }
    }
}

