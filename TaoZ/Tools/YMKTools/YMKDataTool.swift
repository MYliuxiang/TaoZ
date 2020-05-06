//
//  YMKDataTool.swift
//  YiMeiKa
//
//  Created by ykm on 2018/12/29.
//  Copyright © 2018 joyshops. All rights reserved.
//

import UIKit

class YMKDataTool: NSObject {
    
    static var defaultIAPHelper :YMKDataTool{
        struct Single{
            static  let defaultIAPHelper = YMKDataTool()
        }
        return Single.defaultIAPHelper
    }
    
    //数据类型装换
    func getString(resurt:Any) -> String {
    
        if resurt as? String != nil {
            
            let resurtString = resurt as? String ?? ""
            return resurtString
            
        } else if resurt as? Int != nil {
            
            let resurtInt = resurt as? Int ?? 0
            let resurtString = "\(resurtInt)"
            return resurtString
            
        } else if resurt as? Double != nil {
            
            let resurtDouble = resurt as? Double ?? 0
            let resurtString = "\(resurtDouble)"
            return resurtString
            
        } else if resurt as? Float != nil {
            
            let resurtFloat = resurt as? Float ?? 0
            let resurtString = "\(resurtFloat)"
            return resurtString
            
        }
        
        return ""
        
    }
    
    /**
     * 获取图片的大小
     */
     func getDataFromWith(_ hdImage: Any) -> Data {
        
        var data: Data?
        
        if hdImage is String {
            var hdImageStr = "\(hdImage)"
            if hdImageStr.hasPrefix("http://") || hdImageStr.hasPrefix("https://") {
                // 网络图片
                do {
                    let imageData = try Data.init(contentsOf: URL.init(string: hdImageStr)!)
                    let image = UIImage.init(data: imageData as Data)
                    data = image?.jpegData(compressionQuality: 0.8)
                    let data_size = (data?.count ?? 0)/1024
                    if data_size > 125 {
                        data = image?.jpegData(compressionQuality: 0.1)
                    }
//                    print("***** 压缩图片大小\((data?.count ?? 0)/1024)kb")
                }catch {
                    
                }
                
            } else {
                // 本地图片
                if hdImageStr.count == 0 {
                    hdImageStr = "shareIcon"
                }
                var image = UIImage.init(named: hdImageStr)
                if image == nil {
                    image = UIImage.init(named: "shareIcon")
                }
                data = image?.jpegData(compressionQuality: 0.5)
            }
            
        } else if hdImage is UIImage {
            // 本地图片
            data =  (hdImage as! UIImage).jpegData(compressionQuality: 0.3)
        }
        return data!
        
    }
    
}
