////
////  NetworkHelper.swift
////  GDDZ
////
////  Created by YMK on 2019/7/16.
////  Copyright © 2019 ymk. All rights reserved.
////
//
//import UIKit
//import Alamofire
////import AlamofireLogbook
//
//let response_code_succes           = 0   //请求成功
//let response_code_sigError         = 401   //用户未登录,token过期
//let response_code_usualError       = 500   //错误
//let response_code_timeOutError     = -1001 //请求超时
//let response_code_netError         = -1009 //网络连接错误
//var uploadIndex = 0     //上传坐标
//var uploadUrls = [String]()     //上传后返回url数组
//
//var uploadSuccessClourse : ((_ result : Dictionary<String, Any>)->Void)?
//
//enum MethodType {
//    case get
//    case post
//    case put
//    case delete
//}
//
//enum QiniuType {
//    case image
//    case video
//}
//
//
//
///// 设置Header
//var headers : [String : String] = [
//    "RequestType"   : "APP",
//    "token"         : "", //UserInfoModel.loadUserInfo()?.token ?? "",
//    "deviceType"    : "IOS",
//    "appVersion"    : Bundle.appShortVersion(),
//    "Authorization" : "token"
////    "Accept"        : "application/json, text/html, text/json, application/xhtml+xml, */*"
//]
//
//
//class NetworkHelper: NSObject {
//    
//    
//    /// 单例初始化
//    static let shareInstance : NetworkHelper = NetworkHelper()
//    
//    /// 设置超时时间(默认为15秒)
//    var timeout : TimeInterval = 15
//    
////    lazy var alamoFireManager : SessionManager = {
////
////        let configuration = URLSessionConfiguration.default
////        configuration.timeoutIntervalForRequest = self.timeout
////        configuration.timeoutIntervalForResource = self.timeout
////        AlamofireLogbook.shared.delegate = self
////        let sessionManager = Alamofire.SessionManager(configuration: configuration)
////
////        return sessionManager
////    }()
//    
//    
//    
//    /// 请求方法 返回值JSON
//    ///
//    /// - Parameters:
//    ///   - type: 请求类型
//    ///   - url: 链接
//    ///   - params: 参数
//    ///   - ishud: 是否有hud
//    ///   - successClourse: 成功的回调
//    ///   - failClourse: 失败的回调
//    class func request(_ type : MethodType = .post, url : String, params : [String : Any]?, ishud:Bool, successClourse : ((_ result : Dictionary<String, Any>)->Void)?, failClourse : ((_ code:Int?,_ message: String) ->Void)?) {
//        
//        if ishud == true{
//            SVProgressHUD.show()
//        }
//        
//        var params = params
//        if params == nil {
//            params = ["version":versionString]
//        } else {
//            params?["version"] = versionString
//        }
//        
//        //headers["token"] = UserInfoModel.loadUserInfo()?.token ?? ""
//        
//        // 1.获取类型
//        let method = type == .get ? HTTPMethod.get : type == .put ? HTTPMethod.put : type == .delete ? HTTPMethod.delete : HTTPMethod.post
//        // 2.发送网络请求
//        NetworkHelper.shareInstance.alamoFireManager.request(url, method: method, parameters: params, headers: headers).log().responseJSON { (response) in
//            
//            if ishud == true{
//                SVProgressHUD.dismiss()
//            }
//          
//            switch response.result
//            {
//                case .success(let result):
//                    if let success = successClourse {
//                        let jsonDic = result as! Dictionary<String, Any>
//                        let code = jsonDic["code"] as? Int
//                        // MARK: 登录信息过期
//                        if code == response_code_sigError{
////                            UserInfoModel.removeUserInfo()
//                        } else {
//                           success(jsonDic)
//                        }
//                        
//                    }
//    
//                case .failure(let encodingError):
//                    
//                    let code = (encodingError as NSError).code
//                    let msgString = code == response_code_timeOutError ? "请求超时，请重试" : code == response_code_netError ? "网络异常，请检查网络配置" : "请求失败，请重试"
//                    SVProgressHUD.showError(withStatus: msgString)
//                    
//                    if let fail = failClourse
//                    {
//                        if code == response_code_timeOutError
//                        {
//                            fail(response_code_timeOutError, msgString)
//                        }
//                        else if code == response_code_netError
//                        {
//                            fail(response_code_netError, msgString)
//                        }
//                        else
//                        {
//                            fail(response_code_usualError, msgString)
//                        }
//                    }
//            }
//
//        }
//   }
//    
//}
//
////二次封装
//extension NetworkHelper{
//    
//    /// DELETE 请求 返回JSON
//    ///
//    /// - Parameters:
//    ///   - URLString: 请求链接
//    ///   - params: 参数
//    ///   - ishud: 是否有hud
//    ///   - success: 成功的回调
//    ///   - failture: 失败的回调
//    class func DELETE(url : String, params : [String : Any]?, ishud:Bool, success : ((_ result : Dictionary<String, Any>)->Void)?, failture : ((_ code:Int?,_ message: String) ->Void)?) {
//        NetworkHelper.request(.delete, url:url, params:params, ishud:ishud, successClourse: success, failClourse: failture)
//    }
//    
//    /// GET 请求 返回JSON
//    ///
//    /// - Parameters:
//    ///   - URLString: 请求链接
//    ///   - params: 参数
//    ///   - ishud: 是否有hud
//    ///   - success: 成功的回调
//    ///   - failture: 失败的回调
//    class func GET(url : String, params : [String : Any]?, ishud:Bool, success : ((_ result : Dictionary<String, Any>)->Void)?, failture : ((_ code:Int?,_ message: String) ->Void)?) {
//        NetworkHelper.request(.get, url:url, params:params, ishud:ishud, successClourse: success, failClourse: failture)
//    }
//    
//    
//    /// POST 求情
//    ///
//    /// - Parameters:
//    ///   - URLString: 请求链接
//    ///   - params: 参数
//    ///   - ishud: 是否有hud
//    ///   - success: 成功的回调
//    ///   - failture: 失败的回调
//    class func POST(url : String, params : [String : Any]?, ishud:Bool, success : ((_ result : Dictionary<String, Any>)->Void)?, failture : ((_ code:Int?,_ message: String) ->Void)?) {
//        NetworkHelper.request(.post, url:url, params:params, ishud:ishud, successClourse: success, failClourse: failture)
//    }
//    
//    /// PUT 求情
//    ///
//    /// - Parameters:
//    ///   - URLString: 请求链接
//    ///   - params: 参数
//    ///   - ishud: 是否有hud
//    ///   - success: 成功的回调
//    ///   - failture: 失败的回调
//    class func PUT(url : String, params : [String : Any]?, ishud:Bool, success : ((_ result : Dictionary<String, Any>)->Void)?, failture : ((_ code:Int?,_ message: String) ->Void)?) {
//        NetworkHelper.request(.put, url:url, params:params, ishud:ishud, successClourse: success, failClourse: failture)
//    }
//    
//    
//    
//    /// 七牛上传图片封装
//    ///
//    /// - Parameters:
//    ///   - imageArray: 图片数组
//    ///   - videoData: 视频
//    ///   - qiniuType: 类型
//    ///   - isWaterMark: 是否有水印
//    ///   - ishud: 是否有hud
//    ///   - success: 成功失败
//    ///   - failture: 失败
////    class func Qiniu(imageArray : [UIImage]?, videoData : Data?, qiniuType:QiniuType,isWaterMark:Bool,ishud:Bool, success : ((_ result : Dictionary<String, Any>)->Void)?) {
////
////        uploadSuccessClourse = success
////
////        var dataArray = [Data]()
////
////        if qiniuType == .image {
////
////            for i in  0..<imageArray!.count{
////
////                if isWaterMark == true {
////                    let image = imageArray![i]
////                    let tempImg = UIImage.getWaterMark(image,title: "医美咖APP", markFont: UIFont(name: "YouYuan", size: 50)!, markColor: UIColor.white.withAlphaComponent(0.1))
////                    let imageData = tempImg?.jpegData(compressionQuality: 0.3)
////                    dataArray.append(imageData!)
////
////                } else {
////
////                    let image = imageArray![i]
////                    let imageData = image.jpegData(compressionQuality: 0.3)
////                    dataArray.append(imageData!)
////
////                }
////
////            }
////
////        } else {
////
////            dataArray.append(videoData!)
////
////        }
////
////        uploadIndex = 0
////        uploadUrls = [String]()
////        uploadData(dataArray: dataArray, index: uploadIndex, qiniuType: qiniuType, ishud: ishud)
////
////    }
//    
// 
////    class func uploadData(dataArray:[Data],index:Int,qiniuType:QiniuType,ishud:Bool) {
////
////        let type = qiniuType == .video ? "2" : "1" //视频type2   图文1
////
////        if ishud {
////            SVProgressHUD.setDefaultMaskType(SVProgressHUDMaskType.clear)
////            SVProgressHUD.show(withStatus: "上传中...")
////        }
////
////        NetworkHelper.GET(url: url_upload_token, params: ["type":type], ishud: false, success: { (result) in
////
////            if result["code"] as? Int == response_code_succes
////            {
////
////                let tokenString:String = (result["msg"] as? String)!
////                let keyString:String = "\((Int(type) == 2 ? "video_" : "image_"))" + "\(Date().milliStamp)" + "\((Int(type) == 2 ? ".mp4" : ".jpg"))"
////
////                let config = QNConfiguration.build { (bulder) in
////                    bulder?.setZone(QNFixedZone.zone2())
////                    bulder?.timeoutInterval = 10
////                }
////
////                let data = dataArray[index]
////                let upManager = QNUploadManager(configuration: config)
////
////                upManager?.put(data, key: keyString, token: tokenString, complete: { (info, keyStr, resp) in
////
////    //                print("********info:\(info ?? QNResponseInfo()) keyStr:\(keyStr ?? "") resp:\(resp ?? NSDictionary() as! [AnyHashable : Any])")
////                    if info?.isOK == true {
////                        let imgStr = resp?[AnyHashable("key")] as? String ?? ""
////                        let tempImgStr = (Int(type) == 2 ? Qiniu_Video_Url : Qiniu_Image_Url) + imgStr
////    //                    print("返回链接:\(tempImgStr)");
////                        uploadUrls.append(tempImgStr)
////                    }
////
////                    uploadIndex = uploadIndex + 1
////
////                    if (uploadIndex >= dataArray.count) {
////    //                    print("上传完成");
////                        if (ishud == true){
////                            SVProgressHUD.showSuccess(withStatus: "上传成功")
////                            SVProgressHUD.dismiss(withDelay: 0.1)
////                            SVProgressHUD.setDefaultMaskType(SVProgressHUDMaskType.none)
////                        }
////                        let result_dic = ["urls":uploadUrls] as [String : Any]
////                        uploadSuccessClourse!(result_dic)
////                        return ;
////                    }
////                    self.uploadData(dataArray: dataArray, index: uploadIndex, qiniuType: qiniuType, ishud: ishud)
////
////                }, option: nil)
////
////            } else {
////
////                uploadIndex = uploadIndex + 1
////
////                if (uploadIndex >= dataArray.count) {
////
////                   if (ishud == true){
////                       SVProgressHUD.showSuccess(withStatus: "上传成功")
////                       SVProgressHUD.setDefaultMaskType(SVProgressHUDMaskType.none)
////                    }
////
////                    let result_dic = ["urls":uploadUrls] as [String : Any]
////                    uploadSuccessClourse!(result_dic)
////                    return ;
////                }
////                self.uploadData(dataArray: dataArray, index: uploadIndex, qiniuType: qiniuType, ishud: ishud)
////
////            }
////
////        }, failture: {(code,message) in
////
////            SVProgressHUD.showSuccess(withStatus: "上传失败")
////            SVProgressHUD.dismiss(withDelay: 0.1)
////            SVProgressHUD.setDefaultMaskType(SVProgressHUDMaskType.none)
////
////        })
////
////    }
//    
//    
//}
//
//////打印回调
////extension NetworkHelper: AlamofireResponseListener
////{
////    func recievedResponseFor(item: LogItem)
////    {
////        print(item.description)
////    }
////}
