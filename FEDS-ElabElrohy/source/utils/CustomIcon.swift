//
//  CutomMenuIcon.swift
//  FEDS-BSQ
//
//  Created by Omar Pakr on 06/05/2024.
//

import SwiftUI

struct CustomIcon: View {
    @StateObject var genralVm : GeneralVm = GeneralVm()

    var imageName: String
    var width: CGFloat = 30
    var height: CGFloat = 30
    var darkColor: Color = Color(Colors().darkMenuIconUnSelected)
    var lightColor: Color = Color(Colors().lightMenuIconUnSelected)
    
    var body: some View {
        Image(uiImage: UIImage(named: imageName)?.withRenderingMode(.alwaysTemplate) ?? UIImage())
                    .resizable()
                    .frame(width: width,height: height)
                    .foregroundColor(genralVm.isDark ? darkColor : lightColor )
    }
}


