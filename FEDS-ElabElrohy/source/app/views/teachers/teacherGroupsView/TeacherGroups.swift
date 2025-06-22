//
//  TeacherGroups.swift
//  FPLS-Dev
//
//  Created by Omar pakr on 27/11/2023.
//

import SwiftUI

@available(iOS 16.0, *)
struct TeacherGroups: View {
    @StateObject var teacherGroupsVm : TeacherGroupsVm = TeacherGroupsVm()
    @StateObject var genralVm : GeneralVm = GeneralVm()

    @State private var backFromTeacherGroups : Bool = false
    @State private var showHome : Bool = false
    @State private var showMedia : Bool = false
    @State private var showExams : Bool = false
    @State private var showingActionSheet : Bool = false
    
    @State var teacherGroupName : String = ""
    @State var teacherGroupToken : String = ""
    var userProviderToken = UserDefaultss().restoreString(key: "userProviderToken")
    @StateObject var topListViewModel : TopViewCategoryVm = TopViewCategoryVm()
    @StateObject var educationalGroupsVm : EducationalGroupsVm = EducationalGroupsVm()
    
    let row = GridItem(.fixed(50), spacing: 5, alignment: .center)
    @State private var selectedToken: String? = nil
    
    var body: some View {
        ZStack {
            NavigationView {
                ZStack  {
                    if teacherGroupsVm.noData {
                        VStack (spacing : -10){
                            TopViewCategoryView()
                            NoContent(message: teacherGroupsVm.msg)
                            Spacer(minLength: -50) // Negative space
                        }
                    } else {
                        VStack (spacing : -10){
                            ScrollView(.horizontal,showsIndicators: false) {
                                LazyHGrid(rows: [row]) {
                                    ForEach(topListViewModel.userEducationalCategoryInfoInterest ,id: \.educationalCategoryToken) { top in
                                        HStack {
                                            
                                            CustomImageUrl(url: top.educationalCategoryThumbnailImageUrl ?? "")
                                            
                                                .frame(width: 20)
                                                .clipShape(Circle())
                                            
                                            Text("\(top.educationalCategoryNameCurrent ?? "")")
                                                .foregroundColor(Color(red: 0.18, green: 0.16, blue: 0.62))
                                            
                                        }
                                        .onTapGesture {
                                            selectedToken = top.educationalCategoryToken ?? ""
                                            teacherGroupsVm.getAllTeachersGroups(userServiceProviderToken: self.userProviderToken,categoryToken:top.educationalCategoryToken ?? "")
                                            
                                        }
                                        .padding()
                                        .background(selectedToken == top.educationalCategoryToken ? Color.yellow : Color(red: 0.88, green: 0.87, blue: 1))
                                        .cornerRadius(30)
                                    }
                                    
                                }
                                .onAppear {
                                    topListViewModel.getUserDetails(userToken: self.userProviderToken)
                                }
                            }
                            .frame(height: 100)
                            .padding()
                            
                            List {
                                ForEach(teacherGroupsVm.educationGroupsData,id:\.educationalGroupToken) { group in
                                    HStack (spacing:-25){
                                        
                                        VStack {
                                            HStack (spacing :50) {
                                                //                                                imageview(url: group.educationalCategoryInfoData?.educationalCategoryImageUrl ?? "")
                                                
                                                Text(group.educationalGroupNameCurrent ?? "")
                                                    .frame(width: 280)
                                                
                                                //                                                Text(group.educationalCategoryInfoData?.educationalCategoryNameCurrent ?? "")
                                            }
                                            .frame(width: 400, alignment: .center)
                                            .font(
                                                Font.custom(Fonts().getFontBold(), size: 14)
                                                    .weight(.bold)
                                            )
                                            .lineLimit(4)
                                            .multilineTextAlignment(.center)
                                            
                                            
                                            VStack (spacing : 20){
                                                
                                                //                                                HStack (spacing :50) {
                                                //
                                                //                                                    Text(NSLocalizedString("packagePrice", comment: "") + " : " + (group.priceListData?.priceListPackagePriceForClientWithCurrency ?? ""))
                                                //
                                                //                                                    Text(NSLocalizedString("sessionPrice", comment: "") + " : " + (group.priceListData?.actualSessionPriceForClientWithCurrency ?? ""))
                                                //
                                                //
                                                //
                                                //                                                        .frame(width: 110)
                                                //                                                }
                                                //                                                .frame(width: 400, alignment: .center)
                                                //                                                .font(
                                                //                                                    Font.custom(Fonts().getFontBold(), size: 14)
                                                //                                                        .weight(.bold)
                                                //                                                )
                                                //                                                .lineLimit(4)
                                                //                                                .multilineTextAlignment(.center)
                                                
                                                HStack (spacing :80) {
                                                    Text(NSLocalizedString("from", comment: "") + " : " + (group.educationalGroupStatisticsInfoData?.educationalGroupStartDate ?? ""))
                                                    Text(NSLocalizedString("to", comment: "") + " : " + (group.educationalGroupStatisticsInfoData?.educationalGroupEndDate ?? ""))
                                                    
                                                    //                                                Text(group.educationalGroupInfoData?.educationalGroupStatisticsInfoData?.educationalGroupEndDate ?? "")
                                                    
                                                }
                                                .frame(width: 400, alignment: .center)
                                                .font(
                                                    Font.custom(Fonts().getFontBold(), size: 14)
                                                        .weight(.bold)
                                                )
                                                .lineLimit(4)
                                                .multilineTextAlignment(.center)
                                                
                                            }
                                            
                                        }
                                        .frame(width: .infinity, alignment: .leading)
                                        
                                    }
                                    .frame(maxWidth : .infinity,alignment:.center)
                                    .frame(width: 500 )
                                    .onTapGesture {
                                        self.teacherGroupToken = group.educationalGroupToken ?? ""
                                        self.teacherGroupName = group.educationalGroupNameCurrent ?? ""
                                        //                                        showingActionSheet.toggle()
                                    }
                                }
                                if teacherGroupsVm.currentPage < teacherGroupsVm.totalPages {
                                    Text(NSLocalizedString("fetchMoreData", comment: ""))
                                        .onAppear {
                                            teacherGroupsVm.currentPage += 1
                                            teacherGroupsVm.paginated = true
                                            teacherGroupsVm.getAllTeachersGroups(userServiceProviderToken: self.userProviderToken,categoryToken:"")
                                        }
                                    
                                }
                          
                            }
                            .listStyle(InsetGroupedListStyle())
                            .refreshable {
                                teacherGroupsVm.currentPage = 1
                                teacherGroupsVm.paginated = false
                                teacherGroupsVm.getAllTeachersGroups(userServiceProviderToken: self.userProviderToken,categoryToken:"")
                            }
                            .actionSheet(isPresented: $showingActionSheet) {
                                ActionSheet(
                                    title: Text(self.teacherGroupName),
                                    message: Text(NSLocalizedString("whatYouNeed", comment: "")),
                                    buttons: [
                                        .default(Text(NSLocalizedString("groupExams", comment: ""))) {
                                            showExams.toggle()
                                        },
                                        .default(Text(NSLocalizedString("groupMedia", comment: ""))) {
                                            showMedia.toggle()
                                        },
                                        .cancel(),
                                    ]
                                )
                            }
                        }
                    }
                }
                .navigationTitle(NSLocalizedString("teacherGroups", comment: ""))
                .navigationBarItems(leading: CustomBackButton(){
                    clearStatesWithAction(valueState: &backFromTeacherGroups)
                })
            }
        }
        .ipad()
        .background(genralVm.isDark ? Color(Colors().darkBodyBg): Color(Colors().lightBodyBg))
        .onAppear(perform: {
            teacherGroupsVm.getAllTeachersGroups(userServiceProviderToken: self.userProviderToken,categoryToken:"")
        })
        .overlay(
            teacherGroupsVm.showLogOut ?
            AzDialogActions(isPresented: $teacherGroupsVm.showLogOut, dismissAzDialogActions:false,
                            dismissAzDialogDirection: .none,
                            showDismissButton: false, title: NSLocalizedString("alert", comment: ""), message: teacherGroupsVm.msg, imageTop: "logout_button", buttonClick: NSLocalizedString("logout", comment: ""), onClick: {
                                clearStatesWithAction(valueState: &showHome)
                                Helper.removeUserDefaultsAndCashes()
                            }) : nil)
        .overlay(
            teacherGroupsVm.isLoading ?
            GeometryReader { geometry in
                ZStack {
                    LoadingView(placHolder: NSLocalizedString("loading", comment: ""))
                        .frame(width: geometry.size.width, height: geometry.size.height)
                        .transition(.scale)
                } } : nil
        )
        .refreshable {
            teacherGroupsVm.getAllTeachersGroups(userServiceProviderToken: self.userProviderToken,categoryToken:"")
        }
        .onDisappear(perform: {
            clearStatesWithAction(valueState: &genralVm.dissapearView)
    
        })
        .fullScreenCover(isPresented: $backFromTeacherGroups, content: {
            LecturersView()
        })
        .fullScreenCover(isPresented: $showHome, content: {
            RegistrationView()
        })
        
        .fullScreenCover(isPresented: $showExams, content: {
            StudentExamTabView()
            //
            //                        StudentExamsView(educationGroupTimeToken: "", educationalGroupToken: self.teacherGroupToken)
            //                            .environmentObject(ScreenshotDetector())
            //                            .environmentObject(ScreenRecordingDetector())
        })
        .fullScreenCover(isPresented: $showMedia) {
            EducationGroupTimesMediaView(groupTimeToken:"",groupToken: self.teacherGroupToken)
                .environmentObject(ScreenshotDetector())
                .environmentObject(ScreenRecordingDetector())
        }
    }
    
    private func clearStatesWithAction(valueState: inout Bool) {
        valueState.toggle()
        backFromTeacherGroups = false
        showHome = false
        showExams = false
        showMedia = false
    }
}
