//
//  ChooseQuestionType.swift
//  FPLS-Dev
//
//  Created by Omar pakr on 04/11/2023.
//

import SwiftUI

@available(iOS 16.0, *)
struct ChooseQuestionType: View {
    let constants = Constants()
    @State  var lang = Locale.current.language.languageCode!.identifier
    @State var isPresentedMCQ : Bool = false
    @State var isPresentedTrueFalse : Bool = false
    @State var backGeasture : Bool = false
    @State var examParagraphsInfoData : [ExamParagraphsInfoData] = []
    var educationGroupTimeToken = UserDefaultss().restoreString(key: "educationGroupTimeToken")
    var body: some View {
        NavigationView {
            VStack (spacing:30){
                HStack(alignment: .center, spacing: 5) {
                    
                    Button {
                      
                        isPresentedMCQ.toggle()
                    } label: {
                        Text(NSLocalizedString("trueFalse", comment: ""))
                            .font(
                                Font.custom(Fonts().getFontBold(), size: 15)
                                    .weight(.bold)
                                
                            )
                            .frame(width: 200)
                            
                            .foregroundColor(Color(red: 0.9, green: 0.88, blue: 0.91))
                    }

                }
                .multilineTextAlignment(.center)
                .lineLimit(2)
                .padding(.horizontal, 82)
                .padding(.vertical, 16)
                .frame(width: 234, height: 58, alignment: .center)
                .background(.cyan)
                .cornerRadius(10)
                
                
                HStack(alignment: .center, spacing: 5) {
                    
                    Button {
                        
                    } label: {
                        Text(NSLocalizedString("mcq", comment: ""))
                            .font(
                                Font.custom(Fonts().getFontBold(), size: 15)
                                    .weight(.bold)
                                
                            )
                            .frame(width: 200)
                            .foregroundColor(Color(red: 0.9, green: 0.88, blue: 0.91))
                    }
                    .fullScreenCover(isPresented: $isPresentedTrueFalse, content: StudentMainTabView.init)
                }
                .multilineTextAlignment(.center)
                .lineLimit(2)
                .padding(.horizontal, 82)
                .padding(.vertical, 16)
                .frame(width: 234, height: 58, alignment: .center)
                .background(.cyan)
                .cornerRadius(10)
            }
            .navigationBarItems(
                leading: HStack(spacing: 10){
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
                    self.backGeasture.toggle()
                }
            )
            .fullScreenCover(isPresented: $backGeasture , content: {
                StudentExamTabView()

            })
            .navigationTitle(NSLocalizedString("questionType", comment: ""))
        }
    }
}

//#Preview {
//    ChooseQuestionType()
//}
