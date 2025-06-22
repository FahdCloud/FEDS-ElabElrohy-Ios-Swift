//
//  EducationCoursesView.swift
//  FPLS-Dev
//
//  Created by Omar pakr on 17/10/2023.
//
import Foundation
import SwiftUI
import BottomSheetSwiftUI

@available(iOS 16.0, *)
struct OnlineContentView: View {
    @StateObject var educationCourseVm : EducationCourseVm = EducationCourseVm()
    @StateObject var genralVm : GeneralVm = GeneralVm()
    private let adaptiveColumns = [
        GridItem(.fixed(100))
    ]
    @Environment(\.refresh) private var refreshAction
    @Environment(\.presentationMode) var presentationMode
    
    @State private var isMyCoursesTab: Bool = false
    @State private var refresh: Bool = false
    @State private var dissapearView: Bool = false
    @State private var showLevelesFromOnlineContent: Bool = false
    @State private var showSheetWithBuy: Bool = false
    @State private var courseName: String = ""
    @State private var courseToken: String = ""
    @State private var coursePrice: String = ""
    @State private var courseImage: String = ""
    @State private var educationCategory: String = ""
    @State private var userProviderService: String = ""
    @State private var visualEffect  = VisualEffect.systemDark
    let switchablePositions: [BottomSheetPosition] = [.dynamic]
    
    @State private var toast: Toast? = nil
    let constants = Constants()
    
    var body: some View {
        NavigationStack {
            ZStack {
                if educationCourseVm.noData {
                    NoContent(message: educationCourseVm.msg)
                } else {
                    VStack {
                        ScrollView {
                            LazyVGrid(columns: adaptiveColumns,spacing: 10) {
                                ForEach(educationCourseVm.educationalCoursesData,id: \.educationalCourseToken) { course in
                                    CardCoursesView(needImage:true,
                                                    imageUrl: course.storageFileData?.thumbnailImageUrl ?? "",
                                                    courseName: course.educationalCourseNameCurrent ?? "",
                                                    lecturerName: course.userServiceProviderInfoData?.userNameCurrent ?? "",
                                                    educationCategory: course.educationalCategoryCustomInfoData?.educationalCategoryNameCurrent ?? "",
                                                    chaptersCount:"\(course.educationalCourseStatsticInfoData?.countChapters ?? 0)",
                                                    date: course.lastUpdateDate ?? "" ,
                                                    time: course.lastUpdateTime ?? "")
                                    {
                                        UserDefaults.standard.set(course.educationalCourseToken, forKey: "courseToken")
                                        clearStatesWithAction(valueState: &showLevelesFromOnlineContent)
                                    }
                                }
                                
                                if educationCourseVm.currentPage < educationCourseVm.totalPages {
                                    Text(NSLocalizedString("fetchMoreData", comment: ""))
                                        .onAppear {
                                            educationCourseVm.currentPage += 1
                                            educationCourseVm.paginated = true
                                            if (isMyCoursesTab){
                                                educationCourseVm.getMyCourses()
                                            }else{
                                                educationCourseVm.getCourses()
                                            }
                                        }
                                }
                            }
//                            .padding()
                        }
                    }
                }
            }
            .fullScreenCover(isPresented: $showLevelesFromOnlineContent, content: {
                CoursesInfoTapView()
            })
            
            .refreshable {
                educationCourseVm.currentPage = 1
                educationCourseVm.paginated = false
                if (isMyCoursesTab){
                    educationCourseVm.getMyCourses()
                }else{
                    educationCourseVm.getCourses()
                }
            }
            .fullScreenCover(isPresented: $educationCourseVm.showLogOut, content: {
                RegistrationView()
            })
           
//            .navigationTitle(NSLocalizedString("courses", comment: ""))
        }
        .overlay(
             educationCourseVm.isLoading ?
             GeometryReader { geometry in
                 ZStack {
                     LoadingView(placHolder: NSLocalizedString("loading", comment: ""))
                         .frame(width: geometry.size.width, height: geometry.size.height)
                         .transition(.scale)
                 } } : nil
         )
        

        .onAppear {
             isMyCoursesTab = UserDefaultss().restoreBool(key: "isMyCoursesTab")
            
            if (isMyCoursesTab){
                educationCourseVm.getMyCourses()
            }else{
                educationCourseVm.getCourses()
            }
        }
        
        .onDisappear(perform: {
            clearStatesWithAction(valueState: &dissapearView)
     })
        .toastView(toast: $toast)
        .ipad()
        .background(genralVm.isDark ? Color(Colors().darkBodyBg): Color(Colors().lightBodyBg))
        
        
        
    }
    private func clearStatesWithAction(valueState: inout Bool) {
        valueState.toggle()
        educationCourseVm.showLogOut = false
        showLevelesFromOnlineContent = false
      }
}

