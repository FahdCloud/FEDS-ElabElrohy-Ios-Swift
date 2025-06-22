//
//  TopListModel.swift
//  FPLS-Dev
//
//  Created by Omar pakr on 04/09/2023.
//

import Foundation

struct ShortcutModel:Identifiable {
    let id : String = UUID().uuidString
    let name : String
    let image : String
    let route : String
}
