//
//  TabBar.swift
//  FPLS-Dev
//
//  Created by Omar pakr on 04/09/2023.
//

import SwiftUI
import AxisTabView

import BottomSheetSwiftUI

@available(iOS 16.0, *)

struct StudentMainTabView: View {
    
    @State private var selection: Int = UserDefaultss().restoreInt(key: "selectedTag")
    @StateObject var genralVm : GeneralVm = GeneralVm()
    
    var body: some View {
        
        AxisTabView(selection: $selection, constant: ATConstant(axisMode: .bottom)) { state in
            ATMaterialStyle(state)
        }
    content: {
        CustomMenuAxisTab(tagAxisTab: 0
                          , keyAxisTab:  "selectedTag"
                          , titleAxisTab: "myAccount"
                          , imageName: "tab_student") {
            StudentHome()
        }
        
        
        if ((genralVm.havePermissionToView && genralVm.userTypeToken == genralVm.constants.USER_TYPE_TOKEN_STUDENT )
            || genralVm.userTypeToken == genralVm.constants.USER_TYPE_TOKEN_FAMILY) {
            

            CustomMenuAxisTab(tagAxisTab: 1
                              , keyAxisTab:  "selectedTag"
                              , titleAxisTab: "courses",
                              imageName: "tab_courses") {
                CoursesTabView()
                
            }
        }
        
        
        CustomMenuAxisTab(tagAxisTab: 2
                          , keyAxisTab:  "selectedTag"
                          , titleAxisTab: "educational"
                          , imageName: "open_book") {
            HomePageView()
        }
        
        
        CustomMenuAxisTab(tagAxisTab: 3
                          , keyAxisTab:  "selectedTag"
                          , titleAxisTab: "more"
                          , imageName: "tab_more") {
            MoreView()
        }
        
    } onTapReceive: {selectionTap in
        
    }
        .ipad()
    }
    
    
    
}
