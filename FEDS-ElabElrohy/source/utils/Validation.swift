//
//  Validation.swift
//  Medical Center
//
//  Created by Omar pakr Hany on 02/08/2021.
//  Copyright © 2021 Admins-Egypt. All rights reserved.
//


import Foundation
import UIKit
import libPhoneNumber_iOS

class Validation {
    
    static let regex = "^(?=.*?\\p{Lu})(?=.*?\\p{Ll})(?=.*?\\d)(?=.*?[`~!@#$%^&*()\\-_=+\\\\|\\[{\\]};:'\",<.>/?]).*$"
    static let ARABIC_USERNAME = "^[\\u0621-\\u064A\\s]{2,50}$"
    static let emailRegex = "^([\\w\\.\\-]+)@([\\w\\-]+)((\\.(\\w){2,3})+)$"
    static let ENFLIS_NAME = "^[A-Za-z ]{2,50}$"
    static let USERNAME = "^(?=.{5,20}$)(?![_.])(?!.*[_.]{2})[a-zA-Z0-9._]+(?<![_.])$"

    public static func isValidUserName(text : String) -> Bool {
        let userPred = NSPredicate(format: "SELF MATCHES %@", USERNAME)
        return userPred.evaluate(with: text)
    }
  
    public static func IsValidNameAr(text: String) -> Bool{
       let namePred = NSPredicate(format: "SELF MATCHES %@", ARABIC_USERNAME)
        return namePred.evaluate(with: text)
    }
    
    public static func IsValidNameEn(text: String) -> Bool{
       let namePred = NSPredicate(format: "SELF MATCHES %@", ENFLIS_NAME)
        return namePred.evaluate(with: text)
    }
    
    public static func IsValidContent(text: String, length: Int = 1) -> Bool{
     
        return  !text.isEmpty && text.count >= length
    }
    
    public static func isValidPhone(phone: String, contryCodeName: String) -> Bool {
        if let phoneUtil = NBPhoneNumberUtil.sharedInstance() {
            do {
                let phoneNumber = try phoneUtil.parse(phone, defaultRegion: contryCodeName)
                return phoneUtil.isValidNumber(phoneNumber)
            } catch {
                return false
            }
        }
        return false
    }



    
    public static func vaildPatternDate(date :String?) -> Bool{
        
        if (date == nil ){
                        return false
                    }
        
        let dateFormatter1 = DateFormatter()
        dateFormatter1.dateFormat = "yyyy/MM/dd"
        let dateFormatter2 = DateFormatter()
        dateFormatter2.dateFormat = "dd/MM/yyyy"
        let dateFormat1 = dateFormatter1.date(from:date!)
        let dateFormat2 = dateFormatter2.date(from:date!)
        if dateFormat1 == nil && dateFormat2 == nil{
            return false
        } else {
            return true
        }
       
    }

    public static func vaildPatternDateTime(date :String?) -> Bool{

      if (date == nil ){
                      return false
                  }

      let dateFormatter1 = DateFormatter()
      dateFormatter1.dateFormat = "yyyy/MM/dd HH:mm:ss"
      let dateFormatter2 = DateFormatter()
      dateFormatter2.dateFormat = "dd/MM/yyyy HH:mm:ss"
      let dateFormat1 = dateFormatter1.date(from:date!)
      let dateFormat2 = dateFormatter2.date(from:date!)
      if dateFormat1 == nil && dateFormat2 == nil{
          return false
      } else {
          return true
      }
  }
    
    static func isValidpassword(password : String) -> Bool {
        let passwordtesting = NSPredicate(format: "SELF MATCHES %@", regex)
        return passwordtesting.evaluate(with: password)
    }
    
    static func isValidEmail(email: String) -> Bool {
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegex)
        return emailPred.evaluate(with: email)
    }
    
    static func isValidSalary( number : Double) -> Bool{
        if number >= 0 && number <= 1000000{
            return true
        } else {
        return false
        }
    }
    
 }
