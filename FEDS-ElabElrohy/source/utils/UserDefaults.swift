//
//  UserDefaults.swift
//  FPLS-Dev
//
//  Created by Omar pakr on 03/09/2023.
//

import Foundation
class UserDefaultss {
    //MARK:- Strings
    func saveStrings(value : String , key : String){
         UserDefaults.standard.set(value, forKey: key)
    }
    
    func restoreString(key : String) -> String{
        let stringValue : String = UserDefaults.standard.value(forKey: key) as? String ?? ""
        return stringValue

    }
    
    //MARK:- Floats
    
    func saveFLoat(value : Float , key : String){
         UserDefaults.standard.set(value, forKey: key)
    }
    
    func restoreFloat(key : String) -> Float{
        let floatValue : Float = UserDefaults.standard.value(forKey: key) as? Float ?? 0.0
        return floatValue
    }
    
    //MARK:- Double
    func saveDouble(value : Double , key : String){
         UserDefaults.standard.set(value, forKey: key)
    }
    
    
    func restoreDouble(key : String) -> Double{
        let doubleValue : Double =  UserDefaults.standard.value(forKey: key) as? Double ?? 0.0
        return doubleValue
    }
    
    //MARK:- Integer
    func saveInt(value : Int , key : String){
         UserDefaults.standard.set(value, forKey: key)
    }
    
    
    func restoreInt(key : String) -> Int{
        let intValue : Int = UserDefaults.standard.value(forKey: key) as? Int ?? 0
        return intValue
    }
    //MARK:- Boolean
    
    func saveBool(value : Bool , key : String){
         UserDefaults.standard.set(value, forKey: key)
    }
    func restoreBool(key : String) -> Bool{
        let boolValue : Bool = UserDefaults.standard.value(forKey: key) as? Bool ?? false
        return boolValue
    }
    
    

    
    //MARK:- Remove
    
    func removeObject(forKey : String){
        UserDefaults.standard.removeObject(forKey: forKey)
    }
    
    
    
    
}
