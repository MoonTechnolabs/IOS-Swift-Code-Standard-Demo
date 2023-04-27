//
//  AppDelegate.swift
//  BaseDemo
//
//  Created by Moontechnolabs on 26/04/23.
//

import UIKit


let appDelegate = UIApplication.shared.delegate as! AppDelegate

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        return true
    }
    
    
    

}

extension AppDelegate {
    
    func setLoginRoot() {
        appDelegate.window?.rootViewController = nil
        let loginVC  = storyBoards.main.instantiateInitialViewController()
        appDelegate.window?.rootViewController = loginVC
        appDelegate.window?.makeKeyAndVisible()
        appDelegate.window?.setNeedsDisplay()
    }
    
    func setHomeRoot() {
        appDelegate.window?.rootViewController = nil
        let homeVC  = storyBoards.userProfile.instantiateInitialViewController()
        appDelegate.window?.rootViewController = homeVC
        appDelegate.window?.makeKeyAndVisible()
        appDelegate.window?.setNeedsDisplay()
    }
}
