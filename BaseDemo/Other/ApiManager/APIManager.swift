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
    
    private let decoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }()
    
    //MARK: - get Api
    func callGetApi<model: Decodable>(url: String, parameter:[String:Any]? = nil, header: HTTPHeaders? = nil, model: model.Type, completion: @escaping (_ isSuccess: Bool, _ msg: String, _ result: model?) -> Void) {
        
        if !isConnectedToNetwork() {
            completion(false, "Internet connection not available", nil)
            return
        }
        
        var headers = header
        if header == nil {
            headers = ["Content-Type": "application/json",
                       "version": "2"]
        }
        
        AF.request(url, method: .get, parameters: parameter, encoding: encoding, headers: headers).responseDecodable(decoder: decoder) { (response: DataResponse<Model_APIResponse<model>, AFError>) in
            
            switch response.result {
            case .success(let res):
                if let code = response.response?.statusCode {
                    if code == 200 {
                        if res.success ?? false {
                            completion(true, res.msg ?? "", res.result)
                        } else {
                            completion(false, res.msg ?? "", nil)
                        }
                    } else if code == 401 {
                        completion(false, res.msg ?? "", nil)
                    } else {
                        completion(false, res.msg ?? "", nil)
                    }
                } else {
                    completion(false, "Status code not found!", nil)
                }
            case .failure(let error):
                completion(false, error.localizedDescription, nil)
                break
            }
        }
    }
    //MARK: - Post Api
    func callPostApi<model: Decodable>(url: String, parameter: [String:Any]?, header: HTTPHeaders? = nil, model: model.Type, completion: @escaping (_ isSuccess: Bool, _ msg: String, _ result: model?) -> Void) {
        
        if !isConnectedToNetwork() {
            completion(false, "Internet connection not available", nil)
            return
        }
        
        var headers = header
        if header == nil {
            headers = ["Content-Type": "application/json",
                       "version": "2"]
        }
        
        AF.request(url, method: .post, parameters: parameter, encoding: encoding, headers: headers).responseDecodable(decoder: decoder) { (response: DataResponse<Model_APIResponse<model>, AFError>) in
            
            switch response.result {
            case .success(let res):
                if let code = response.response?.statusCode {
                    if code == 200 {
                        if res.success ?? false {
                            completion(true, res.msg ?? "", res.result)
                        } else {
                            completion(false, res.msg ?? "", nil)
                        }
                    } else if code == 401 {
                        completion(false, res.msg ?? "", nil)
                    } else {
                        completion(false, res.msg ?? "", nil)
                    }
                } else {
                    completion(false, "Status code not found!", nil)
                }
            case .failure(let error):
                completion(false, error.localizedDescription, nil)
                break
            }
        }
    }
    //MARK: - Post API call with image upload
    func callPostWithImage<model: Decodable>(url:String, image: UIImage, parameters:[String:Any] , header: HTTPHeaders?, model: model.Type, completion: @escaping (_ isSuccess: Bool, _ msg: String, _ result: model?) -> Void) {
        
        if !isConnectedToNetwork() {
            completion(false, "Internet connection not available", nil)
            return
        }
        
        var headers = header
        if header == nil {
            headers = ["Content-Type": "application/json",
                       "version": "2"]
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
        }, to: url, method: .post, headers: headers).responseDecodable(decoder: decoder) { (response: DataResponse<Model_APIResponse<model>, AFError>) in
            
            switch response.result {
            case .success(let res):
                if let code = response.response?.statusCode {
                    if code == 200 {
                        if res.success ?? false {
                            completion(true, res.msg ?? "", res.result)
                        } else {
                            completion(false, res.msg ?? "", nil)
                        }
                    } else if code == 401 {
                        completion(false, res.msg ?? "", nil)
                    } else {
                        completion(false, res.msg ?? "", nil)
                    }
                } else {
                    completion(false, "Status code not found!", nil)
                }
            case .failure(let error):
                completion(false, error.localizedDescription, nil)
                break
            }
        }
    }
}

