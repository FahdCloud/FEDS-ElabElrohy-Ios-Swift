//
//  TabBar.swift
//  FPLS-Dev
//
//  Created by Omar pakr on 04/09/2023.
//

import SwiftUI
import AxisTabView

@available(iOS 16.0, *)

struct CategoriesLecturersHomeView: View {
    @StateObject var genralVm : GeneralVm = GeneralVm()

    @State private var selection: Int = UserDefaultss().restoreInt(key: "categoriesLectureHomeTag")
    
    var body: some View {
       
            AxisTabView(selection: $selection, constant: ATConstant(axisMode: .bottom)) { state in
                ATMaterialStyle(state)
            }
    content: {
        
        if ((genralVm.havePermissionToView && genralVm.userTypeToken == genralVm.constants.USER_TYPE_TOKEN_STUDENT )
            || genralVm.userTypeToken == genralVm.constants.USER_TYPE_TOKEN_FAMILY) {
            
            CustomMenuAxisTab(tagAxisTab: 0
                              , keyAxisTab:  "categoriesLectureHomeTag"
                              , titleAxisTab: "courses",
                              imageName: "tab_courses") {
                CoursesTabView()
            }
        }
        CustomMenuAxisTab(tagAxisTab: 1
                          , keyAxisTab:  "categoriesLectureHomeTag"
                          , titleAxisTab: "groups",
                          imageName: "group2") {
            CategoriesLecturersGroupsView(isFinished: false)
        }
//        CustomMenuAxisTab(tagAxisTab: 2
//                          , keyAxisTab:  "categoriesLectureHomeTag"
//                          , titleAxisTab: "scheduleTimes",
//                          imageName: "schedule2") {
//            QuestionView()
//        }
        if ((genralVm.havePermissionToView && genralVm.userTypeToken == genralVm.constants.USER_TYPE_TOKEN_STUDENT )
            || genralVm.userTypeToken == genralVm.constants.USER_TYPE_TOKEN_FAMILY) {
            CustomMenuAxisTab(tagAxisTab: 3
                              , keyAxisTab:  "categoriesLectureHomeTag"
                              , titleAxisTab: "codeee",
                              imageName: "code2") {
                CategoriesLecturersCodesView()
            }
        }
       
        } onTapReceive: { selectionTap in }
                .ipad()
    }
}
