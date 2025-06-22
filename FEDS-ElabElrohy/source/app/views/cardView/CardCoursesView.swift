//
//  EducationCoursesCardView.swift
//  FPLS-Dev
//
//  Created by Omar pakr on 29/10/2023.
//

import SwiftUI

struct CardCoursesView: View {
    let needImage : Bool
    let imageUrl : String
    let courseName : String
    let lecturerName : String
    let educationCategory : String
    let chaptersCount :String
    let date : String
    let time : String
    let isDark = UserDefaultss().restoreBool(key: "isDark")
    var onClick: (() -> Void)?
    let constants = Constants()
    
    @State  var lang = Locale.current.language.languageCode!.identifier
   
    var body: some View {
        VStack{
            VStack(alignment: .center, spacing: 8) {
                ZStack {
                    // Background Image
                    CustomImageUrl(defaultImage: "course_default",
                                   url: imageUrl, width: UIScreen.main.bounds.width - 50, height: 250){
                        self.onClick?()
                    }
                        .aspectRatio(contentMode: .fit)
                        .clipped()
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .padding()
                        .frame(width: 250, height: 250)
               
                    VStack{
                        if !educationCategory.isEmpty || !lecturerName.isEmpty {
                            HStack {
                                HStack{
                                    if !educationCategory.isEmpty {
                                        Image("closed_book")
                                            .resizable()
                                            .frame(width: 33,height: 33)
                                            .padding(.top, 5 )
                                    }
                                    
                                    Text(educationCategory)
                                        .font(
                                            Font.custom(Fonts().getFontLight(), size: 18)
                                                .weight(.bold)
                                        )
                                        .multilineTextAlignment(.center)
                                        .lineLimit(1)
                                        .foregroundColor(isDark ? Color(Colors().darkCardText): Color(Colors().lightCardText))
                                        .frame(width: .infinity, height: .infinity, alignment: .center)
                                    
                                    
                                    Spacer()
                                    if !lecturerName.isEmpty {
                                        Image("lecture")
                                            .resizable()
                                            .frame(width: 33,height: 33)
                                            .padding(.top, 5)
                                            .padding(.bottom, 5)
                                    }
                                    Text(lecturerName)
                                        .font(
                                            Font.custom(Fonts().getFontLight(), size: 18)
                                                .weight(.bold)
                                        )
                                        .multilineTextAlignment(.center)
                                        .lineLimit(1)
                                        .foregroundColor(isDark ? Color(Colors().darkCardText): Color(Colors().lightCardText))
                                        .frame(width: .infinity, height: .infinity, alignment: .center)
                                    
                                }
                                .padding(.vertical, 5)
                                .padding(.horizontal, 10)
                                .frame(maxWidth:.infinity)
                                .frame(height:40)
                                .background(isDark ? Color(Colors().darkCardBgText): Color(Colors().lightCardBgText))
                                
                                
                            }
                            .frame(maxHeight:.infinity , alignment:.top)
                            .frame(width: UIScreen.main.bounds.width - 50)
                            
                        }
                        
                        VStack (spacing:-56){
                            
                            
                            HStack(spacing:40) {
                                VStack{
                                    Text(courseName)
                                        .font(
                                            Font.custom(Fonts().getFontBold(), size: 22)
                                                .weight(.bold)
                                        )
                                        .multilineTextAlignment(.center)
                                        .lineLimit(2)
                                        .foregroundColor(isDark ? Color(Colors().darkCardText): Color(Colors().lightCardText))
                                        .frame(width: 300, height: .infinity, alignment: .center)
                                        .padding(.vertical, 6)
                                }
                                .padding(.horizontal, 15)
                                .frame(maxWidth:.infinity)
                                .frame(height:40)
                                .background(isDark ? Color(Colors().darkCardBgText): Color(Colors().lightCardBgText))
                            }
                            .frame(maxHeight:.infinity , alignment:.bottom)
                            .frame(width: UIScreen.main.bounds.width - 50)
                        }
                    }
                    
                }
                
                .frame(width: UIScreen.main.bounds.width - 50)
            }
            .cornerRadius(12)
            .shadow(color: isDark ? Color.white : Color.gray, radius: 4, x: 0, y: 3)
            .frame(width: 350, height: 250)
            HStack {
                Text(date + " - " + time)
                    .font(
                        Font.custom(Fonts().getFontBold(), size: 14)
                            .weight(.light)
                    )
                    .multilineTextAlignment(.center)
                    .lineLimit(1)
                    .foregroundColor(isDark ? Color(Colors().darkBodyText) : Color(Colors().lightBodyText))
                    .frame(width: UIScreen.main.bounds.width - 50 , height: .infinity, alignment: .trailing)
                    .padding(.vertical, 3)
                    .padding(.trailing, 15)
      
                
//                Text(NSLocalizedString("chapterCount", comment: "") + " : " + chaptersCount)
//                    .font(
//                        Font.custom(Fonts().getFontBold(), size: 14)
//                            .weight(.light)
//                    )
//                    .multilineTextAlignment(.center)
//                    .lineLimit(1)
//                    .foregroundColor(isDark ? Color(Colors().darkBodyText) : Color(Colors().lightBodyText))
//                    .frame(width: UIScreen.main.bounds.width , height: .infinity, alignment: .trailing)
//                    .padding(.vertical, 3)
//                    .padding(.trailing, 15)
                
            }
            
            Divider()
                .frame(width: UIScreen.main.bounds.width - 50, height: 3)
                .background(Color.gray)
        }
        .onTapGesture {
            self.onClick?()
        }
    }
    
}

#Preview {
    CardCoursesView(needImage: true, imageUrl: "", courseName: "test", lecturerName: "mrwan", educationCategory: "test", chaptersCount: "12", date: "12/12/1234", time: "1231", onClick: {
        
    }, lang: "")
}
