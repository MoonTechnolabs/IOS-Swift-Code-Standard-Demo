//
//  Helper.swift
//  BaseDemo
//
//  Created by Moontechnolabs on 26/04/23.
//

import UIKit
import SystemConfiguration


//MARK: - Check internet connection event
func isConnectedToNetwork() -> Bool {
    var zeroAddress = sockaddr_in(sin_len: 0, sin_family: 0, sin_port: 0, sin_addr: in_addr(s_addr: 0), sin_zero: (0, 0, 0, 0, 0, 0, 0, 0))
    zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
    zeroAddress.sin_family = sa_family_t(AF_INET)
    let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
        $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
            SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
        }
    }
    var flags = SCNetworkReachabilityFlags()
    if !SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) {
        return false
    }
    let isReachable = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
    let needsConnection = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
    return (isReachable && !needsConnection)
}

class Helper {
    
    static let shared:Helper = Helper()
    
    func fetchTopWindownsVC() -> UIViewController {
           if let VC = appDelegate.window?.rootViewController?.presentedViewController {
               if  VC is UINavigationController {
                   let navVC = VC as? UINavigationController
                   if  let lastVC:UIViewController = navVC?.viewControllers.last {
                      return lastVC
                   }else{
                       return appDelegate.window!.rootViewController!
                   }
               }else{
                   return appDelegate.window!.rootViewController!
               }
           }else{
               return appDelegate.window!.rootViewController!
           }
       }

    func fetchTopWindownsView(aView:UIView)  {
        if let VC = appDelegate.window?.rootViewController?.presentedViewController {
            if  VC is UINavigationController {
                let navVC = VC as? UINavigationController
                if  let lastVC:UIViewController = navVC?.viewControllers.last {
                    lastVC.view.addSubview(aView)
                }else{
                    appDelegate.window?.rootViewController?.view.addSubview(aView)
                }
            }else{
                appDelegate.window?.rootViewController?.view.addSubview(aView)
            }
        }else{
            appDelegate.window?.rootViewController?.view.addSubview(aView)
        }
    }
    func getTopWindownsView() -> UIView {
        let viewRoot = (appDelegate.window?.rootViewController?.view)!
        if let VC = appDelegate.window?.rootViewController?.presentedViewController {
            if  VC is UINavigationController {
                let navVC = VC as? UINavigationController
                if  let lastVC:UIViewController = navVC?.viewControllers.last {
                    return lastVC.view
                }
            }
        }
        return viewRoot
    }
}
