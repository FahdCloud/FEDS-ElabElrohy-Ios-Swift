//
//  TabBar.swift
//  FPLS-Dev
//
//  Created by Omar pakr on 04/09/2023.
//

import SwiftUI
import AxisTabView

@available(iOS 16.0, *)

struct LecturersHomeView: View {
    @StateObject var genralVm : GeneralVm = GeneralVm()

    @State private var selection: Int = UserDefaultss().restoreInt(key: "lectureHomeTag")
    let userTypeToken  = UserDefaultss().restoreString(key: "userTypeToken")
 
    var body: some View {
       
            AxisTabView(selection: $selection, constant: ATConstant(axisMode: .bottom)) { state in
                ATMaterialStyle(state)
            }
    content: {
        if ((genralVm.havePermissionToView && genralVm.userTypeToken == genralVm.constants.USER_TYPE_TOKEN_STUDENT )
            || genralVm.userTypeToken == genralVm.constants.USER_TYPE_TOKEN_FAMILY) {
            
            CustomMenuAxisTab(tagAxisTab: 0
                              , keyAxisTab:  "lectureHomeTag"
                              , titleAxisTab: "courses",
                              imageName: "tab_courses") {
                CoursesTabView()
            }
        }
        
        CustomMenuAxisTab(tagAxisTab: 1
                          , keyAxisTab:  "lectureHomeTag"
                          , titleAxisTab: "groups"
                          , imageName: "group2") {
            LecturerGroupsView(isFinished: false)
        } 
        
        CustomMenuAxisTab(tagAxisTab: 2
                          , keyAxisTab:  "lectureHomeTag"
                          , titleAxisTab: "scheduleTimes"
                          , imageName: "schedule2") {
            QuestionView()
        }
        
        if ((genralVm.havePermissionToView && genralVm.userTypeToken == genralVm.constants.USER_TYPE_TOKEN_STUDENT )
            || genralVm.userTypeToken == genralVm.constants.USER_TYPE_TOKEN_FAMILY) {
            
            CustomMenuAxisTab(tagAxisTab: 3
                              , keyAxisTab:  "lectureHomeTag"
                              , titleAxisTab: "codeee"
                              , imageName: "code2") {
                LecturerCodesView()
            }
        }
      
        } onTapReceive: { selectionTap in }
                .ipad()
    }
    
}
