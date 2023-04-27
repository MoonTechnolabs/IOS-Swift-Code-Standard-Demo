//
//  UIViewController.swift
//  BaseDemo
//
//  Created by Moontechnolabs on 27/04/23.
//

import UIKit


//MARK: - UIViewController Extension

extension UIViewController {
    
    func showAlertWithCompletion(title: String?, message: String?, options: String... , completion: @escaping (Int) -> Void) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle:  .alert)
        
        for (index, option) in options.enumerated() {
            alertController.addAction(UIAlertAction.init(title: option, style: .default, handler: { (action) in
                completion(index)
            }))
        }
        self.present(alertController, animated: true, completion: nil)
    }
    
    func showAlert(msg:String){
        DispatchQueue.main.async {
            let alert = UIAlertController(title: "", message: NSLocalizedString(msg, comment: ""), preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
}
