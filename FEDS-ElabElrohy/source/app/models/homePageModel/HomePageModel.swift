//
//  HomePageModel.swift
//  FEDS-Center-Dev
//
//  Created by Omar pakr on 19/12/2023.
//

import Foundation

struct HomePageModel : Identifiable {
    let id : String = UUID().uuidString
    let name : String
    let image : String
    let route : String
}
