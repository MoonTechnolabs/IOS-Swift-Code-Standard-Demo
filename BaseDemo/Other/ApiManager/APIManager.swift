//
//  APIManager.swift
//  BaseDemo
//
//  Created by Moontechnolabs on 26/04/23.
//

import UIKit
import Alamofire

class APIManager: NSObject {
    
    static let shared = APIManager()
    var encoding: ParameterEncoding! = JSONEncoding.default
    //TODO: - get Api
    func callGetApi(url:String, parameter:[String:Any], header: [String: String]? , dataResponse:@escaping ([String:Any], _ error:Error?)->()){
        if !isConnectedToNetwork() {
            let error = NSError(domain: "", code: 505, userInfo: [NSLocalizedDescriptionKey : "Internet connection not available"])
            dataResponse([:],error)
            return
        }
        let bearerToken = getMyUserDefaults(key: MyUserDefaults.bearerToken)
        let header : HTTPHeaders = ["Authorization":"Bearer \(bearerToken)",
                                    "Accept": "application/json"
        ]
        AF.request(url, method: .get, parameters: parameter, headers: header).responseData {  response in
            switch response.result {
            case .success(let data):
                do {
                    if let json = try JSONSerialization.jsonObject(with: data) as? [String:Any] {
                        print("API Response\n\(json)")
                        dataResponse(json,nil)
                    }else {
                    }
                } catch {
                    
                    print("Error while decoding response: \(error.localizedDescription) from: \(String(describing: String(data: data, encoding: .utf8)))")
                    dataResponse([:],error)
                }
            case .failure(let error):
                dataResponse([:],error)
                break
            }
        }
    }
    //TODO: - Post Api
    func callPostApi(url:String, parameter:[String:Any]? , header: HTTPHeaders? , dataResponse:@escaping ([String:Any], _ error:Error?)->()){
        if !isConnectedToNetwork() {
            let error = NSError(domain: "", code: 505, userInfo: [NSLocalizedDescriptionKey : "Internet connection not available"])
            dataResponse([:],error)
            return
        }
        var headers = header
        if header == nil {
            let bearerToken = getMyUserDefaults(key: MyUserDefaults.bearerToken)
            headers = ["Content-Type": "application/json",
                       "version": "2"]
        }
        AF.request(url, method: .post, parameters: parameter, encoding: encoding, headers: headers).responseString  {  response in
            switch response.result {
            case .success(let res):
                if let code = response.response?.statusCode{
                    if code == 200 {
                            let data = res.data(using: .utf8)!
                            do {
                                if let JSON = try JSONSerialization.jsonObject(with: data, options : .allowFragments) as? [String:Any] {
                                    print(JSON) // use the json here
                                    dataResponse(JSON,nil)
                                } else {
                                    print("bad json")
                                    // MARK: SHOW error alert
                                    dataResponse([:],nil)
                                }
                            } catch let error as NSError {
                                print(error)
                                dataResponse([:],error)
                            }
                    }
                }
            case .failure(let error):
                dataResponse([:],error)
                break
            }
        }
    }
    //MARK: - Post API call with image upload
    func callPostWithImage(url:String, image: UIImage, parameters:[String:Any] , header: HTTPHeaders?, dataResponse:@escaping ([String:Any], _ error:Error?)->()) {
        if !isConnectedToNetwork() {
            let error = NSError(domain: "", code: 505, userInfo: [NSLocalizedDescriptionKey : "Internet connection not available"])
            dataResponse([:],error)
            return
        }
        var headers = HTTPHeaders()
        if header == nil {
            let bearerToken = getMyUserDefaults(key: MyUserDefaults.bearerToken)
            headers = ["Authorization":"Bearer \(bearerToken)",
                       "Accept": "application/json",
                       "Content-Type": "application/json"
            ]
        }
        AF.upload(multipartFormData: { multipartFormData in
            if let imageData = image.jpegData(compressionQuality: 0.75){
                multipartFormData.append(imageData, withName: "image", fileName: "image.png", mimeType: "image/png")
            }
            
            for (key, value) in parameters {
                if let v = value as? String, let valueAsData = v.data(using: String.Encoding.utf8) {
                    multipartFormData.append(valueAsData, withName: key )
                }
                if let v = value as? Int, let valueAsData = String(v).data(using: String.Encoding.utf8) {
                    multipartFormData.append(valueAsData, withName: key )
                }
            }
        }, to: url, method: .post, headers: headers).responseData {  response in
            switch response.result {
            case .success(let data):
                do {
                    if let json = try JSONSerialization.jsonObject(with: data) as? [String:Any] {
                        print("API Response\n\(json)")
                        dataResponse(json,nil)
                    }else {
                    }
                } catch {
                    
                    print("Error while decoding response: \(error.localizedDescription) from: \(String(describing: String(data: data, encoding: .utf8)))")
                    dataResponse([:],error)
                }
            case .failure(let error):
                dataResponse([:],error)
                break
            }
        }
    }
}

