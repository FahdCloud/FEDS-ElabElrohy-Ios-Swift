//
//  Extension.swift
//  FPLS-Dev
//
//  Created by Omar pakr on 15/08/2023.
//

import Foundation

let languageKey = "languageKey"


struct AppNotification {
    static let changeLanguge = Notification.Name("changeLanguage")
}

extension String {
    
    func localizedString() -> String? {
        
        var defaultLang = "en"
        if let selectedLanguage = UserDefaults.standard.string(forKey: languageKey) {
            defaultLang = selectedLanguage
        }
        
        
        return NSLocalizedString(self, tableName: defaultLang, comment: "")
    }
}
