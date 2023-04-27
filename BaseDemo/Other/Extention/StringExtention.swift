//
//  StringExtention.swift
//  BaseDemo
//
//  Created by Moontechnolabs on 27/04/23.
//

import UIKit

//MARK: - String Extension
public extension String {
    var isEmptyStr:Bool{
        return self.trimmingCharacters(in: NSCharacterSet.whitespaces).isEmpty
    }
}
extension String {

    func trim() -> String {

        return self.trimmingCharacters(in: .whitespacesAndNewlines)

    }
    //Remove white space in string
    func removeWhiteSpace() -> String {
        return self.trimmingCharacters(in: .whitespaces)
    }
  
    //Check string is number or not
    var isNumber : Bool {
        get{
            return !self.isEmpty && self.rangeOfCharacter(from: CharacterSet.decimalDigits.inverted) == nil
        }
    }
    //Check email is valid or not
    var isValidEmail: Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        return NSPredicate(format: "SELF MATCHES %@", emailRegEx).evaluate(with: self)
    }
    var isValidPassword : Bool {
        // least one uppercase or lowercase,
        // least one digit
        // least one symbol
        //  min 6 characters total
        let password = self.trimmingCharacters(in: CharacterSet.whitespaces)
        let passwordRegx = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[d$@$!%*?&#])[A-Za-z\\dd$@$!%*?&#]{8,}"//"^(?=.*[a-zA-Z])(?=.*\\d)(?=.*?[#?!@$%^&<>*~:`-]).{6,}$"
        let passwordCheck = NSPredicate(format: "SELF MATCHES %@",passwordRegx)
        return passwordCheck.evaluate(with: password)

    }
    var isPhoneNumber: Bool {
        let phoneNumberRegEx = "^[0-9+]{9,12}$"
        return NSPredicate(format: "SELF MATCHES %@", phoneNumberRegEx).evaluate(with: self)
    }
    //Check string is Float or not
    var isFloat : Bool {
        get{
            if Float(self) != nil {
                return true
            }else {
                return false
            }
        }
    }
    func fromBase64() -> String {
        guard let data = Data(base64Encoded: self, options: Data.Base64DecodingOptions.init(rawValue: 0)) else {
            return self
        }
        return String(data: data, encoding: .utf8) ?? self
    }
    func toBase64() -> String {
        return Data(self.utf8).base64EncodedString()
    }
    
}


//MARK: - check string nil
func createString(value: AnyObject) -> String
{
    var returnString: String = ""
    if let str: String = value as? String {
        
        returnString = str
        
    } else if let str: Int = value as? Int {
        
        returnString = String.init(format: "%d", str)
        
    } else if let _: NSNull = value as? NSNull {
        
        returnString = String.init(format: "")
    }else if let str: Double = value as? Double {
        returnString = String.init(format: "%.4f", str) //2.99
    }else if let str: NSNumber = value as? NSNumber {
        returnString = String.init(format: "%.4f", str) //2.99
    }else if let str: NSDecimalNumber = value as? NSDecimalNumber {
        let usLocale = Locale(identifier: "en_US")
      
        let nf = NumberFormatter()
        nf.maximumFractionDigits = 4
        nf.locale = usLocale
        returnString = nf.string(from: str)! //2.99
    }
    return returnString
}
extension String {
    func capitalizingFirstLetter() -> String {
      return prefix(1).uppercased() + self.lowercased().dropFirst()
    }

    mutating func capitalizeFirstLetter() {
      self = self.capitalizingFirstLetter()
    }
}
