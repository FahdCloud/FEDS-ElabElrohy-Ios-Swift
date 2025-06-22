//
//  AppInfo.swift
//  FEDS-Center-Dev-IOS
//
//  Created by Omar Pakr on 27/03/2024.
//

import Foundation
class AppInfo {
    
 public   var appVersion: String {
        Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String ?? "Unknown"
    }
    
    // استرجاع رقم البناء من Info.plist
 public   var buildNumber: String {
        Bundle.main.object(forInfoDictionaryKey: "CFBundleVersion") as? String ?? "Unknown"
    }
}
