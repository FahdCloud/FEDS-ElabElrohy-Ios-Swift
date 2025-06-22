//
//  FamilyModel.swift
//  FPLS-Dev
//
//  Created by Omar pakr on 05/11/2023.
//

import Foundation

struct Children:Identifiable {
    let id : String = UUID().uuidString
    let name : String
    let image : String
    let token : String
}
