//
//  ViewController.swift
//  BaseDemo
//
//  Created by Moontechnolabs on 26/04/23.
//

import UIKit

class ViewController: UIViewController {
    //MARK: - Outlet and veriable declaration
    @IBOutlet weak var txtUserName: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    var loginViewModel = LoginViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initializer()
        
    }
}
//MARK: - Custom Function
extension ViewController {
    func initializer() {
        self.loginViewModel.viewController = self
    }
}
//MARK: - Click Event
extension ViewController {
    @IBAction func clickOnLogin(_ sender: UIButton) {

        let param:[String:Any] = ["deviceToken": "cccXxCEieEZSkLwTwA8BPj:APA91bFSpEktyJLlZvr9t5WB7sLuJBTpkXJwgP4JUIPjwHBIwbe-z1G8m6sBB62j2goYk9lTzNrefkxiaUfsi9LuqcE9GTpkNzL5XvENMBrpdaPGgVHZIrlF2fDsZKj3COTrE-M2ZFAF", "deviceType": "ios", "permanent_app_uuid": "965670E4-835A-4715-8EB4-2B603BC56A0B", "pin": self.txtPassword.text ?? "", "username": self.txtUserName.text ?? "" ]
        self.loginViewModel.callLoginApi(param: param)
    }
}
