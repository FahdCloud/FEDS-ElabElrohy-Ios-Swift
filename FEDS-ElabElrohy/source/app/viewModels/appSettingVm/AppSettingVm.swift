//
//  AppSettingVm.swift
//  FPLS-Dev
//
//  Created by Omar pakr on 04/12/2023.
//

import Foundation
import UIKit
import SwiftUI


class AppSettingVm : ObservableObject {
    
    @Published var genralVm : GeneralVm = GeneralVm()
    
    
    @Published var userAppSetting : UserAppSetting = UserAppSetting()
    @Published var isLoading : Bool = false
    @Published var noData : Bool = false
    @Published var closeApp : Bool = false
    @Published var msg : String = ""
    @Published var showLogOut : Bool = false
    @Published var tomeZoneData = [ListData]()
    @Published var dateFormateData = [ListData]()
    @Published var timeFormateData = [ListData]()

    init(){
        getTimeZoneData()
        getDateFormateData()
        getTimeFormateData()
    }
    
    func getAppSettings(){
        self.isLoading = true
        
        do {
            try Api().getAppSettings(userAuth:self.genralVm.authToken ,onCompletion: { status, msg, data in
                
                if status == self.genralVm.constants.STATUS_SUCCESS {
                    self.isLoading = false
                    self.userAppSetting = data
                    
                }
                else if status == self.genralVm.constants.STATUS_INVALID_TOKEN ||
                            status == self.genralVm.constants.STATUS_VERSION{
                    self.isLoading = false
                    self.msg = msg
                    self.showLogOut = true
                    Helper.removeUserDefaultsAndCashes()
                    UserDefaults.standard.set(msg, forKey: "logoutMsg")
                }
                else {
                    self.isLoading = false
                    self.msg = msg
                }
            })
        } catch {
            self.isLoading = false
            self.msg = error.localizedDescription
        }
    }
    
    func updateUserAppSetting(languageToken:String,themeToken :String,timeZoneToken :String,dateFormateToken:String,timeFormate:String,customSettings:String, receiveNotificationStatus:String){
        self.isLoading = true
        
        do {
            try Api().updateUserAppSettings(userAuth: self.genralVm.authToken, languageToken:languageToken , themeToken: themeToken, timeZoneToken: timeZoneToken, dateFormatToken: dateFormateToken, timeFormatToken: timeFormate, customSettings: customSettings, receiveNotificationStatus: receiveNotificationStatus) { status, msg, data in
                if status == self.genralVm.constants.STATUS_SUCCESS {
                    self.isLoading = false
                    self.userAppSetting = data.userAppSettingData ?? UserAppSetting()
                    //to save new setting in user Data
                    if var savedData = UserDefaults.standard.data(forKey: "userData") {
                        do {
                            // Decode the JSON data back into APIAppData
                            var decodedData = try JSONDecoder().decode(APIAppData.self, from: savedData)
                            decodedData.userAuthorizeToken = data.userAuthorizeToken
                            decodedData.userAppSettingData = data.userAppSettingData
                            // Encode the updated APIAppData instance back into JSON data
                            savedData = try JSONEncoder().encode(decodedData)
                            // Save the updated JSON data back to UserDefaults
                            UserDefaults.standard.set(savedData, forKey: "userData")
                        } catch {
                            print("Error decoding or encoding APIAppData:", error)
                        }
                    } else {
                        print("No data found for key 'appData' in UserDefaults")
                    }
                    
                    UserDefaultss().saveStrings(value: data.userAuthorizeToken!, key: "userAuth")
                    if languageToken == Constants().APP_LANGUAGE_AR {
                        self.changeLanguage(to: Constants().APP_LANGUAGE_AR)
                    } else {
                        self.changeLanguage(to: Constants().API_LANGUAGE_EN)
                    }
                    self.closeApp = true
                } else {
                    self.isLoading = false
                    self.closeApp = false
                    self.msg = msg
                    self.showLogOut = true
                    Helper.removeUserDefaultsAndCashes()
                    UserDefaults.standard.set(msg, forKey: "logoutMsg")
                }
            }
        } catch {
            self.isLoading = false
            self.isLoading = false
            self.msg = error.localizedDescription
        }
    }
    
    private func changeLanguage(to language: String) {
        
        let newLocale = Locale(identifier: language)
        UserDefaults.standard.set([newLocale.identifier], forKey: "AppleLanguages")
        UserDefaults.standard.synchronize()
        
    }
    
    func getTimeZoneData(){
        do {
            if let data = UserDefaults.standard.data(forKey: "constantListData") {
                let decodedData = try JSONDecoder().decode(ConstantsListsDataa.self, from: data)
                self.tomeZoneData.append(contentsOf: decodedData.listTimeZoneInfo!)
            } else {
                print("No data found for key 'constantListData'")
            }
        } catch {
            print("Failed to decode data: \(error)")
        }
    }
    
    func getDateFormateData(){
        do {
            if let data = UserDefaults.standard.data(forKey: "constantListData") {
                let decodedData = try JSONDecoder().decode(ConstantsListsDataa.self, from: data)
                self.dateFormateData.append(contentsOf: decodedData.listDateFormatType!)
            } else {
                print("No data found for key 'constantListData'")
            }
        } catch {
            print("Failed to decode data: \(error)")
        }
    }

    func getTimeFormateData(){
        do {
            if let data = UserDefaults.standard.data(forKey: "constantListData") {
                let decodedData = try JSONDecoder().decode(ConstantsListsDataa.self, from: data)
                self.timeFormateData.append(contentsOf: decodedData.listTimeFormatType!)
                print(timeFormateData)
            } else {
                print("No data found for key 'constantListData'")
            }
        } catch {
            print("Failed to decode data: \(error)")
        }
    }

    
    
}


