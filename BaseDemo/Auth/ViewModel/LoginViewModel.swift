//
//  LoginViewModel.swift
//  BaseDemo
//
//  Created by Moontechnolabs on 26/04/23.
//

import UIKit

class LoginViewModel {
    
    var userData :[String:Any]?
    weak var viewController: ViewController?
    
    func callLoginApi(param: [String:Any]) {
        
        //MARK: - Show loader here
        APIManager.shared.callPostApi(url: WebURL.login, parameter: param, model: ModelUserDetail.self) { isSuccess, msg, result in
            
            if isSuccess {
                setMyUserDefaults(value: result?.accessToken ?? "" , key: MyUserDefaults.bearerToken)
                setUserInfo(objUserInfo: result!)
                //MARK: - Set Root controller here
                appDelegate.setHomeRoot()
                
            } else {
                //Show Error alert or toast (msg)
            }
        }
    }
}
