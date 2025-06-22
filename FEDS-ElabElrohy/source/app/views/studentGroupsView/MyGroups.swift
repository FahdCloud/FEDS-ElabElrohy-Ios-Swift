//
//  EducationGroupFilterd.swift
//  FPLS-Dev
//
//  Created by Omar pakr on 30/10/2023.
//

import SwiftUI

@available(iOS 16.0, *)
struct MyGroups: View {
    @StateObject var educationGroupsVm : EducationalGroupsVm = EducationalGroupsVm()
    @StateObject var genralVm : GeneralVm = GeneralVm()
    
    let isFinished : Bool
    @State private var backFromMyGroups : Bool = false
    @State private var showExams : Bool = false
    @State private var showView : Bool = false
    @State private var isPresentSchulde : Bool = false
    @State private var showAttendanceHistory : Bool = false
    @State private var showViewOfNotClosed : Bool = false
    @State private var educationalGroupToken : String = ""
    @State private var groupName : String = ""
    
    @State  var educationCategories : EducationalCategoryInfoDataa = EducationalCategoryInfoDataa()
    @State  var userServiceData : UserServiceProviderInfoData = UserServiceProviderInfoData()
    @State  var educationalGroupInfoData : EducationalGroupInfoDataa = EducationalGroupInfoDataa()
    
    
    var body: some View {
        
        GeometryReader { geometry in
            ZStack(alignment:.bottom) {
                NavigationView {
                    VStack {
                        ZStack {
                            if educationGroupsVm.noData {
                                NoContent(message: educationGroupsVm.msg)
                            } else {
                                VStack {
                                    ScrollView {
                                        ForEach(educationGroupsVm.educationalGroupData, id: \.educationalGroupToken) { group in
                                            VStack(spacing:0) {
                                                HStack (spacing:10){
                                                    Spacer()
                                                    VStack{
                                                        Text(group.educationalGroupInfoData?.educationalGroupNameCurrent ?? "")
                                                            .padding(.all, 5)
                                                    }
                                                    .padding()
                                                    .frame(height:50)
                                                    .background(genralVm.isDark ? Color(Colors().darkCardBg): Color(Colors().lightCardBg))
                                                    .cornerRadius(5)
                                                    Spacer()
                                                    
                                                    Image((group.educationalGroupInfoData?.educationalGroupClosedStateTypeToken ?? "") == genralVm.constants.EDUCATION_GROUP_CLOSED_STATE_CLOSED ? "lock" : "unlocked")
                                                        .resizable()
                                                        .frame(width: 40, height: 40)
                                                        .padding(.trailing,10)
                                                    
                                                    
                                                }
                                                
                                                HStack (spacing:80){
                                                    VStack(alignment:.leading) {
                                                        
                                                        HStack {
                                                            Image("closed_book")
                                                                .resizable()
                                                                .frame(width: 25, height: 25)
                                                            Text(group.educationalCategoryInfoData?.educationalCategoryNameCurrent ?? "")
                                                        }
                                                        
                                                        HStack {
                                                            Image("lecture")
                                                                .resizable()
                                                                .frame(width: 25, height: 25)
                                                            
                                                            Text(group.educationalGroupInfoData?.userServiceProviderInfoData?.userNameCurrent ?? "")
                                                            
                                                        }
                                                        
                                                        .padding(.top, 8)
                                                        
                                                        HStack {
                                                            Image("calendar")
                                                                .resizable()
                                                                .frame(width: 25, height: 25)
                                                            
                                                            Text(group.educationalGroupInfoData?.educationalGroupStatisticsInfoData?.educationalGroupStartDate ?? "")
                                                        }
                                                        .padding(.top, 8)
                                                        
                                                    }
                                                    .padding(.horizontal, 8)
                                                    
                                                    
                                                    VStack(alignment:.leading) {
                                                        
                                                        if genralVm.havePermissionToView {
                                                            
                                                            HStack {
                                                                Image("vec_money_2")
                                                                    .resizable()
                                                                    .frame(width: 25, height: 25)
                                                                
                                                                Text(NSLocalizedString("sessionPrice", comment: ""))
                                                                
                                                                Text(group.educationalGroupInfoData?.sessionPriceWithCurrencyFroClient ?? "")
                                                                
                                                            }
                                                            
                                                            
                                                            HStack {
                                                                Image("vec_money_1")
                                                                    .resizable()
                                                                    .frame(width: 25, height: 25)
                                                                
                                                                Text(NSLocalizedString("durationPrice", comment: ""))
                                                                
                                                                Text(group.educationalGroupInfoData?.durationPriceWithCurrencyFroClient ?? "")
                                                            }
                                                            .padding(.top, 8)
                                                            
                                                        }
                                                        
                                                        HStack {
                                                            Image("calendar")
                                                                .resizable()
                                                                .frame(width: 25, height: 25)
                                                            
                                                            Text(group.educationalGroupInfoData?.educationalGroupStatisticsInfoData?.educationalGroupEndDate ?? "")
                                                        }
                                                    }
                                                    .padding(.horizontal, 8)
                                                }
                                                
                                                .frame(width: geometry.size.width - 20)
                                                .padding(.vertical,25)
                                                .padding(.horizontal, 5)
                                                .background(genralVm.isDark ? Color(Colors().darkCardBg): Color(Colors().lightCardBg))
                                                .cornerRadius(10)
                                                
                                            }
                                            .padding(.vertical, 12)
                                            .font(
                                                Font.custom(Fonts().getFontBold(), size: 16)
                                                    .weight(.bold)
                                            )
                                            .multilineTextAlignment(.center)
                                            .lineLimit(1)
                                            .foregroundColor(genralVm.isDark ? Color(Colors().darkCardText): Color(Colors().lightCardText))
                                            .onTapGesture(perform: {
                                                educationalGroupToken = group.educationalGroupToken ?? ""
                                                if (group.educationalGroupInfoData?.educationalGroupClosedStateTypeToken ?? "") == genralVm.constants.EDUCATION_GROUP_CLOSED_STATE_CLOSED {
                                                    clearStatesWithAction(valueState: &showView)
                                                } else {
                                                    UserDefaultss().saveStrings(value: group.educationalGroupToken ?? "", key: "groupToken")
                                                    UserDefaultss().saveStrings(value: "CST-3", key: "calendarSearchType")
                                                    self.groupName = group.educationalGroupInfoData?.educationalGroupNameCurrent ?? ""
                                                    self.educationCategories = group.educationalCategoryInfoData ?? EducationalCategoryInfoDataa()
                                                    self.userServiceData = group.educationalGroupInfoData?.userServiceProviderInfoData ?? UserServiceProviderInfoData()
                                                    self.educationalGroupInfoData = group.educationalGroupInfoData ?? EducationalGroupInfoDataa()
                                                    clearStatesWithAction(valueState: &showViewOfNotClosed)
                                                }
                                            })
                                            .frame(width: geometry.size.width, alignment: .center)
                                        }
                                        if educationGroupsVm.currentPage < educationGroupsVm.totalPages {
                                            Text(NSLocalizedString("fetchMoreData", comment: ""))
                                                .onAppear {
                                                    educationGroupsVm.currentPage += 1
                                                    educationGroupsVm.getEducationGroups(finishedToken: isFinished ? genralVm.constants.GROUPS_FINISHED : genralVm.constants.GROUPS_UN_FINISHED,refresh:false)
                                                }
                                        }
                                    }
                                    .refreshable {
                                        educationGroupsVm.getEducationGroups(finishedToken: isFinished ? genralVm.constants.GROUPS_FINISHED : genralVm.constants.GROUPS_UN_FINISHED,refresh:true)
                                    }
                                }
                                
                            }
                            
                        }
                    }
                    
                    .navigationTitle(NSLocalizedString("groups", comment: ""))
                    .navigationBarItems(leading: CustomBackButton(){
                        clearStatesWithAction(valueState: &backFromMyGroups)
                    })
                }
                if showView {
                    ZStack(alignment:.bottom){
                        RoundedRectangle(cornerRadius: 30)
                            .fill(Color.gray)
                            .overlay(alignment: .bottom, content: {
                                Text(NSLocalizedString("message_group_closed", comment: ""))
                                    .font(
                                        Font.custom(Fonts().getFontBold(), size: 15)
                                            .weight(.bold)
                                    )
                                    .padding(.bottom,50)
                                    .multilineTextAlignment(.center)
                                    .lineLimit(5)
                            })
                            .overlay(alignment: .top, content: {
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(Color.red)
                                    .frame(height: 100)
                                    .overlay(
                                        HStack(spacing:50){
                                            Text(NSLocalizedString("closed", comment: ""))
                                                .font (
                                                    Font.custom(Fonts().getFontBold(), size: 15)
                                                        .weight(.bold)
                                                )
                                                .multilineTextAlignment(.center)
                                            
                                            Image("3d-lock")
                                                .resizable()
                                                .frame(width: 80, height: 80, alignment: .center)
                                        }
                                    )
                            }
                            )
                            .edgesIgnoringSafeArea(.all)
                            .frame(height: UIScreen.main.bounds.height * 0.25)
                            .transition(.move(edge: .bottom))
                            .animation(.spring())
                    }
                    .edgesIgnoringSafeArea(.bottom)
                    .frame(maxWidth: .infinity,maxHeight: .infinity,alignment:.bottom)
                    .background(
                        Color.black.opacity(0.35)
                            .onTapGesture(perform: {
                                clearStatesWithAction(valueState: &showView)
                            })
                    )
                }
                if showViewOfNotClosed {
                    ZStack(alignment:.bottom){
                        RoundedRectangle(cornerRadius: 10)
                            .fill(genralVm.isDark ? Color(Colors().darkCardWalletBg): Color(Colors().lightCardWalletBg))
                            .overlay(alignment: .bottom, content: {
                                VStack(alignment: .center){
                                    Spacer()
                                    HStack(alignment: .center, spacing: 10){
                                        Image("attendance")
                                            .resizable()
                                            .frame(width: 30, height: 30)
                                        
                                        
                                        Text(NSLocalizedString("attendnaceHistory", comment: ""))
                                            .font(
                                                Font.custom(Fonts().getFontBold(), size: 18)
                                                    .weight(.bold)
                                            )
                                            .lineLimit(1)
                                            .foregroundColor(genralVm.isDark ? Color(Colors().darkCardText): Color(Colors().lightCardText))
                                    }
                                    .padding(.all, 8)
                                    .onTapGesture {
                                        clearStatesWithAction(valueState: &showAttendanceHistory)
                                    }
                                    
                                    Divider()
                                        .background(genralVm.isDark ? Color(Colors().darkCardBg): Color(Colors().lightCardBg))
                                    Spacer()
                                    
                                    if genralVm.havePermissionToView {
                                        HStack(alignment: .center, spacing: 10){
                                            Image("exams")
                                                .resizable()
                                                .frame(width: 30, height: 30)
                                            
                                            Text(NSLocalizedString("myExams", comment: ""))
                                                .font(
                                                    Font.custom(Fonts().getFontBold(), size: 18)
                                                        .weight(.bold)
                                                )
                                            
                                                .lineLimit(1)
                                            
                                        }
                                        .padding(.all, 8)
                                        .onTapGesture {
                                            clearStatesWithAction(valueState: &showExams)
                                        }
                                        Divider()
                                            .background(genralVm.isDark ? Color(Colors().darkCardBg): Color(Colors().lightCardBg))
                                        Spacer()
                                    }
                                    
                                    HStack(alignment: .center, spacing: 10){
                                        Image("calendar")
                                            .resizable()
                                            .frame(width: 30, height: 30)
                                        
                                        Text(NSLocalizedString("myTimes", comment: ""))
                                            .font(
                                                Font.custom(Fonts().getFontBold(), size: 18)
                                                    .weight(.bold)
                                            )
                                        
                                            .lineLimit(1)
                                        
                                    }
                                    .padding(.all, 8)
                                    .padding(.bottom, 12)
                                    .onTapGesture {
                                        clearStatesWithAction(valueState: &isPresentSchulde)
                                    }
                                }
                            })
                            .edgesIgnoringSafeArea(.all)
                            .frame(height: UIScreen.main.bounds.height * 0.25)
                            .transition(.move(edge: .bottom))
                            .animation(.spring())
                    }
                    .fullScreenCover(isPresented: $isPresentSchulde) {
                        MyGroupSchedule()
                    }
                    .fullScreenCover(isPresented: $showExams) {
                        StudentExamTabView()
                    }
                    
                    .fullScreenCover(isPresented: $showAttendanceHistory, content: {
                        AttendnaceGroupHistory(groupName:self.groupName,groupToken:self.educationalGroupToken,educationCategoryInfoData : self.educationCategories , userProviderInfoData : self.userServiceData,educationalGroupInfoData : self.educationalGroupInfoData)
                    })
                    .edgesIgnoringSafeArea(.bottom)
                    .frame(maxWidth: .infinity,maxHeight: .infinity,alignment:.bottom)
                    .background(
                        Color.black.opacity(0.35)
                            .onTapGesture(perform: {
                                clearStatesWithAction(valueState: &showViewOfNotClosed)
                            })
                    )
                }
            }
            .background(genralVm.isDark ? Color(Colors().darkBodyBg): Color(Colors().lightBodyBg))
            .ipad()
            .onAppear(perform: {
                educationGroupsVm.getEducationGroups(finishedToken: isFinished ? genralVm.constants.GROUPS_FINISHED : genralVm.constants.GROUPS_UN_FINISHED,refresh:true)
            })
            .overlay(
                educationGroupsVm.isLoading ?
                GeometryReader { geometry in
                    ZStack {
                        LoadingView(placHolder: NSLocalizedString("loading", comment: ""))
                            .frame(width: geometry.size.width, height: geometry.size.height)
                            .transition(.scale)
                    } } : nil
            )
            .refreshable {
                educationGroupsVm.getEducationGroups(finishedToken: isFinished ? genralVm.constants.GROUPS_FINISHED : genralVm.constants.GROUPS_UN_FINISHED,refresh:true)
            }
            .fullScreenCover(isPresented: $backFromMyGroups, content: {
                StudentMainTabView()
            })
            .fullScreenCover(isPresented: $educationGroupsVm.showLogOut, content: {
                RegistrationView()
            })
            .onDisappear {
                clearStatesWithAction(valueState: &genralVm.dissapearView)
            }
        }
    }
    private func clearStatesWithAction(valueState: inout Bool) {
        valueState.toggle()
        backFromMyGroups = false
    }
}
