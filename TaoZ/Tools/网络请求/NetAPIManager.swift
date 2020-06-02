//
//  NetAPIManager.swift
//  NN110
//
//  Created by 陈亦海 on 2017/5/12.
//  Copyright © 2017年 陈亦海. All rights reserved.
//

import Foundation
import Moya

#if DEBUG
    let HOSTURL = "http://taozhi.dbf4.top/api/"
#else
    let HOSTURL = "http://taozhi.dbf4.top/api/"
#endif


enum NetAPIManager {
    case upload(APIName: String ,isTouch: Bool, body:[String: Any]?,filePath: String,fileType: String,isShow: Bool,title: String?)
    case download
    case getRequest(APIName: String ,isTouch: Bool, body: Dictionary<String, Any>? ,isShow: Bool,title: String?)
    case postRequest(APIName: String ,isTouch: Bool, body: Dictionary<String, Any>? ,isShow: Bool,title: String?)
    case request(APIName: String ,method:Moya.Method, body: Dictionary<String, Any>? ,isShow: Bool)
}


extension NetAPIManager: TargetType {
    var headers: [String : String]? {
     
       
        return [
            "Content-Type" : "application/x-www-form-urlencoded;charset=UTF-8",
            //application/x-www-form-urlencoded;charset=UTF-8
            "Accept": "application/json;application/octet-stream;text/html,text/json;text/plain;text/javascript;text/xml;application/x-www-form-urlencoded;image/png;image/jpeg;image/jpg;image/gif;image/bmp;image/*",
            "token":UserInfoModel.loadUserInfo()?.token ?? ""
        ]
    }
    
    var baseURL: URL {
        
        return URL(string: HOSTURL)!
        
    }
    
    var path: String {
        switch self {
        
        case .upload(let apiName, _, _, _, _, _,_):
            return apiName
        case .getRequest(let apiName,_, _, _, _):
            return apiName
        case .postRequest(let apiName, _, _, _, _):
            return  apiName
        case .download:
            return ""
        case  .request(let apiName, _, _, _):
            return apiName
        }
    }
    
    var method: Moya.Method {
        switch self {
       
        case .getRequest(_,_, _, _, _):
            return .get
        case .postRequest(_,_, _, _, _):
            return .post
        case .request(_, let method, _, _):
            return method
           
            
        default:
            return .post
        }
    }
    
    var parameters: [String: Any]? {
        switch self {
        
        case .upload(_,_,  let postDict,_, _, _, _):
            return postDict
        case .postRequest(_, _, let postDict, _, _):
            return postDict
        case .getRequest(_, _, let postDict, _, _):
            return postDict
        case .request(_, _, let postDict, _):
            return postDict
            
        default:
            return nil
        
        }
    }
    
    var sampleData: Data {
       return "{}".data(using: String.Encoding.utf8)!
    }
    
    var task: Task {
        switch self {
            

        case .upload(_,_, let postDic, let filePath, let fileType, _, _):
            let url = URL(string: filePath)
            let fileName = url?.lastPathComponent
            do {
                let data = try Data(contentsOf: url!)
                if postDic == nil {
                    return .uploadMultipart([MultipartFormData(provider: .data(data), name: "file", fileName: fileName, mimeType: fileType)])
                }else{
                    var datas = [MultipartFormData(provider: .data(data), name: "file", fileName: fileName, mimeType: fileType)]
                    for (key, value) in postDic! {
                        let vStr = value as! String
                        let vData = vStr.data(using: String.Encoding.utf8)!
                        let mData = MultipartFormData(provider: .data(vData), name: key)
                        datas.append(mData)
                    }
                    return .uploadMultipart(datas)
                }
                
            } catch {
                return .requestPlain
            }
            
        case  .postRequest(_, _, let postDict, _, _):
            guard postDict != nil else {
                return .requestPlain
            }
            return .requestParameters(parameters: postDict!, encoding: URLEncoding.default)
        case  .getRequest(_, _, let postDict, _, _):
            
            guard postDict != nil else {
                return .requestPlain
            }
            return .requestParameters(parameters: postDict!, encoding: URLEncoding.default)
        case  .request(_, _, let postDict, _):
            
//            guard postDict != nil else {
//                return .requestPlain
//            }
            var dic = [String:Any]()
            dic = postDict ?? [String:Any]()
            dic["user_id"] = UserInfoModel.loadUserInfo()?.user_id ?? ""
            
            return .requestParameters(parameters: dic, encoding: URLEncoding.default)
            
        default:
            let string = "{\"@class\":\"com.ailk.gx.mapp.model.GXCDatapackage\",\"header\":{\"@class\":\"com.ailk.gx.mapp.model.GXCHeader\",\"bizCode\":\"cg0004\",\"identityId\":null,\"respCode\":null,\"respMsg\":null,\"mode\":\"1\",\"sign\":null},\"body\":{\n  \"expand\" : null,\n  \"@class\" : \"com.ailk.gx.mapp.model.req.CG0004Request\",\n  \"phoneNo\" : \"13213451345\"\n}}"
            
            let jsonDic = ["msg":string]
            let data = try? JSONSerialization.data(withJSONObject: jsonDic, options: [])
            return .requestData(data!)
       }

     }
    
    var parameterEncoding: ParameterEncoding {
                    
        return URLEncoding.default

        
    }
    

    var touch: Bool { //是否可以操作 默认是可以的
        
        switch self {
        case .getRequest(_,let isTouch, _, _, _):
            return isTouch
        case .postRequest(_,let isTouch, _, _, _):
            return isTouch
        default:
            return true
        }
        
    }
    
    var show: Bool { //是否显示转圈提示
        
        switch self {
        case .getRequest( _, _, _, let isShow, _):
            return isShow
        case .postRequest( _, _, _, let isShow, _):
            return isShow
        case .request(_, _, _, let isShow):
            return isShow
        default:
            return true
        }
        
    }
    
    var title: String? { //转圈提示语句
        
        switch self {
        case .postRequest(_, _, _, _, let hudTitle):
            return hudTitle
        case .getRequest(_, _, _, _, let hudTitle):
            return hudTitle
        default:
            return nil
        }
    }
}
