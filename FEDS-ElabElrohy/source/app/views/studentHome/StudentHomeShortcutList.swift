//
//  TopListView.swift
//  FPLS-Dev
//
//  Created by Omar pakr on 04/09/2023.
//

import SwiftUI

@available(iOS 16.0, *)
struct StudentHomeShortcutList: View {
    
    @StateObject var shortcutListVm : StudentHomeShortcutListVm = StudentHomeShortcutListVm()
    @StateObject var genralVm : GeneralVm = GeneralVm()
    
    let row = GridItem(.fixed(50), spacing: 5, alignment: .center)
    @State private var showAttendanceFromStudentHome : Bool = false
    @State private var isPresentDebts : Bool = false
    @State private var isPresentJoiningApps : Bool = false
    @State private var isPresentJoiningAppsSubscription : Bool = false
    @State private var isPresentServiceSubscription : Bool = false
    @State private var showGroupsFromStudentHome : Bool = false
    @State private var showMyExamsFromStudentHome : Bool = false
    @State private var isPresentNews : Bool = false
    @State private var showMyOnlineContentFromStudentHome : Bool = false
    @State private var isPresentCodes : Bool = false
    @State private var showMyAttatchmentsFromStudentHome : Bool = false
    @State private var showMyHomeWorksFromStudentHome : Bool = false
    
    
    var body: some View {
        
        
        ScrollView(.horizontal,showsIndicators: false) {
            LazyHGrid(rows: [row]) {
                ForEach(shortcutListVm.shortcutList) { shortcutModel in
                    HStack (spacing : 20){
                        
                        Image(shortcutModel.image)
                            .resizable()
                            .frame(width: 20)
                            .clipShape(Circle())
                        
                        
                        Text("\(shortcutModel.name)")
                            .foregroundColor(genralVm.isDark ? Color(Colors().darkCardText): Color(Colors().lightCardText))
                        
                    }
                    .onTapGesture {
                        if shortcutModel.route == "attendanceHistory" {
                            showAttendanceFromStudentHome.toggle()
                        } else if shortcutModel.route == "debtsHistory" {
                            isPresentDebts.toggle()
                        } else if shortcutModel.route == "joiningApplication" {
                            isPresentJoiningApps.toggle()
                        } else if shortcutModel.route == "joiningAppSubscription" {
                            isPresentJoiningAppsSubscription.toggle()
                        } else if shortcutModel.route == "serviceSubscription" {
                            isPresentServiceSubscription.toggle()
                        } else if shortcutModel.route == "myGroups" {
                            showGroupsFromStudentHome.toggle()
                        } else if shortcutModel.route == "myExams" {
                            UserDefaultss().removeObject(forKey: "educationalGroupScheduleTimeToken")
                            showMyExamsFromStudentHome.toggle()
                        } else if shortcutModel.route == "myHw" {
                            UserDefaultss().removeObject(forKey: "educationalGroupScheduleTimeToken")
                            showMyHomeWorksFromStudentHome.toggle()
                        } else if shortcutModel.route == "news" {
                            isPresentNews.toggle()
                        }  else if shortcutModel.route == "codes" {
                            isPresentCodes.toggle()
                        } else if shortcutModel.route == "myCourses" {
                            UserDefaultss().saveStrings(value: genralVm.constants.ROUTE_FROM_MY_COURSES, key: genralVm.constants.KEY_ROUTE_COURSES)
                            showMyOnlineContentFromStudentHome.toggle()
                        } else if shortcutModel.route == "myMedia" {
                            showMyAttatchmentsFromStudentHome.toggle()
                        }
                    }
                    
                    .padding()
                    .ipad()
                    .background(genralVm.isDark ? Color(Colors().darkBtnMenu) : Color(Colors().lightBtnMenu))
                    
                    .cornerRadius(15)
                }
            }
        }
        .padding()

        .fullScreenCover(isPresented: $showMyAttatchmentsFromStudentHome, content: {
            AttatchmentsView(groupTimeToken: "")
                .environmentObject(ScreenshotDetector())
                .environmentObject(ScreenRecordingDetector())
        })
        .fullScreenCover(isPresented: $showAttendanceFromStudentHome, content: {
            EducationAttendnaceHistoryView()
        })
        .fullScreenCover(isPresented: $showGroupsFromStudentHome, content: {
            StudentGroupsTabView()
        })
        .fullScreenCover(isPresented: $showMyOnlineContentFromStudentHome, content: {
            NavigationStack{
                
                CoursesTabView()
            }
        })
        .fullScreenCover(isPresented: $isPresentCodes, content: {
            MyCodesView(isFromMore: false)
        })
        .fullScreenCover(isPresented: $showMyHomeWorksFromStudentHome, content: {
            StudentHomeworkTbaview()
            
        })
        .fullScreenCover(isPresented: $showMyExamsFromStudentHome, content: {
            StudentExamTabView()
            
        })
        .onDisappear(perform: {
            clearStatesWithAction(valueState: &genralVm.dissapearView)
        })
        
    }
    
    private func clearStatesWithAction(valueState: inout Bool) {
        valueState.toggle()
        showMyExamsFromStudentHome = false
        showMyHomeWorksFromStudentHome = false
        isPresentCodes = false
        showMyOnlineContentFromStudentHome = false
        showGroupsFromStudentHome = false
        showAttendanceFromStudentHome = false
        showMyAttatchmentsFromStudentHome = false
        
    }
}

