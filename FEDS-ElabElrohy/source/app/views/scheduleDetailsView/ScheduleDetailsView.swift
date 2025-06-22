//
//  ScheduleDetailsView.swift
//  FPLS-Dev
//
//  Created by Omar pakr on 23/09/2023.
//

import SwiftUI

@available(iOS 16.0, *)
struct ScheduleDetailsView: View {
    var placHolder : String
    var scheduleDetails = EducationalSchuldeTimes()
    let categoryName : String = UserDefaultss().restoreString(key: "educationCategoryName")
    let lang  = Locale.current.language.languageCode!.identifier
    @Binding var dismiss : Bool
    @State var warning1 : String = "Omar pakrnnnn"
    @State var warning2 : String = ""
    @State var warning3 : String = ""
    @State var warning4 : String = ""
    @State var warning5 : String = ""
    @State var showPassword : Bool = false
    @State var showMedia : Bool = false
    @State var showExams : Bool = false

    var body: some View {
        
//        VStack(spacing: 28) {
          
            VStack{
                
                mainData
                
                otherData
                
                bottomView
                
            }
            .frame(width: 300, height: .infinity)
//
//
//        }
        
        .padding(.vertical,25)
        .padding(.horizontal,35)
        .background(
            Color(Colors().greenColor.cgColor)
        )
        .background(BlurView())
        .cornerRadius(20)
        .frame(maxWidth: .infinity,maxHeight: .infinity)
        .background(
            Color.primary.opacity(0.35)
        )
    }
    
    var mainData : some View {
        VStack{
            HStack{
                Image("clocc")
                

                Text(scheduleDetails.durationCurrent != "" ? NSLocalizedString("duration", comment: "") + " : " + (scheduleDetails.durationCurrent ?? "") : NSLocalizedString("notFound", comment: ""))
                    .font(
                    Font.custom(Fonts().getFontBold(), size: 12)
                    .weight(.bold)
                    )
                    .multilineTextAlignment(.trailing)
                    .foregroundColor(Color(red: 0.9, green: 0.88, blue: 0.91))
                Spacer()
                
                Button {
                    self.dismiss.toggle()

                } label: {
                    Image(systemName: "xmark")
                    
                }

            }
            
            Divider()
            
            HStack{
                Image("paper")
        
                Text(self.categoryName != "" ? NSLocalizedString("educationCategory", comment: "") + " : " + (self.categoryName) : NSLocalizedString("notFound", comment: ""))
                    .font(
                    Font.custom(Fonts().getFontBold(), size: 12)
                    .weight(.bold)
                    )
                    .multilineTextAlignment(.trailing)
                    .foregroundColor(Color(red: 0.9, green: 0.88, blue: 0.91))
                Spacer()
                Button {
                    
                } label: {
                    Image(systemName: "zoom")
                    
                }

            }
            
            Divider()
            
            HStack{
                Image("teacher")
     
                Text(scheduleDetails.userServiceProviderInfoData?.userNameCurrent != "" ? NSLocalizedString("instructor", comment: "") + " : " + (scheduleDetails.userServiceProviderInfoData?.userNameCurrent ?? "") : NSLocalizedString("notFound", comment: ""))
                
                
                    .font(
                    Font.custom(Fonts().getFontBold(), size: 12)
                    .weight(.bold)
                    )
                    .multilineTextAlignment(.trailing)
                    .foregroundColor(Color(red: 0.9, green: 0.88, blue: 0.91))
                Spacer()
             
            }
            
            Divider()
            
            HStack{
                Image("attend")
         
                
                Text(scheduleDetails.attendanceTypeNameCurrent != "" ? NSLocalizedString("attendanceStatus", comment: "") + " : " + (scheduleDetails.attendanceTypeNameCurrent ?? "") : NSLocalizedString("notFound", comment: ""))
                    .font(
                    Font.custom(Fonts().getFontBold(), size: 12)
                    .weight(.bold)
                    )
                    .multilineTextAlignment(.trailing)
                    .foregroundColor(Color(red: 0.9, green: 0.88, blue: 0.91))
                Spacer()

            }
            
            Divider()
            
        }
    }
    
    var otherData : some View {
        VStack{
            HStack{
                
                Image("location")
                
                Text(scheduleDetails.placeInfoData?.placeNameCurrent != "" ? NSLocalizedString("location", comment: "") + " : " + (scheduleDetails.placeInfoData?.placeNameCurrent ?? "") : NSLocalizedString("notFound", comment: ""))
                    .font(
                    Font.custom(Fonts().getFontBold(), size: 12)
                    .weight(.bold)
                    )
                    .multilineTextAlignment(.trailing)
                    .foregroundColor(Color(red: 0.9, green: 0.88, blue: 0.91))
                Spacer()
                
            }
            
            Divider()
            
            HStack(spacing: 50){
                
                
                HStack(alignment: .top, spacing:-5) {
                    Image("folder 1")
                    
              
                    Text(NSLocalizedString("mediaa", comment: ""))
                      .font(
                        Font.custom(Fonts().getFontBold(), size: 12)
                          .weight(.bold)
                      )
                      .multilineTextAlignment(.trailing)
                      .foregroundColor(Color(red: 0.38, green: 0.36, blue: 0.39))
                      .frame(width: 52, height: 16, alignment: .topTrailing)
                    
                }
                .onTapGesture(perform: {
                    showMedia.toggle()
                })
                .padding(.leading, 12)
                .padding(.trailing, 6)
                .padding(.vertical, 10)
                .frame(width: 84, height: 36, alignment: .topTrailing)
                .background(Color(red: 0.79, green: 0.77, blue: 0.8))
                .cornerRadius(6)
                
                HStack(alignment: .top, spacing: -5) {
                    Image("homework")
                    
                    Text(NSLocalizedString("homework", comment: ""))
                      .font(
                        Font.custom(Fonts().getFontBold(), size: 12)
                          .weight(.bold)
                      )
                      .multilineTextAlignment(.trailing)
                      .foregroundColor(Color(red: 0.38, green: 0.36, blue: 0.39))
                      .frame(width: 46, height: 16, alignment: .topTrailing)
                }
                .onTapGesture(perform: {
                    UserDefaultss().saveStrings(value: scheduleDetails.educationalGroupScheduleTimeToken ?? "" , key: "educationalGroupScheduleTimeToken")
                    showExams.toggle()
                })
                .padding(.leading, 12)
                .padding(.trailing, 6)
                .padding(.vertical, 10)
                .frame(width: 84, height: 36, alignment: .topTrailing)
                .background(Color(red: 0.79, green: 0.77, blue: 0.8))
                .cornerRadius(6)
             Spacer()
            }
            .fullScreenCover(isPresented: $showMedia) {
                EducationGroupTimesMediaView(groupTimeToken: scheduleDetails.educationalGroupScheduleTimeToken ?? "", groupToken: "")
                    .environmentObject(ScreenshotDetector())
                    .environmentObject(ScreenRecordingDetector())
            }
            .fullScreenCover(isPresented: $showExams) {
                StudentExamTabView()
            }
            
            Divider()
            
        }
    }
    
    var bottomView : some View {
        VStack(spacing: 10){
            
            HStack {
                HStack {
                    Image("rates")
                    
                    Text(NSLocalizedString("rate", comment: ""))
                        .font(
                          Font.custom(Fonts().getFontBold(), size: 12)
                            .weight(.bold)
                        )
                    
                    Text(Helper.formateDouble(rate: scheduleDetails.attendanceRate ?? 0.0))
                        .font(
                          Font.custom(Fonts().getFontBold(), size: 12)
                            .weight(.bold)
                        )
                    
                    Spacer()
                    
                    HStack{
                        Image("warning")
                        
                        if scheduleDetails.attendanceStudentWarningData == nil {
                            
                            Text(NSLocalizedString("warnings", comment: "") + "  " + DateTime.replaceCharcaterInTime(language: self.lang, value: "0"))
                                .font(
                                    Font.custom(Fonts().getFontBold(), size: 12)
                                        .weight(.bold)
                                )
                        } else {
                            Text(NSLocalizedString("warnings", comment: "") + "  " + DateTime.replaceCharcaterInTime(language: self.lang, value: (scheduleDetails.attendanceStudentWarningData?.countWarningText ?? "")))
                                .font(
                                    Font.custom(Fonts().getFontBold(), size: 12)
                                        .weight(.bold)
                                )

                        }
                    }
                }
            }
            if scheduleDetails.attendanceStudentWarningData?.warningStatus1 ?? false {
                TextField("", text: $warning1)
                .disabled(true)
                    
                    .textFieldStyle(
                        CustomTextFieldStyle(placeholder: NSLocalizedString("warning1", comment: ""), placeholderColor: .black, placeholderBgColor: Color(Colors().greenColor.cgColor),image: "", isPassword: false, isEditing: !self.warning1.isEmpty, isTapped: $showPassword)
                    )
                
                    
            }
         
            if scheduleDetails.attendanceStudentWarningData?.warningStatus2 ?? false {
                
                TextField("", text: $warning2)
                .disabled(true)
                    .textFieldStyle(
                        CustomTextFieldStyle(placeholder: NSLocalizedString("warning2", comment: ""), placeholderColor: .black, placeholderBgColor: Color(Colors().greenColor.cgColor),image: "", isPassword: false, isEditing: !self.warning2.isEmpty, isTapped: $showPassword)
                    )
            }
            
            if scheduleDetails.attendanceStudentWarningData?.warningStatus3 ?? false {
                TextField("", text: $warning3)
                .disabled(true)
                    .textFieldStyle(
                        CustomTextFieldStyle(placeholder: NSLocalizedString("warning3", comment: ""), placeholderColor: .black, placeholderBgColor: Color(Colors().greenColor.cgColor),image: "", isPassword: false, isEditing: !self.warning3.isEmpty, isTapped: $showPassword)
                    )
                
            }
            
            if scheduleDetails.attendanceStudentWarningData?.warningStatus4 ??  false{
                
                TextField("", text: $warning4)
                .disabled(true)
                    .textFieldStyle(
                        CustomTextFieldStyle(placeholder: NSLocalizedString("warning4", comment: ""), placeholderColor: .black, placeholderBgColor: Color(Colors().greenColor.cgColor),image: "", isPassword: false, isEditing: !self.warning4.isEmpty, isTapped: $showPassword)
                    )
                
                
            }
            if scheduleDetails.attendanceStudentWarningData?.warningStatus5 ?? false {
                TextField("", text: $warning5)
                .disabled(true)
                    .textFieldStyle(
                        CustomTextFieldStyle(placeholder: NSLocalizedString("warning5", comment: ""), placeholderColor: .black, placeholderBgColor: Color(Colors().greenColor.cgColor),image: "", isPassword: false, isEditing: !self.warning5.isEmpty, isTapped: $showPassword)
                    )
                
            }
        }
        .onAppear {
            self.warning1 = scheduleDetails.attendanceStudentWarningData?.warningNotes1 ?? ""
            self.warning2 = scheduleDetails.attendanceStudentWarningData?.warningNotes2 ?? ""
            self.warning3 = scheduleDetails.attendanceStudentWarningData?.warningNotes3 ?? ""
            self.warning4 = scheduleDetails.attendanceStudentWarningData?.warningNotes4 ?? ""
            self.warning5 = scheduleDetails.attendanceStudentWarningData?.warningNotes5 ?? ""
        }
    }
}

//struct ScheduleDetailsView_Previews: PreviewProvider {
//    static var previews: some View {
//        ScheduleDetailsView(placHolder: "tt",dismiss: .constant(false))
//    }
//}
