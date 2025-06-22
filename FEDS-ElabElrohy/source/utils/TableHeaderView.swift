//
//  TableHeaderView.swift
//  FEDS-Center-Dev-IOS
//
//  Created by Omar Pakr on 16/05/2024.
//

import SwiftUI

    public var TableHeaderView: some View {
        @StateObject var genralVm : GeneralVm = GeneralVm()

        return
        HStack {
            Text("#")
                .foregroundColor(genralVm.isDark ? Color(Colors().darkBodyText): Color(Colors().lightBodyText))
                .font(
                    Font.custom(Fonts().getFontLight(), size: 20)
                        .weight(.bold)
                )
                .lineLimit(1)
                .frame(minWidth: 50)// Optional: Set minimum width for number column
                .frame(alignment: .center)
            
            Text(NSLocalizedString("price", comment: ""))
                .foregroundColor(genralVm.isDark ? Color(Colors().darkBodyText): Color(Colors().lightBodyText))
                .font(
                    Font.custom(Fonts().getFontLight(), size: 20)
                        .weight(.bold)
                )
                .lineLimit(1)
                .frame(minWidth: 100) // Optional: Set minimum width for price column
                .frame(alignment: .center)
            
            Text(NSLocalizedString("date", comment: ""))
                .foregroundColor(genralVm.isDark ? Color(Colors().darkBodyText): Color(Colors().lightBodyText))
                .font(
                    Font.custom(Fonts().getFontLight(), size: 20)
                        .weight(.bold)
                )
                .lineLimit(1)
                .frame(alignment: .center)
        }
    }

