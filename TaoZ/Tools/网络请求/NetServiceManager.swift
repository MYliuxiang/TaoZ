//
//  NetServiceManager.swift
//  NN110
//
//  Created by 陈亦海 on 2017/5/12.
//  Copyright © 2017年 陈亦海. All rights reserved.
//

import Foundation

let code_succes           = 0   //请求成功


// MARK: - Provider setup系统方法转换json数据

private func JSONResponseDataFormatter(_ data: Data) -> Data {
    do {
        let dataAsJSON = try JSONSerialization.jsonObject(with: data)
        let prettyData =  try JSONSerialization.data(withJSONObject: dataAsJSON, options: .prettyPrinted)
        return prettyData
    } catch {
        return data // fallback to original data if it can't be serialized.
    }
}

private func JSONResponseFormatter(_ data: Data) -> Dictionary<String, Any>? {
    do {
        let dataAsJSON = try JSONSerialization.jsonObject(with: data)
       
        return dataAsJSON as? Dictionary<String, Any>
    } catch {
        return nil // fallback to original data if it can't be serialized.
    }
}

// MARK: - 默认的网络提示请求插件
let spinerPlugin = NetworkActivityPlugin { (state,target) in
    if state == .began {
        print("我开始请求")
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    } else {
        
        print("我结束请求")
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
        
    }
}

// MARK: - 自定义的网络提示请求插件
let myNetworkPlugin = LxCustomPlugin { (state,target) in
    
//    var api = target as! NetAPIManager
//    
//    
//    if state == .began {
//        
//        if api.show{
//            DispatchQueue.main.async {
//               MBProgressHUD.showAdded(to: keywindow, animated: true)
//            }
//        }
//        
//        
//    } else {
//     
//        if api.show{
//           
//            MBProgressHUD.hideAllHUDs(for: keywindow, animated: true)
//        }
//    }
}




// MARK: - 设置请求头部信息
let myEndpointClosure = { (target: NetAPIManager) -> Endpoint in
    
    let sessionId =  ""
    let url = target.baseURL.appendingPathComponent(target.path).absoluteString
    
    let endpoint = Endpoint.init(url: url, sampleResponseClosure:  { .networkResponse(200, target.sampleData) }, method: target.method, task: target.task, httpHeaderFields: target.headers)

    return endpoint.adding(newHTTPHeaderFields: [
        "Content-Type" : "application/x-www-form-urlencoded;charset=UTF-8",
        "Accept": "application/json;application/octet-stream;text/html,text/json;text/plain;text/javascript;text/xml;application/x-www-form-urlencoded;image/png;image/jpeg;image/jpg;image/gif;image/bmp;image/*"
        ])
    
}


// MARK: - 设置请求超时时间
let requestClosure = { (endpoint: Endpoint, done: @escaping MoyaProvider<NetAPIManager>.RequestResultClosure) in
    

    do {
        var request: URLRequest = try endpoint.urlRequest()
        request.timeoutInterval = 30    //设置请求超时时间
        done(.success(request))
    } catch  {
        print("错误了 \(error)")
    }
    
    
}

public typealias SuccessCompletion = (_ result: Dictionary<String, Any>?,_ code:Int) -> Void

//let myNetworkLoggerPlugin = NetworkLoggerPlugin(verbose: true, responseDataFormatter: { (data: Data) -> Data in
//    //            return Data()
//    do {
//        let dataAsJSON = try JSONSerialization.jsonObject(with: data)// Data 转 JSON
//        let prettyData =  try JSONSerialization.data(withJSONObject: dataAsJSON, options: .prettyPrinted)// JSON 转 Data，格式化输出。
//        return prettyData
//    } catch {
//        return data
//    }
//})
let myNetworkLoggerPlugin = NetworkLoggerPlugin(configuration: NetworkLoggerPlugin.Configuration.init(logOptions:[.verbose]))



let MyAPIProvider = MoyaProvider<NetAPIManager>(endpointClosure: myEndpointClosure,requestClosure: requestClosure, plugins: [myNetworkLoggerPlugin,myNetworkPlugin])



// MARK: -取消所有请求
func cancelAllRequest() {

    MyAPIProvider.session.cancelAllRequests(completingOnQueue: DispatchQueue.main) {
                 
             }
   
}



func blockHander(theBlock:@escaping (String)->()) {
    theBlock("myBlock")
}

public func uploadFile(_ name:String, touch:Bool? = true,show:Bool? = true, titleString: String? = nil,postDic:Dictionary<String, Any>? = nil,filePath: String,fileType: String,progress:@escaping (Double)->(),success:@escaping (Dictionary<String, Any>?)->(),
                       failure:@escaping (MoyaError)->()) -> Cancellable?{
    
 

    let request = MyAPIProvider.request(.upload(APIName: name, isTouch: touch!, body: postDic, filePath: filePath, fileType: fileType, isShow: show!, title: titleString), callbackQueue: DispatchQueue.main, progress: { (moyaprogress) in
        progress(moyaprogress.progress)
    }) { (result) in
         switch result {
                   case let .success(moyaResponse):

                           let data =  moyaResponse.data

                           guard !data.isEmpty else{
                               success(nil)
                               return
                           }

                           let dict = JSONResponseFormatter(data)
                           success((dict))

                   case let .failure(error):

                       print(error)
                       failure(error)
                   }
    }
    
    
        return request
    
}

// MARK: -创建一个Moya请求
public func sendGetRequest(_ name: String, touch:Bool? = true, show: Bool? = true, titleString: String? = nil, getDict: Dictionary<String, Any>? = nil,
                 success:@escaping (Dictionary<String, Any>?)->(),
                 failure:@escaping (MoyaError)->()) -> Cancellable? {
    
    let request = MyAPIProvider.request(.getRequest(APIName:name,isTouch: touch!, body:getDict ,isShow: show!, title: titleString)) { result in
    
        switch result {
        case let .success(moyaResponse):

                let data =  moyaResponse.data
                
                guard !data.isEmpty else{
                    success(nil)
                    return
                }
                
                let dict = JSONResponseFormatter(data)
                if dict!["code"] as! Int == 103 || dict!["code"] as! Int == 402 {
                    //需要去登录
                    UserDefaults.standard.set(false, forKey: isLogin)
                    let rootVC = BaseNavigationController.init(rootViewController:LoginVC())
                    rootVC.modalPresentationStyle = .fullScreen
                    rootVC.view.makeToast("亲请重新登录！", duration: 0.35, position: .center)
                    TabBarObject.shareInstance.tabBarController.present(rootVC, animated: true, completion: nil)
                    UserInfoModel.removeUserInfo()
                }else{
                    success((dict))

                }
                
            
        case let .failure(error):
            
            print(error)
            failure(error)
        }
    }
    
    return request
}

// MARK: -创建一个Moya请求
public func sendPostRequest(_ name: String, touch:Bool? = true, show: Bool? = true, titleString: String? = nil, postDict: Dictionary<String, Any>? = nil,
                          success:@escaping (Dictionary<String, Any>?)->(),
                          failure:@escaping (MoyaError)->()) -> Cancellable? {
    
    
    let request = MyAPIProvider.request(.postRequest(APIName:name,isTouch: touch!, body:postDict ,isShow: show!, title: titleString)) { result in
               
        switch result {
        case let .success(moyaResponse):
                        
            let data =  moyaResponse.data
            let dict =  JSONResponseFormatter(data)
            success(dict)
            
        case let .failure(error):
            
            failure(error)
        }
    }
    
    return request
}

public enum TZMethod {
    case get,post,put,delete
    var method:Moya.Method{
        switch self {
        case .get:
           return .get
        case .put:
           return .put
        case .delete:
           return .delete
        default:
           return .post
        }
    }
}

@discardableResult
public func TZRequest(_ name: String, method:TZMethod = .post, bodyDict: Dictionary<String, Any>? = nil, show: Bool = true,logError:Bool = true,completion: @escaping SuccessCompletion)-> Cancellable? {
    
    let request = MyAPIProvider.request(.request(APIName: name, method: method.method, body: bodyDict, isShow: show)) { result in
        
        switch result {
        case let .success(moyaResponse):
            
            if moyaResponse.statusCode == 200, let code = JSON(moyaResponse.data)["code"].int {
                switch code {
                case code_succes:
                    if let  dic = JSON(moyaResponse.data).dictionaryObject {
                        completion(dic,code)
                    }
                default:
                    if let  dic = JSON(moyaResponse.data).dictionaryObject {
                        if dic["code"] as! Int == 103 || dic["code"] as! Int == 402 {
                            //需要去登录
                            let rootVC = BaseNavigationController.init(rootViewController:LoginVC())
                            rootVC.modalPresentationStyle = .fullScreen
                            rootVC.view.makeToast("亲请重新登录！", duration: 0.35, position: .center)
                            TabBarObject.shareInstance.tabBarController.present(rootVC, animated: true, completion: nil)
                            UserInfoModel.removeUserInfo()
                            completion(nil,-1)
                            
                        }else{
                            completion(dic,code)
                        }
                        if logError {
                            MBProgressHUD.showError(JSON(moyaResponse.data)["msg"].stringValue, to: keywindow)
                        }
                    }
                }
            }else {
                completion(nil,-1)
                MBProgressHUD.showError("请求失败,请重试", to: keywindow)
            }
            break
        case .failure(_):
            MBProgressHUD.showError("系统异常,请重试", to: keywindow)
            completion(nil,-1)
            break
        }
        
    }
    return request

}



//// MARK: -创建一个RxSwiftMoyaProvider请求
//func sendRxSwiftRequest(_ name: String, touch:Bool? = true, show: Bool? = true, titleString: String? = nil, postDict: Dictionary<String, Any>? = nil,
//                              success:@escaping (Dictionary<String, Any>)->(),
//                              failure:@escaping (MoyaError)->()) -> Disposable? {
//
//
//
//
//    let request = MyAPIProvider.rx.request(.postRequest(APIName:name,isTouch: touch!, body:postDict ,isShow: show!, title: titleString)).subscribe { event in
//        switch event {
//        case let .success(response):
//
//            do {
//                let any = try response.mapJSON()
//                let string = try response.mapString()
//
//                print("RxSwift  : \(any) --- \(string)")
//                
//                success(any as! Dictionary<String, Any> )
//            }
//            catch {
//                 print("错误了")
//            }
//
//        case let .error(error):
//            print(error)
//            
//            failure(error as! MoyaError)
//        
//        }
//    }
//
//
//    return request as? Disposable
//}








//获取客户端证书相关信息
func extractIdentity() -> IdentityAndTrust {
    var identityAndTrust:IdentityAndTrust!
    var securityError:OSStatus = errSecSuccess
    
    let path: String = Bundle.main.path(forResource: "mykey", ofType: "p12")!
    let PKCS12Data = NSData(contentsOfFile:path)!
    let key : NSString = kSecImportExportPassphrase as NSString
    let options : NSDictionary = [key : "123456"] //客户端证书密码
    //create variable for holding security information
    //var privateKeyRef: SecKeyRef? = nil
    
    var items : CFArray?
    
    securityError = SecPKCS12Import(PKCS12Data, options, &items)
    
    if securityError == errSecSuccess {
        let certItems:CFArray = (items as CFArray?)!;
        let certItemsArray:Array = certItems as Array
        let dict:AnyObject? = certItemsArray.first;
        if let certEntry:Dictionary = dict as? Dictionary<String, AnyObject> {
            // grab the identity
            let identityPointer:AnyObject? = certEntry["identity"];
            let secIdentityRef:SecIdentity = (identityPointer as! SecIdentity?)!
            print("\(String(describing: identityPointer))  :::: \(secIdentityRef)")
            // grab the trust
            let trustPointer:AnyObject? = certEntry["trust"]
            let trustRef:SecTrust = trustPointer as! SecTrust
            print("\(String(describing: trustPointer))  :::: \(trustRef)")
            // grab the cert
            let chainPointer:AnyObject? = certEntry["chain"]
            identityAndTrust = IdentityAndTrust(identityRef: secIdentityRef,
                                                trust: trustRef, certArray:  chainPointer!)
        }
    }
    return identityAndTrust;
}

//定义一个结构体，存储认证相关信息
struct IdentityAndTrust {
    var identityRef:SecIdentity
    var trust:SecTrust
    var certArray:AnyObject
}
