//
//  UserCardView.swift
//  FPLS-Dev
//
//  Created by Omar pakr on 26/11/2023.
//


import SwiftUI

struct UserCardView: View {
    @StateObject var genralVm : GeneralVm = GeneralVm()

    let imageUrl : String
    let courseName : String
    let lecturerName : String
    let coursePrice : String
    let coursePriceInOffer : String
    let educationalCourseInOfferStatus : Bool
    var onClick: (() -> Void)?
    
    var body: some View {
        VStack(alignment: .center, spacing: 8) {
            VStack (spacing: 15){
                GeometryReader { geometry in
                    ZStack (alignment: .bottom){
                        
                        CustomImageUrl(defaultImage: "course_default",
                                       url: imageUrl, width: UIScreen.main.bounds.width - 50, height: .infinity){
                            self.onClick?()
                        }
                        
                        HStack(spacing:40) {
                            VStack {
                                Text(lecturerName)
                                    .font(
                                        Font.custom(Fonts().getFontBold(), size: 16)
                                            .weight(.bold)
                                    )
                                    
                                    .multilineTextAlignment(.center)
                                    .lineLimit(2)
                                    .foregroundColor(genralVm.isDark ? Color(Colors().darkCardBgText): Color(Colors().lightCardBgText))
                                    .frame(width: geometry.size.width, height: .infinity, alignment: .center)
                            }
                            .frame(maxWidth:.infinity)
                            .frame(height:.infinity)
                        }
                        .frame(maxHeight:.infinity , alignment:.bottom)
                        .frame(width: geometry.size.width)
                    }
                    .frame(width: geometry.size.width)
                    .background(Color.black.opacity(0.8))
                    .cornerRadius(5)
                }
            }
        }
        .background(genralVm.isDark ? Color(Colors().darkCardBg): Color(Colors().lightCardBg))
        .cornerRadius(12)
        .shadow(color: genralVm.isDark ? Color.white : Color.gray, radius: 4, x: 0, y: 3)
    }
}


