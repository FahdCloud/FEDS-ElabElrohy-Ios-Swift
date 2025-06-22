//
//  WarningsView.swift
//  FPLS-Dev
//
//  Created by Omar pakr on 25/10/2023.
//

import SwiftUI





struct WarningsView: View {
    var attendanceData = AttendanceStudentWarningData()
    let lang  = Locale.current.language.languageCode!.identifier
    @Binding var dismiss : Bool
    @State var warning1 : String = "Omar pakrnnnn"
    @State var warning2 : String = ""
    @State var warning3 : String = ""
    @State var warning4 : String = ""
    @State var warning5 : String = ""
    @State var showPassword : Bool = false

    var body: some View {
        
          
            VStack{
                
                bottomView
                
            }
            .frame(width: 300, height: .infinity)

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
    
 
    var bottomView : some View {
        VStack(spacing: 10){
            
            HStack {
                
                Button {
                    self.dismiss.toggle()

                } label: {
                    Image(systemName: "xmark")
                    
                }
            
                    HStack{
                        Image("warning")
                        
                        if attendanceData == nil {
                            
                            Text(NSLocalizedString("warnings", comment: "") + "  " + DateTime.replaceCharcaterInTime(language: self.lang, value: "0"))
                                .font(
                                    Font.custom(Fonts().getFontBold(), size: 12)
                                        .weight(.bold)
                                )
                        } else {
                            Text(NSLocalizedString("warnings", comment: "") + "  " + DateTime.replaceCharcaterInTime(language: self.lang, value: (attendanceData.countWarningText ?? "")))
                                .font(
                                    Font.custom(Fonts().getFontBold(), size: 12)
                                        .weight(.bold)
                                )

                        }
                    }
                
            }
            if attendanceData.warningStatus1 ?? false {
                TextField("", text: $warning1)
                .disabled(true)
                    
                    .textFieldStyle(
                        CustomTextFieldStyle(placeholder: NSLocalizedString("warning1", comment: ""), placeholderColor: .black, placeholderBgColor: Color(Colors().greenColor.cgColor),image: "", isPassword: false, isEditing: !self.warning1.isEmpty, isTapped: $showPassword)
                    )
                
                    
            }
         
            if attendanceData.warningStatus2 ?? false {
                
                TextField("", text: $warning2)
                .disabled(true)
                    .textFieldStyle(
                        CustomTextFieldStyle(placeholder: NSLocalizedString("warning2", comment: ""), placeholderColor: .black, placeholderBgColor: Color(Colors().greenColor.cgColor),image: "", isPassword: false, isEditing: !self.warning2.isEmpty, isTapped: $showPassword)
                    )
            }
            
            if attendanceData.warningStatus3 ?? false {
                TextField("", text: $warning3)
                .disabled(true)
                    .textFieldStyle(
                        CustomTextFieldStyle(placeholder: NSLocalizedString("warning3", comment: ""), placeholderColor: .black, placeholderBgColor: Color(Colors().greenColor.cgColor),image: "", isPassword: false, isEditing: !self.warning3.isEmpty, isTapped: $showPassword)
                    )
                
            }
            
            if attendanceData.warningStatus4 ??  false{
                
                TextField("", text: $warning4)
                .disabled(true)
                    .textFieldStyle(
                        CustomTextFieldStyle(placeholder: NSLocalizedString("warning4", comment: ""), placeholderColor: .black, placeholderBgColor: Color(Colors().greenColor.cgColor),image: "", isPassword: false, isEditing: !self.warning4.isEmpty, isTapped: $showPassword)
                    )
                
                
            }
            if attendanceData.warningStatus5 ?? false {
                TextField("", text: $warning5)
                .disabled(true)
                    .textFieldStyle(
                        CustomTextFieldStyle(placeholder: NSLocalizedString("warning5", comment: ""), placeholderColor: .black, placeholderBgColor: Color(Colors().greenColor.cgColor),image: "", isPassword: false, isEditing: !self.warning5.isEmpty, isTapped: $showPassword)
                    )
                
            }
        }
        .onAppear {
            self.warning1 = attendanceData.warningNotes1 ?? ""
            self.warning2 = attendanceData.warningNotes2 ?? ""
            self.warning3 = attendanceData.warningNotes3 ?? ""
            self.warning4 = attendanceData.warningNotes4 ?? ""
            self.warning5 = attendanceData.warningNotes5 ?? ""
        }
    }
}


