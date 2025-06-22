//
//  TabBar.swift
//  FPLS-Dev
//
//  Created by Omar pakr on 04/09/2023.
//

import SwiftUI
import AxisTabView

@available(iOS 16.0, *)

struct CatergoriesHomeView: View {
    @StateObject var genralVm : GeneralVm = GeneralVm()
    @State private var selection: Int = UserDefaultss().restoreInt(key: "categoriesHomeTag")
    
    var body: some View {
       
            AxisTabView(selection: $selection, constant: ATConstant(axisMode: .bottom)) { state in
                ATMaterialStyle(state)
            }
    content: {
        
        if ((genralVm.havePermissionToView && genralVm.userTypeToken == genralVm.constants.USER_TYPE_TOKEN_STUDENT )
            || genralVm.userTypeToken == genralVm.constants.USER_TYPE_TOKEN_FAMILY) {
            
            CustomMenuAxisTab(tagAxisTab: 0
                              , keyAxisTab:  "categoriesHomeTag"
                              , titleAxisTab: "courses",
                              imageName: "tab_courses") {
                CoursesTabView()
            }
        }
        if AppConstantStatus.isAppNotForLecture {
            CustomMenuAxisTab(tagAxisTab: 1
                              , keyAxisTab:  "categoriesHomeTag"
                              , titleAxisTab: "teachers",
                              imageName: "lecturer_icon") {
                CategoriesLecturersView()
            }
        }
        CustomMenuAxisTab(tagAxisTab: 2
                          , keyAxisTab:  "categoriesHomeTag"
                          , titleAxisTab: "groups",
                          imageName: "group2") {
            CategoriesGroupsView( isFinished: false)
        }
        
//        CustomMenuAxisTab(tagAxisTab: 3
//                          , keyAxisTab:  "categoriesHomeTag"
//                          , titleAxisTab: "scheduleTimes",
//                          imageName: "schedule2") {
//            QuestionView()
//        }
        } onTapReceive: { selectionTap in }
                .ipad()
    }
}
