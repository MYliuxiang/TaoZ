//
//  ContainerView.swift
//  TaoZ
//
//  Created by liuxiang on 08/05/2020.
//  Copyright © 2020 liuxiang. All rights reserved.
//

import UIKit
import Kingfisher



@objcMembers class ContainerView: UIView {

    
    var tz_videoImg:UIImageView?
    var tz_imageViewsArray:[UIImageView]?
    var tz_picPathStringsArray:[String]?{
        
        didSet{
            for i in 0 ..< tz_picPathStringsArray!.count {
                let imageView = self.tz_imageViewsArray?[i]
                imageView?.isHidden = true
            }
            if tz_picPathStringsArray!.count == 0 {
                self.height_sd = 0
                self.fixedHeight = 0
                return
            }
               
            let itemW = tz_itemWidthForPicPathArray(array: tz_picPathStringsArray!)
            var itemH = 0.0
            if tz_picPathStringsArray!.count == 1 {
                _ = UIImage(named: tz_picPathStringsArray?.first ?? "")

                
            }else{
                itemH = itemW
            }
            itemH = itemW;
            let perRowItemCount = tz_perRowItemCountForPicPathArray(array: tz_picPathStringsArray!)
            let margin = 5.0
            
            for (idx,obj) in tz_picPathStringsArray!.enumerated() {
                
                let columnIndex = idx % perRowItemCount
                let rowIndex = idx / perRowItemCount
                if idx >= 9 {
                    return
                }
                
                let imageView = (tz_imageViewsArray?[idx])!
                imageView.isHidden = false
                
                let imageStr = tz_picPathStringsArray![idx]
                if tz_model?.type == 0 {
//                    imageView.kf.setImage(with: URL(string: imageStr))
                    imageView.kf.setImage(with: URL(string: imageStr))
                imageView.frame = CGRect(x: Double(columnIndex) * (itemW + margin), y: Double(rowIndex) * (itemH + margin), width: Double(itemW), height: itemH)
                    
                }else{
                     imageView.frame = CGRect(x: Double(columnIndex) * (itemW + margin), y: Double(rowIndex) * (itemH + margin), width: Double(itemW), height: itemH)
                    imageView.kf.setImage(with: URL(string: imageStr))

                }
                
                
            }
               
            let w = Double(perRowItemCount) * itemW + Double(perRowItemCount - 1) * margin
               
            let columnCount = ceilf(Float(tz_picPathStringsArray!.count * Int(1.0) / perRowItemCount))
            let h = Double(columnCount) * itemH + Double(columnCount - 1) * margin
                
            self.snp.makeConstraints { (make) in
                make.width.equalTo(w)
                make.height.equalTo(h)

            }
//            self.width_sd = CGFloat(w);
//            self.height_sd = CGFloat(h);
//            self.fixedHeight = NSNumber(value: h);
//            self.fixedWidth = NSNumber(value: w);
            
        }
    }
    var tz_model:DiscoverModel?{
        didSet{
            if tz_model?.type == 0 {
                //视频
                tz_videoImg?.isHidden = false
                tz_picPathStringsArray = [tz_model?.videopath ?? ""]
            }else{
                //图片
                tz_videoImg?.isHidden = true
                tz_picPathStringsArray = tz_model?.images ?? [""]
            }
        }
    }

    
   override init(frame: CGRect) {
        
         super.init(frame: frame)
         setUp()
     }
     
     
    public required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        
    }
     
     private func setUp(){
        var temp = [UIImageView]()
        for i in 0...9{
            let imageView = UIImageView()
            imageView.tag = i
            addSubview(imageView)
            if i == 0 {
                tz_videoImg = UIImageView()
                tz_videoImg?.backgroundColor = .red
                imageView.addSubview(tz_videoImg!)
                
                tz_videoImg?.snp.makeConstraints({ (make) in
                    make.center.equalToSuperview()
                    make.size.equalTo(CGSize(width: 40, height: 40))
                })
              
                tz_videoImg?.isHidden = true
                
            }
            imageView.clipsToBounds = true
            imageView.isUserInteractionEnabled = true;
            imageView.contentMode = .scaleToFill;
            imageView.tag = i;
            imageView.backgroundColor = UIColor.colorWithHexStr("#eeeeee");
            let tap = UITapGestureRecognizer.init(target: self, action: #selector(tapImageView))
            imageView.addGestureRecognizer(tap)
            
            temp.append(imageView)

        }
        self.tz_imageViewsArray = temp
     }
    
    @objc func tapImageView(tap:UITapGestureRecognizer){
        
        let browser = LxBrowser(photos: createWebPhotos())
        browser.initializePageIndex(tap.view?.tag ?? 0)
        browser.delegate = self

        ex_viewController?.present(browser, animated: true, completion: {})        
        
        
    }
    
    func createWebPhotos() -> [SKPhotoProtocol] {
        return (0..<10).map { (i: Int) -> SKPhotoProtocol in
            let photo = SKPhoto.photoWithImageURL("https://placehold.jp/15\(i)x15\(i).png")
//            photo.caption = caption[i%10]
            photo.shouldCachePhotoURLImage = true
            return photo
        }
    }
    
    func tz_perRowItemCountForPicPathArray(array:Array<Any>)-> Int{
        if array.count < 3 {
            return array.count
        }else if array.count == 4{
            return 2
        }else{
            return 3
        }
    }
    
    func tz_itemWidthForPicPathArray(array:Array<Any>)-> Double{
        if array.count == 1 {
            return Double(180);
        } else {
            let  w = (ScreenWidth-25-40-10-15) / 3.0;
            return Double(w);
        }
    }

}

extension ContainerView:SKPhotoBrowserDelegate {
    func didDismissAtPageIndex(_ index: Int) {
    }
    
    func didDismissActionSheetWithButtonIndex(_ buttonIndex: Int, photoIndex: Int) {
    }
    
    func removePhoto(index: Int, reload: (() -> Void)) {
        SKCache.sharedCache.removeImageForKey("somekey")
        reload()
    }
    func viewForPhoto(_ browser: SKPhotoBrowser, index: Int) -> UIView? {
        return tz_imageViewsArray?[index]
    }
}

//class CustomImageCache: SKImageCacheable {
//    var cache: SDImageCache
//
//    init() {
//        let cache = SDImageCache(namespace: "com.suzuki.custom.cache")
//        self.cache = cache!
//    }

//    func imageForKey(_ key: String) -> UIImage? {
//        guard let image = cache.imageFromDiskCache(forKey: key) else { return nil }
//
//        return image
//    }
//
//    func setImage(_ image: UIImage, forKey key: String) {
//        cache.store(image, forKey: key)
//    }

//    func removeImageForKey(_ key: String) {}
//
//    func removeAllImages() {}
    
//}

