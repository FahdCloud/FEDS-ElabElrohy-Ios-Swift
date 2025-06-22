
//
//  EducationGroup.swift
//  FPLS-Dev
//
//  Created by Omar pakr on 30/10/2023.
//

import SwiftUI

@available(iOS 16.0, *)
struct GroupsView: View {
    @StateObject var educationGroupsVm : EducationalGroupsVm = EducationalGroupsVm()
    @StateObject var genralVm : GeneralVm = GeneralVm()

    let isFinished : Bool
    
    @State private var educationalGroupToken : String = ""
    @State private var showStudentMainFromGroups : Bool = false
    @State private var showAZDialogAlert : Bool = false
    
    var body: some View {
        NavigationView {
            ZStack {
                if educationGroupsVm.noData {
                    NoContent(message: educationGroupsVm.msg)
                       
                } else {
                    VStack {
                        ScrollView {
                            ForEach(educationGroupsVm.allEducationalGroupData, id: \.educationalGroupToken) { group in
                                VStack(spacing:0) {
                                    HStack (spacing:10){
                                        Spacer()
                                        VStack{
                                            Text(group.educationalGroupNameCurrent ?? "")
                                                .padding(.all, 5)
                                        }
                                        .padding()
                                        .frame(height:50)
                                        .background(genralVm.isDark ? Color(Colors().darkCardBg): Color(Colors().lightCardBg))
                                        .cornerRadius(5)
                                        Spacer()
                                        
                                        Image((group.educationalGroupClosedStateTypeToken ?? "") == genralVm.constants.EDUCATION_GROUP_CLOSED_STATE_CLOSED ? "lock" : "unlocked")
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
                                                
                                                Text(group.userServiceProviderInfoData?.userNameCurrent ?? "")
                                                
                                            }
                                            .padding(.top, 8)
                                            
                                            HStack {
                                                Image("calendar")
                                                    .resizable()
                                                    .frame(width: 25, height: 25)
                                                
                                                Text(group.educationalGroupStatisticsInfoData?.educationalGroupStartDate ?? "")
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
                                                    
                                                    Text(group.sessionPriceWithCurrencyFroClient ?? "")
                                                    
                                                }
                                                
                                                
                                                HStack {
                                                    Image("vec_money_1")
                                                        .resizable()
                                                        .frame(width: 25, height: 25)
                                                    
                                                    Text(NSLocalizedString("durationPrice", comment: ""))
                                                    
                                                    Text(group.durationPriceWithCurrencyFroClient ?? "")
                                                }
                                                .padding(.top, 8)
                                                
                                            }
                                            
                                            
                                            HStack {
                                                Image("calendar")
                                                    .resizable()
                                                    .frame(width: 25, height: 25)
                                                
                                                Text(group.educationalGroupStatisticsInfoData?.educationalGroupEndDate ?? "")
                                            }
                                            .padding(.top, 8)
                                            
                                        }
                                        .padding(.horizontal, 8)
                                    }
                                    
                                    .frame(width: UIScreen.main.bounds.width - 20)
                                    .padding(.vertical,25)
                                    .padding(.horizontal, 5)
                                    .background(genralVm.isDark ? Color(Colors().darkCardBg): Color(Colors().lightCardBg))
                                    .cornerRadius(10)
                                    
                                    
                                    
                                    
                                }
                                .padding(.vertical, 12)
                                .font(
                                    Font.custom(Fonts().getFontBold(), size: 14)
                                        .weight(.bold)
                                )
                                .multilineTextAlignment(.center)
                                .lineLimit(1)
                                .foregroundColor(genralVm.isDark ? Color(Colors().darkCardText): Color(Colors().lightCardText))
                                .onTapGesture(perform: {
                                    educationalGroupToken = group.educationalGroupToken ?? ""
                                    if (group.educationalGroupClosedStateTypeToken ?? "") == genralVm.constants.EDUCATION_GROUP_CLOSED_STATE_CLOSED {
                                        showAZDialogAlert.toggle()
                                    }
                                })
                                .frame(width: UIScreen.main.bounds.width, alignment: .center)
                            }
                            
                            if educationGroupsVm.currentPage < educationGroupsVm.totalPages {
                                Text(NSLocalizedString("fetchMoreData", comment: ""))
                                    .onAppear {
                                        educationGroupsVm.currentPage += 1
                                        educationGroupsVm.paginated = true
                                        educationGroupsVm.getGroups(
                                            finishedToken: isFinished ? genralVm.constants.GROUPS_FINISHED : genralVm.constants.GROUPS_UN_FINISHED,
                                            refresh:true)
                                    }
                                
                            }
                        }
                        .onAppear(perform: {
                            educationGroupsVm.getGroups(
                                finishedToken: isFinished ? genralVm.constants.GROUPS_FINISHED : genralVm.constants.GROUPS_UN_FINISHED,
                                refresh:true)
                            
                        })
                        
                    }
                }
            }
            .navigationTitle(NSLocalizedString("groups", comment: ""))
            .navigationBarItems(leading: CustomBackButton(){
                clearStatesWithAction(valueState: &showStudentMainFromGroups)
            })
            .background(AZDialogAlert(isPresented: $showAZDialogAlert,
                                      title: NSLocalizedString("alert", comment: ""),
                                      message: NSLocalizedString("message_group_closed", comment: ""),
                                      imageTop: "3d-lock"))
          
            .fullScreenCover(isPresented: $educationGroupsVm.showLogOut, content: {
                RegistrationView()
            })
            .fullScreenCover(isPresented: $showStudentMainFromGroups, content: {
                StudentMainTabView()
            })
           .ipad()
           .background(genralVm.isDark ? Color(Colors().darkBodyBg): Color(Colors().lightBodyBg))
        }
     
        .refreshable {
            educationGroupsVm.currentPage = 1
            educationGroupsVm.paginated = false
            educationGroupsVm.getGroups(
                finishedToken: isFinished ? genralVm.constants.GROUPS_FINISHED : genralVm.constants.GROUPS_UN_FINISHED,
                refresh:true)
        }
        .onDisappear(perform: {
            clearStatesWithAction(valueState: &genralVm.dissapearView)
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
        
    }
    
    private func clearStatesWithAction(valueState: inout Bool) {
        valueState.toggle()
        showStudentMainFromGroups = false
    }
}
 
