//
//  Language.swift
//  FPLS-Dev
//
//  Created by Omar pakr on 03/09/2023.
//

import Foundation
class Language {
  static func getLanguageISO() -> String {
    let locale = Locale.current.language.languageCode!.identifier
    var region = ""
    if locale == Constants().APP_IOS_LANGUAGE_AR {
      region = Constants().REGION_AR
    } else {
      region =  Constants().REGION_EN
    }

      return locale + "-" + region
  }
}
