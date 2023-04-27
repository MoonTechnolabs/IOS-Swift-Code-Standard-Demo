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
    
    func callLoginApi(param:[String:Any]) {
        
        //MARK: - Show loader here
        APIManager.shared.callPostApi(url: WebURL.login, parameter: param, header: nil) {  (dict, error) in
            //MARK: - Hide loader here
            if error == nil {
                let responseDic = dict
                objectFrom(dic: responseDic) { (APIResonse: Model_APIResponse<ModelUserDetail>? ) in
                    if APIResonse != nil{
                        if ((APIResonse?.success) ?? false) {
                            setMyUserDefaults(value: APIResonse?.result?.accessToken ?? "" , key: MyUserDefaults.bearerToken)
                            setMyUserDefaults(value: true, key: MyUserDefaults.login)
                            setUserInfo(objUserInfo: (APIResonse?.result)!)
                            //MARK: - Set Root controller here
                            appDelegate.setHomeRoot()
                            
                        }else{
                            //Show Error alert or toast (APIResonse.message)
                        }
                    }else {
                        //Show Error alert or toast (APIResonse.message)
                    }
                }
            }else {
                //Show Error alert or toast ( error?.localizedDescription)
            }
        }
    }
}
