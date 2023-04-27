//
//  MyUserDefaults.swift
//  BaseDemo
//
//  Created by Moontechnolabs on 26/04/23.
//

import UIKit

//MARK: - MyUserDefaults Constant
struct MyUserDefaults {
    static let bearerToken:String = "bearerToken"
    static let login:String = "login"
    
}
//MARK: - Get/Set UserDefaults
func setMyUserDefaults(value:Any, key:String){
    UserDefaults.standard.set(value, forKey: key)
    UserDefaults.standard.synchronize()
}
func isKeyPresentInUserDefaults(key: String) -> Bool {
    return UserDefaults.standard.object(forKey: key) != nil
}
func getMyUserDefaults(key:String)->Any{
    return UserDefaults.standard.value(forKey: key) ?? ""
}
func getMyUserDefaultsBoolVal(key:String)->Bool{
    return UserDefaults.standard.bool(forKey: key)
}
func clearMyUserDefaluts(){
    let appDomain = Bundle.main.bundleIdentifier!
    UserDefaults.standard.removePersistentDomain(forName: appDomain)
    UserDefaults.standard.synchronize()
}
func removeMyUserDefaults(key:String){
    UserDefaults.standard.removeObject(forKey: key)
}
//MARK:- UserInfo
func getUserInfo() -> ModelUserDetail? {
    
    if let decoded =  UserDefaults.standard.object(forKey: "UserInfo") as? Data {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        if let ModelUserData = try? decoder.decode(ModelUserDetail.self, from: decoded) {
            return ModelUserData
        }
        return nil
    }
    return nil
}
func setUserInfo(objUserInfo: ModelUserDetail) {
    
    let encoder = JSONEncoder()
    if let encoded = try? encoder.encode(objUserInfo) {
        UserDefaults.standard.set(encoded, forKey: "UserInfo")
    }
}
