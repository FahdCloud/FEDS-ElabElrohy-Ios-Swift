//
//  CustomBackButton.swift
//  FEDS-Center-Dev-IOS
//
//  Created by Omar Pakr on 02/04/2024.
//

import SwiftUI

struct CustomBackButton: View {
    let constants = Constants()
    @State  var lang = Locale.current.language.languageCode!.identifier
    @State private var toast: Toast? = nil
    var onClick: (() -> Void)?
   
    var body: some View {
        HStack(spacing: 6){
            if self.lang == constants.APP_IOS_LANGUAGE_AR  {
                Image("arrow-right")
                    .resizable()
                    .frame(width: 30,height: 30)
                
                
            }else {
                Image("arrow-left")
                    .resizable()
                    .frame(width: 30,height: 30)
            }
            
            Text(NSLocalizedString("back", comment: ""))
                .foregroundColor(Color.gray)
                .font(
                    Font.custom(Fonts().getFontBold(), size: 20)
                        .weight(.bold)
                )
            
        }
        .onTapGesture {
            self.onClick?()
        }
    }
}

#Preview {
    CustomBackButton()
}
