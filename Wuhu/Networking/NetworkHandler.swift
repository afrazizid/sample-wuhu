//
//  NetworkHandler.swift

//

import Foundation
import Alamofire

class NetworkHandler {
    
    class func postRequest(url: String, parameters: Parameters?, success: @escaping (Any) -> Void, failure: @escaping (NetworkError) -> Void) {
        
        if Network.isAvailable {
            
            var headers: HTTPHeaders
            if let userToken = UserDefaults.standard.value(forKey: KeyChainKeys.userAuthToken) as? String {
                headers = [
                    "Accept": "application/json",
                    "Authorization" : "Bearer \(userToken)",
                    "Country":"sa"
                ]
            } else {
                headers = [
                    "Accept": "application/json",
                    "Content-Type" : "application/json",
                    "Country":"sa"
                ]
            }
            
            print(headers)
            
            let manager = Alamofire.SessionManager.default
            manager.session.configuration.timeoutIntervalForRequest = NetworkIndicators.timeOutInterval
            
            manager.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers).validate(statusCode: 200..<600).responseJSON { (response) -> Void in
                
                print(response)
                
                if let userToken = response.response?.allHeaderFields["Authorization"] as? String {
                    print(userToken)
                    debugPrint(userToken)
//                    UserDefaults.standard.setValue(userToken, forKey: "userAuthToken")
                    debugPrint("\(UserDefaults.standard.value(forKey: KeyChainKeys.userAuthToken)!)")
                }
                
                guard let statusCode = response.response?.statusCode else {
                    var networkError = NetworkError()
                    
                    networkError.status = NetworkIndicators.timout
                    networkError.message = NetworkIndicators.timoutError
                    failure(networkError)
                    return
                }
                
                if statusCode == 422 {
                    var networkError = NetworkError()
                    
                    let response = response.result.value!
                    let dictionary = response as! [String: AnyObject]
                    
                    guard let message = dictionary["error"] as! String? else {
                        networkError.status = statusCode
                        networkError.message = "Validation Error"
                        failure(networkError)
                        return
                    }
                    networkError.status = statusCode
                    networkError.message = message
                    failure(networkError)
                }else{
                    switch (response.result) {
                    case .success:
                        let response = response.result.value!
                        success(response)
                        break
                    case .failure(let error):
                        var networkError = NetworkError()
                        
                        if error._code == NSURLErrorTimedOut {
                            networkError.status = NetworkIndicators.timout
                            networkError.message = NetworkIndicators.timoutError
                            
                            failure(networkError)
                        } else {
                            networkError.status = NetworkIndicators.generic
                            networkError.message = NetworkIndicators.genericError
                            
                            failure(networkError)
                        }
                        break
                    }
                }
            }
        } else {
            let networkError = NetworkError(status: NetworkIndicators.internet, message: NetworkIndicators.internetError)
            failure(networkError)
        }
    }
    
    class func getRequest(url: String, parameters: Parameters?, success: @escaping (Any?) -> Void, failure: @escaping (NetworkError) -> Void) {
        
        let manager = Alamofire.SessionManager.default
        manager.session.configuration.timeoutIntervalForRequest = 20
        
        var headers: HTTPHeaders
        if let userToken = UserDefaults.standard.value(forKey: KeyChainKeys.userAuthToken) as? String {
            headers = [
                "Accept": "application/json",
                "Content-Type"  : "application/json",
                "Authorization" : "Bearer \(userToken)",
                "Country":"sa"
            ]
        }else {
            headers = [
                "Accept"       : "application/json",
                "Content-Type" : "application/json",
                "X-API-KEY"    : "MmYzNGNkMzMyNWY2MDA2NTU2MWI4ZD",
                "SECRET"       : "NjZkZGY1MTJkOTlkNzE4YmE4Yzk2Nj",
                "Country":"sa"

            ]
        }
        
        print(headers)
        
        manager.request(url, method: .get, parameters: parameters, encoding: JSONEncoding.default, headers: headers).responseJSON { (response) -> Void in
            
            print(response)
            
            switch response.result{
            //Case 1
            case .success:
                let response = response.result.value!
                success(response)
                break
                
            case .failure (let error):
                // print(error)
                
                var networkError = NetworkError()
                
                if error._code == NSURLErrorTimedOut {
                    networkError.status = NetworkIndicators.timout
                    networkError.message = NetworkIndicators.timoutError
                    
                    failure(networkError)
                } else {
                    networkError.status = NetworkIndicators.generic
                    networkError.message = NetworkIndicators.genericError
                    
                    failure(networkError)
                }
                break
            }
        }
    }
    
    // POS REQUEST WITH MULTIFORMA DATA
    
    class func postRequestWithMultiFormData(url: String, imgData: Data?, fileName: String, params: Parameters?,  success: @escaping (Any?) -> Void, failure: @escaping (NetworkError) -> Void) {
        
        var headers: HTTPHeaders
        
        if let userToken = UserDefaults.standard.value(forKey: KeyChainKeys.userAuthToken) as? String {
            headers = [
                "Accept"        : "application/json",
                "Content-Type"  : "application/json",
                "Authorization" : "Bearer \(userToken)",
                "Country":"sa"
            ]
        } else{
            headers = [
                "Accept": "application/json",
                "Country":"sa"
            ]
        }
        
        Alamofire.upload(multipartFormData: { (MultipartFormData) in
            
            for (key, value) in params! {
                MultipartFormData.append("\(value)".data(using: String.Encoding.utf8)!, withName: key as String)
                
            }
            if (imgData != nil){
//                let fileName = "\(imgData).\("png")"
                MultipartFormData.append(imgData!, withName: "user_image", fileName: "user_image.png", mimeType: "")
            }
            
        }, to: url, method : .post, headers : headers) { (result) in
            
            switch result {
            case .success(let upload, _, _):
                
                upload.responseJSON { response in
                    print(response)
                    let returnValue = response.result.value!
                    if let userToken = response.response?.allHeaderFields["Authorization"] as? String {
                        print("User Token is \(userToken)")
                        //                        UserDefaults.standard.set(userToken, forKey: "userAuthToken")
                        UserDefaults.standard.synchronize()
                    }
                    success(returnValue)
                }
                
            case .failure(let error):
                print(error.localizedDescription)
                var networkError = NetworkError()
                
                if error._code == NSURLErrorTimedOut {
                    networkError.status = NetworkIndicators.timout
                    networkError.message = NetworkIndicators.timoutError
                    
                    failure(networkError)
                } else {
                    networkError.status = NetworkIndicators.generic
                    networkError.message = NetworkIndicators.genericError
                    
                    failure(networkError)
                }
            }
        }
        
    }
    
//    class func multipartWithParamOnly(url: String, value: String, success: @escaping (Any?) -> Void, failure: @escaping (NetworkError) -> Void) {
//
//         var headers: HTTPHeaders
//
//         Alamofire.upload(multipartFormData: { multipartFormData in
//             multipartFormData.append((value.data(using: String.Encoding.utf8, allowLossyConversion: false))!, withName: "value")
//         }, to: url, method: .post, headers: nil, encodingCompletion: { (result) in
//
//             switch result {
//             case .success(let upload, _, _):
//
//                upload.responseJSON { response in
//                    print(response)
//                    let returnValue = response.result.value!
//
//                    success(returnValue)
//                }
//
//             case .failure(let error):
//                print(error.localizedDescription)
//                var networkError = NetworkError()
//
//                if error._code == NSURLErrorTimedOut {
//                    networkError.status = NetworkIndicators.timout
//                    networkError.message = NetworkIndicators.timoutError
//
//                    failure(networkError)
//                } else {
//                    networkError.status = NetworkIndicators.generic
//                    networkError.message = NetworkIndicators.genericError
//
//                    failure(networkError)
//                }
//            }
//         }
//
//     }
    
    // MARK: Upload Multipart File
    
    class func upload(url: String, imgData: Data, fileName: String, params: Parameters?,  success: @escaping (Any?) -> Void, failure: @escaping (NetworkError) -> Void) {
        var headers: HTTPHeaders
        if let userToken = UserDefaults.standard.value(forKey: KeyChainKeys.userAuthToken) as? String {
            headers = [
                "Accept"        : "application/json",
                "Content-Type"  : "application/json",
                "Authorization" : "Bearer \(userToken)",
                "Country":"sa"
                
            ]
        } else{
            headers = [
                "Accept": "application/json",
                "Country":"sa"
            ]
        }
        print(headers)
            
        Alamofire.upload(multipartFormData: { multipartFormData in
            multipartFormData.append(imgData, withName: "user_image", mimeType: "user_image.png")
            if let parameters = params {
//                for (key, value) in parameters {
//                    print(key)
//                    print(value)
//
//
//                    multipartFormData.append((value as! String).data(using: String.Encoding.utf8)!, withName: key)
//                }
                
                for (key, value ) in parameters{
                    let name = String(key)
                    if let val = params![name] as? String{
                        multipartFormData.append(val.data(using: .utf8)!, withName: name)
                    }
                }
            }
            
        }, usingThreshold: UInt64.init(), to: url, method: .post, headers: headers, encodingCompletion: { encodingResult in
            switch encodingResult {
            case .success(let upload, _, _):
    
                upload.responseJSON { response in
                    print(response)
                    let returnValue = response.result.value!
                    if let userToken = response.response?.allHeaderFields["Authorization"] as? String {
                        print("User Token is \(userToken)")
//                        UserDefaults.standard.set(userToken, forKey: "userAuthToken")
                        UserDefaults.standard.synchronize()
                    }
                    success(returnValue)
                }
                
            case .failure(let error):
                print(error.localizedDescription)
                var networkError = NetworkError()
                
                if error._code == NSURLErrorTimedOut {
                    networkError.status = NetworkIndicators.timout
                    networkError.message = NetworkIndicators.timoutError
                    
                    failure(networkError)
                } else {
                    networkError.status = NetworkIndicators.generic
                    networkError.message = NetworkIndicators.genericError
                    
                    failure(networkError)
                }
            }
        })
    }
    
    
    class func getRequestWithOutHeader(url: String, parameters: Parameters?, success: @escaping (Any?) -> Void, failure: @escaping (NetworkError) -> Void) {
        
        let manager = Alamofire.SessionManager.default
        manager.session.configuration.timeoutIntervalForRequest = 20
        
        manager.request(url, method: .get, parameters: parameters, encoding: JSONEncoding.default, headers: nil).responseJSON { (response) -> Void in
            print(response)
            switch response.result{
            //Case 1
            case .success:
                let response = response.result.value!
                success(response)
                
                break
            case .failure (let error):
                // print(error)
                
                var networkError = NetworkError()
                
                if error._code == NSURLErrorTimedOut {
                    networkError.status = NetworkIndicators.timout
                    networkError.message = NetworkIndicators.timoutError
                    
                    failure(networkError)
                } else {
                    networkError.status = NetworkIndicators.generic
                    networkError.message = NetworkIndicators.genericError
                    
                    failure(networkError)
                }
                break
            }
        }
    }
    
    class func postRequestWithOutHeader(url: String, parameters: Parameters?, success: @escaping (Any) -> Void, failure: @escaping (NetworkError) -> Void) {
            
            if Network.isAvailable {
                
                let manager = Alamofire.SessionManager.default
                manager.session.configuration.timeoutIntervalForRequest = NetworkIndicators.timeOutInterval
                
                manager.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default).validate(statusCode: 200..<600).responseJSON { (response) -> Void in
                    
                    print(response)
    
                    
                    guard let statusCode = response.response?.statusCode else {
                        var networkError = NetworkError()
                        
                        networkError.status = NetworkIndicators.timout
                        networkError.message = NetworkIndicators.timoutError
                        
                        failure(networkError)
                        return
                        
                    }
                    
                    if statusCode == 422 {
                        var networkError = NetworkError()
                        
                        let response = response.result.value!
                        let dictionary = response as! [String: AnyObject]
                        
                        guard let message = dictionary["error"] as! String? else {
                            networkError.status = statusCode
                            networkError.message = "Validation Error"
                            
                            failure(networkError)
                            
                            return
                        }
                        networkError.status = statusCode
                        networkError.message = message
                        
                        failure(networkError)
                        
                        
                    }else{
                        switch (response.result) {
                        case .success:
                            let response = response.result.value!
                            success(response)
                            break
                        case .failure(let error):
                            var networkError = NetworkError()
                            
                            if error._code == NSURLErrorTimedOut {
                                networkError.status = NetworkIndicators.timout
                                networkError.message = NetworkIndicators.timoutError
                                
                                failure(networkError)
                            } else {
                                networkError.status = NetworkIndicators.generic
                                networkError.message = NetworkIndicators.genericError
                                
                                failure(networkError)
                            }
                            
                            break
                        }
                    }
                }
            } else {
                let networkError = NetworkError(status: NetworkIndicators.internet, message: NetworkIndicators.internetError)
                failure(networkError)
            }
        }
    
    
   
    
    
    // MARK: Upload Multipart File
    


}

struct NetworkError {
    var status: Int = NetworkIndicators.generic
    var message: String = NetworkIndicators.genericError
}

struct NetworkSuccess {
    var status: Int = NetworkIndicators.statusOK
    var message: String = NetworkIndicators.genericSuccess
}

