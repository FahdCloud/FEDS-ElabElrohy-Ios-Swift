//
//  CustomPopupContentView.swift
//  FEDS-Dev-Ver-One
//
//  Created by Omar Pakr on 03/10/2024.
//

import SwiftUI

struct CustomPopupContentView: View {
    @StateObject var genralVm : GeneralVm = GeneralVm()
    var iconName: String
    var title: String
    var message: String
    
    var buttonOneAction: (() -> Void)?
    var buttonOneTitle: String = ""
    var buttonOneColor: Color = .green
    
    var buttonTwoAction: (() -> Void)?
    var buttonTwoTitle: String = ""
    var buttonTwoColor: Color = .gray
    
    var buttonThreeAction: (() -> Void)?
    var buttonThreeTitle: String = ""
    var buttonThreeColor: Color = .gray
    
    var numAction: Int = 0
    
    var body: some View {
        
        VStack{
            HStack(spacing:10){
                Image(iconName)
                    .resizable()
                    .frame(width: 35,height: 35)
                
                Text(NSLocalizedString(title, comment: ""))
                    .lineSpacing(3)
                    .foregroundStyle(genralVm.isDark ? Color(Colors().darkCardText): Color(Colors().lightCardText))
                    .font(
                        Font.custom(Fonts().getFontBold(), size: 30)
                            .weight(.bold)
                    )
                    .lineLimit(3)
            }
            .frame(alignment: .center)
            .padding(.bottom, 10)
            
            Text(message)
                .font(
                    Font.custom(Fonts().getFontBold(), size: 24)
                        .weight(.bold)
                )
                .padding(.vertical, 20)
            
            if numAction == 1{
                
                ButtonAction(text:buttonOneTitle,
                             textSize : 30 ,
                             color: buttonOneColor) {
                    self.buttonOneAction?()
                }
                             .frame(width: 180)
                
            }else if numAction == 2{
                
                HStack(spacing: 10) {
                    ButtonAction(text:buttonOneTitle,
                                 textSize : 30 ,
                                 color: buttonOneColor) {
                        self.buttonOneAction?()
                    }
                                 .frame(width: 180)
                    
                    ButtonAction(text:buttonTwoTitle,
                                 textSize : 30 ,
                                 color: buttonTwoColor) {
                        self.buttonTwoAction?()
                    }
                                 .frame(width: 180)
                }
                
                }else if numAction == 3 {
                    
                    HStack(spacing: 10) {
                        ButtonAction(text:buttonOneTitle,
                                     textSize : 30 ,
                                     color: buttonOneColor) {
                            self.buttonOneAction?()
                        }
                                     .frame(width: 180)
                        
                        ButtonAction(text:buttonTwoTitle,
                                     textSize : 30 ,
                                     color: buttonTwoColor) {
                            self.buttonTwoAction?()
                        }
                                     .frame(width: 180)   
                        ButtonAction(text:buttonThreeTitle,
                                     textSize : 30 ,
                                     color: buttonThreeColor) {
                            self.buttonThreeAction?()
                        }
                                     .frame(width: 180)
                    }
                        
                }else {
                    
                }
            }
        
        .padding(.all, 15)
    }
}

