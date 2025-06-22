//
//  SchudleTimeView.swift
//  FEDS-Center-Dev
//
//  Created by Omar pakr on 24/12/2023.
//

import SwiftUI

@available(iOS 16.0, *)
struct SchudleTimeView: View {
    @StateObject var shcudelTimesVm : SchudleTimeVm = SchudleTimeVm()
    @StateObject var genralVm : GeneralVm = GeneralVm()

    @State private var showStudentMainFromSchudleTime : Bool = false
    @State private var educationalGroupToken : String = "false"
    
    var body: some View {
        
        GeometryReader { geometry in
            NavigationView {
                ZStack {
                    ScrollView {
                        VStack (spacing:0){
                            
                            CaalenderRepresentable(selectedDate: $shcudelTimesVm.selectedDate,viewModel:shcudelTimesVm)
                                .frame(height:200)
                            
                            ZStack {
                                if shcudelTimesVm.noData {
                                    NoContent(message: shcudelTimesVm.msg)
                                } else {
                                    ScrollView {
                                        ForEach(shcudelTimesVm.educationalGroupScheduleTimes, id: \.educationalGroupScheduleTimeToken) { shcudelTime in
                                            VStack {
                                                VStack(spacing:0) {
                                                    VStack{
                                                        HStack (spacing:30){
                                                            Image("teacher-icon")
                                                                .resizable()
                                                                .frame(width:20,height:20)
                                                            
                                                            Text(shcudelTime.userServiceProviderInfoData?.userNameCurrent ?? "")
                                                        }
                                                    }
                                                    .padding()
                                                    .frame(height:40)
                                                    .background(genralVm.isDark ? Color.gray.opacity(0.4) : Color.black.opacity(0.4))
                                                    .cornerRadius(20)
                                                    
                                                    
                                                    
                                                    VStack (alignment:.leading){
                                                        HStack(spacing:80) {
                                                            
                                                            HStack {
                                                                HStack {
                                                                    Image("clocc")
                                                                        .resizable()
                                                                        .frame(width: 20, height: 20)
                                                                    
                                                                    Text(shcudelTime.dateTimeFromTime ?? "")
                                                                }
                                                            }
                                                            
                                                            HStack {
                                                                Image(systemName: self.genralVm.lang == "ar" ? "arrow.left" : "arrow.right")
                                                                    .resizable()
                                                                    .renderingMode(.original)
                                                                    .foregroundColor(.red)
                                                                    .frame(width: 50, height: 20)
                                                            }
                                                            
                                                            HStack {
                                                                HStack {
                                                                    Image("clocc")
                                                                        .resizable()
                                                                        .frame(width: 20, height: 20)
                                                                    Text(shcudelTime.dateTimeToTime ?? "")
                                                                }
                                                            }
                                                        }
                                                        
                                                        
                                                        VStack(alignment:.leading) {
                                                            HStack {
                                                                Image("book_tab_bar")
                                                                    .resizable()
                                                                    .frame(width: 20, height: 20)
                                                                
                                                                Text(shcudelTime.educationalCategoryInfoData?.educationalCategoryFullNameCurrent ?? "")
                                                            }
                                                            
                                                            
                                                            HStack {
                                                                Image("place")
                                                                    .resizable()
                                                                    .frame(width: 20, height: 20)
                                                                Text(shcudelTime.placeInfoData?.placeFullNameCurrent ?? NSLocalizedString("placeName", comment: ""))
                                                                
                                                            }
                                                        }
                                                    }
                                                    .frame(width: geometry.size.width - 20)
                                                    .padding(.bottom,10)
                                                    .background(genralVm.isDark ? Color.gray.opacity(0.4) : Color.black.opacity(0.4))
                                                    .cornerRadius(5)
                                                    .padding(.trailing,10)
                                                    .padding(.leading,10)
                                                    
                                                    
                                                }
                                                .font(
                                                    Font.custom(Fonts().getFontBold(), size: 14)
                                                        .weight(.bold)
                                                )
                                                .multilineTextAlignment(.leading)
                                                .lineLimit(4)
                                                .foregroundColor(.white)
                                                .onTapGesture(perform: {
                                                    
                                                })
                                                
                                                
                                                HStack {
                                                    Image("clocc")
                                                        .resizable()
                                                        .frame(width:20,height:20)
                                                    
                                                    Text(shcudelTime.durationCurrent ?? NSLocalizedString("duration", comment: ""))
                                                        .foregroundColor(genralVm.isDark ? .white : .black)
                                                }
                                                .padding()
                                                .frame(maxWidth:.infinity,alignment:.trailing)
                                                
                                                Rectangle()
                                                    .fill(genralVm.isDark ? .white : .black)
                                                    .frame(height: 3)
                                                    .edgesIgnoringSafeArea(.horizontal)
                                            }
                                        }
                                    }
                                }
                            }
                            .navigationBarItems(leading: CustomBackButton(){
                                clearStatesWithAction(valueState: &showStudentMainFromSchudleTime)
                            })
                            .navigationTitle(NSLocalizedString("schudelTime", comment: ""))
                            
                        }
                    }
                    
                }
            }
            .background(genralVm.isDark ? Color(Colors().darkBodyBg): Color(Colors().lightBodyBg))
            .ipad()
            .fullScreenCover(isPresented: $shcudelTimesVm.showLogOut, content: {
                RegistrationView()
            })
            
            
            .fullScreenCover(isPresented: $showStudentMainFromSchudleTime, content: {
                StudentMainTabView()
            })
//            
//            .onAppear(perform: {
//                UserDefaultss().removeObject(forKey: "groupToken")
//            })
            
            .overlay(
                shcudelTimesVm.isLoading ?
                GeometryReader { geometry in
                    ZStack {
                        LoadingView(placHolder: NSLocalizedString("loading", comment: ""))
                            .frame(width: geometry.size.width, height: geometry.size.height)
                            .transition(.scale)
                    } } : nil
            )
            
            .onDisappear {
                clearStatesWithAction(valueState: &genralVm.dissapearView)
            }
        }
    }
    private func clearStatesWithAction(valueState: inout Bool) {
        valueState.toggle()
        showStudentMainFromSchudleTime = false
    }
}
