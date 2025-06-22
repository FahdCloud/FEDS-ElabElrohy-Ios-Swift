//
//  EducationCoursesCardView.swift
//  FPLS-Dev
//
//  Created by Omar pakr on 29/10/2023.
//

import SwiftUI


import SwiftUI

struct EducationCoursesCardView: View {
    let needImage : Bool
    let imageUrl : String
    let courseName : String
    let lecturerName : String
    let coursePrice : String
    let educationCategory : String
    let coursePriceInOffer : String
    let educationalCourseInOfferStatus : Bool
    let date : String
    let time : String
    let isDark = UserDefaultss().restoreBool(key: "isDark")

    var body: some View {
        VStack {
            
            VStack(alignment: .center, spacing: 8) {
                ZStack{
                    ZStack{
                        CustomImageUrl(url: imageUrl,width: .infinity,height: .infinity)
                            .disabled(true)
                    }
                    .background(isDark ? .black : .white)
                    .cornerRadius(12)
                    
                    VStack{
                        HStack {
                            HStack{
                                Image("book_tab_bar")
                                    .resizable()
                                    .frame(width: 20,height: 20)
                                
                                Text(educationCategory)
                                    .font(
                                        Font.custom(Fonts().getFontBold(), size: 14)
                                            .weight(.bold)
                                    )
                                    .multilineTextAlignment(.center)
                                    .lineLimit(4)
                                    .foregroundColor(.white)
                                    .frame(width: .infinity, height: .infinity, alignment: .center)
                                                             
                                Spacer()
                             
                                Image("teacher-icon")
                                    .resizable()
                                    .frame(width: 20,height: 20)
                                
                                
                                Text(lecturerName)
                                    .font(
                                        Font.custom(Fonts().getFontBold(), size: 14)
                                            .weight(.bold)
                                    )
                                    .multilineTextAlignment(.center)
                                    .lineLimit(4)
                                    .foregroundColor(.white)
                                    .frame(width: .infinity, height: .infinity, alignment: .center)
                                
                            }
                            .padding()
                            .frame(maxWidth:.infinity)
                            .frame(height:30)
                            .background(Color.black.opacity(0.7))
                        }
                        .frame(maxHeight:.infinity , alignment:.top)
                        .frame(width: 350)
                        
                        
                        
                        VStack (spacing:-56){
                        
                            
                            HStack(spacing:40) {
                                VStack{
                                    Text(coursePrice)
                                        .font(
                                            Font.custom(Fonts().getFontBold(), size: 14)
                                                .weight(.bold)
                                        )
                                        .multilineTextAlignment(.center)
                                        .lineLimit(4)
                                        .foregroundColor(.white)
                                        .frame(width: .infinity, height: .infinity, alignment: .trailing)
                                        .padding()
                                }
                                .frame(height:30)
                                .background(Color.black.opacity(0.7))
                            }
                            .frame(maxHeight:.infinity , alignment:.bottom)
                            .frame(maxWidth:.infinity , alignment:.trailing)
                            .frame(width: 350)
                            
                            HStack(spacing:40) {
                                VStack{
                                    Text(courseName)
                                        .font(
                                            Font.custom(Fonts().getFontBold(), size: 14)
                                                .weight(.bold)
                                        )
                                        .multilineTextAlignment(.center)
                                        .lineLimit(4)
                                        .foregroundColor(.white)
                                        .frame(width: 300, height: .infinity, alignment: .center)
                                }
                                .frame(maxWidth:.infinity)
                                .frame(height:30)
                                .background(Color.black.opacity(0.7))
                            }
                            .frame(maxHeight:.infinity , alignment:.bottom)
                            .frame(width: 350)
                        }
                    }
                }
                .frame(width: 350,height: .infinity,alignment: .leading)
                
                
            }
            .padding(.trailing, 46)
            .frame(width: 350,height: 240, alignment: .leading)
            .background(isDark ? .black : .white)
            .cornerRadius(12)
            .shadow(color: isDark ? .white : .black.opacity(0.25), radius: 4, x: 0, y: 1)
            
            HStack {
                VStack{
                    Text(date + " - " + time)
                        .font(
                            Font.custom(Fonts().getFontBold(), size: 12)
                                .weight(.light)
                        )
                        .multilineTextAlignment(.center)
                        .lineLimit(4)
                        .foregroundColor(isDark ? .white : .black)
                        .frame(width: 300, height: .infinity, alignment: .trailing)
                }
                .frame(maxWidth:.infinity)
                .frame(height:30)
            }
            .frame(maxHeight:20 , alignment:.trailing)
            .frame(width: 350)

            
            Rectangle()
                .fill(isDark ? .white : .black)
                .frame(height: 3)
                .frame(maxWidth:.infinity)
                .edgesIgnoringSafeArea(.horizontal)
        }
     

        
//        VStack(alignment: .center, spacing: 8) {
//            HStack (spacing: 15){
//                if needImage {
//                    ZStack{
//                        imageview(url: imageUrl,width: 80,height: 80)
//                    }
//                    .background(isDark ? .black : .white)
//                    .cornerRadius(12)
//                }
//                HStack(spacing:40) {
//                    if needImage {
//                        VStack{
//                            Text(courseName)
//                                .font(
//                                    Font.custom(Fonts().getFontBold(), size: 14)
//                                        .weight(.bold)
//                                )
//                                .multilineTextAlignment(.center)
//                                .lineLimit(4)
//                                .foregroundColor(Color(red: 0.26, green: 0.25, blue: 0.69))
//                                .frame(width: 130, height: 60, alignment: .center)
//                            
//                            Text(lecturerName)
//                                .font(
//                                    Font.custom(Fonts().getFontBold(), size: 10)
//                                        .weight(.bold)
//                                )
//                                .multilineTextAlignment(.center)
//                                .lineLimit(4)
//                                .foregroundColor(Color(red: 0.26, green: 0.25, blue: 0.69))
//                                .frame(width: .infinity, height: 20, alignment: .center)
//                            
//                        }
//                        
//                    } else {
//                        HStack {
//                            Text(courseName)
//                                .font(
//                                    Font.custom(Fonts().getFontBold(), size: 14)
//                                        .weight(.bold)
//                                )
//                                .multilineTextAlignment(.center)
//                                .lineLimit(4)
//                                .foregroundColor(Color(red: 0.26, green: 0.25, blue: 0.69))
//                                .frame(width: 60, height: 60, alignment: .center)
//                            
//                            Text(lecturerName)
//                                .font(
//                                    Font.custom(Fonts().getFontBold(), size: 10)
//                                        .weight(.bold)
//                                )
//                                .multilineTextAlignment(.center)
//                                .lineLimit(4)
//                                .foregroundColor(Color(red: 0.26, green: 0.25, blue: 0.69))
//                                .frame(width: 60, height: 20, alignment: .center)
//                            
//                            
//                                    Text(coursePrice)
//                                        .font(
//                                            Font.custom(Fonts().getFontBold(), size: 14)
//                                                .weight(.bold)
//                                        )
//                                        .multilineTextAlignment(.center)
//                                        .lineLimit(4)
//                                        .foregroundColor(educationalCourseInOfferStatus ? .red : Color(red: 0.26, green: 0.25, blue: 0.69))
//                                        .frame(width: 60, height: 20, alignment: .center)
//
//                            
//                        }
//                    }
//                 
//                    if needImage {
//                        
//                        VStack(spacing:-5) {
//                            if educationalCourseInOfferStatus {
//                                Text(coursePriceInOffer)
//                                    .font(
//                                        Font.custom(Fonts().getFontBold(), size: 14)
//                                            .weight(.bold)
//                                    )
//                                    .multilineTextAlignment(.center)
//                                    .lineLimit(4)
//                                    .foregroundColor(Color(red: 0.26, green: 0.25, blue: 0.69))
//                                    .frame(width: .infinity, height: 20, alignment: .center)
//                                
//                            }
//                            
//                            ZStack(alignment: .center) {
//                                Text(coursePrice)
//                                    .font(
//                                        Font.custom(Fonts().getFontBold(), size: 14)
//                                            .weight(.bold)
//                                    )
//                                    .multilineTextAlignment(.center)
//                                    .lineLimit(4)
//                                    .foregroundColor(educationalCourseInOfferStatus ? .red : Color(red: 0.26, green: 0.25, blue: 0.69))
//                                    .frame(width: .infinity, height: 20, alignment: .center)
//                                if educationalCourseInOfferStatus {
//                                    Rectangle()
//                                        .frame(width:50,height: 1)
//                                        .foregroundColor(.black)
//                                }
//                            }
//                        }
//                    }
//                }
//                .frame(width: 250)
//            }
//            .frame(width: 250,alignment: .leading)
//        }
//        
//        .padding(.trailing, 46)
//        .frame(width: 350, alignment: .leading)
//        .background(isDark ? .black : .white)
//        .cornerRadius(12)
//        .shadow(color: isDark ? .white : .black.opacity(0.25), radius: 4, x: 0, y: 1)
    }
}


