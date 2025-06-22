//
//  StudentExamTabView.swift
//  FEDS-Center-Dev-IOS
//
//  Created by Mrwan on 30/05/2024.
//

import SwiftUI
import AxisTabView

import BottomSheetSwiftUI

@available(iOS 16.0, *)

struct StudentExamTabView: View {
    
    @State private var selection: Int = UserDefaultss().restoreInt(key: "selectedTag")
    @StateObject var genralVm : GeneralVm = GeneralVm()
    var body: some View {
        
        AxisTabView(selection: $selection, constant: ATConstant(axisMode: .bottom)) { state in
            ATMaterialStyle(state)
        }
    content: {
        
        CustomMenuAxisTab(tagAxisTab: 0
                          , keyAxisTab:  "selectedTag"
                          , titleAxisTab: "unFinished"
                          , imageName: "file-2") {
            StudentExamView(finishedExam: Constants().EXAM_SEARCH_STATUS_TYPE_CURRENT)
        }
        
          
        CustomMenuAxisTab(tagAxisTab: 1
                          , keyAxisTab:  "selectedTag"
                          , titleAxisTab: "finished"
                          , imageName: "complete") {
            StudentExamView(finishedExam: Constants().EXAM_SEARCH_STATUS_TYPE_FINISHED)
        }
        
        CustomMenuAxisTab(tagAxisTab: 2
                          , keyAxisTab:  "selectedTag"
                          , titleAxisTab: "all"
                          , imageName:"mark") {
            StudentExamView(finishedExam:"")
        }
    
        
        
    } onTapReceive: { selectionTap in }
          
            .ipad()
    }
    
}
