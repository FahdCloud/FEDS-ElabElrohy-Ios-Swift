//
//  FilterModel.swift
//  FPLS-Dev
//
//  Created by Omar pakr on 12/10/2023.
//

import Foundation

struct FilterModel:Identifiable {
    var id : String = UUID().uuidString
    var name : String
    var image : String
    var token : String
    var count : Int
    
}
