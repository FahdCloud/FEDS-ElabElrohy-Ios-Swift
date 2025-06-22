//
//  SocailMediaModel.swift
//  FPLS-Dev
//
//  Created by Omar pakr on 01/12/2023.
//

import Foundation


struct SocialMediaItem :Codable{
    var imageName: String
    var text: String
    var link: String?
    var isHaveLink: Bool
}
