//
//  UserProfileVC.swift
//  BaseDemo
//
//  Created by Moontechnolabs on 26/04/23.
//

import UIKit

class UserProfileVC: UIViewController {
    
    //MARK: - Outlet and veriable declaration
    @IBOutlet weak var lblUserName: UILabel!
    @IBOutlet weak var lblEmail: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initializer()
    }
}
//MARK: - Custom Function
extension UserProfileVC {
    func initializer() {
        let userDetail = getUserInfo()
        self.lblUserName.text = userDetail?.username
        self.lblEmail.text = userDetail?.email
    }
}
//MARK: - Click Event
extension UserProfileVC {
}
