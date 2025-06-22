////
////  SchudleTimeView.swift
////  FEDS-Center-Dev
////
////  Created by Omar pakr on 24/12/2023.
////
//
//import SwiftUI
//
//@available(iOS 16.0, *)
//struct LecturerScheduleView: View {
//    @StateObject var shcudelTimesVm : SchudleTimeVm = SchudleTimeVm()
//
//    @State private var showLecturersFromLecturerSchedule : Bool = false
//    @State private var showRegFromLecturerSchedule : Bool = false
//    @State private var dissapearView : Bool = false
//   
//    @State var educationalGroupToken : String = "false"
//    let isDark = UserDefaultss().restoreBool(key: "isDark")
//    let constants = Constants()
//    @State  var lang = Locale.current.language.languageCode!.identifier
//
//    var body: some View {
//        NavigationView {
//            VStack (spacing:0){
//                CaalenderRepresentable(selectedDate: $shcudelTimesVm.selectedDate,viewModel:shcudelTimesVm)
//                    .frame(height:200)
//                ZStack {
//                    if shcudelTimesVm.noData {
//                        NoContent(message: shcudelTimesVm.msg)
//                    } else {
//                        ScrollView {
//                            ForEach(shcudelTimesVm.educationalGroupScheduleTimes, id: \.educationalGroupScheduleTimeToken) { shcudelTime in
//                                VStack {
//                                    VStack(spacing:0) {
//                                        VStack{
//                                            HStack (spacing:30){
//                                                Image("teacher-icon")
//                                                    .resizable()
//                                                    .frame(width:20,height:20)
//                                                
//                                                Text(shcudelTime.userServiceProviderInfoData?.userNameCurrent ?? "")
//                                            }
//                                        }
//                                        .padding()
//                                        .frame(height:40)
//                                        .background(isDark ? Color.gray.opacity(0.4) : Color.black.opacity(0.4))
//                                        .cornerRadius(20)
//                                        
//                                        
//                                        
//                                        VStack (alignment:.leading){
//                                            HStack(spacing:80) {
//                                                
//                                                HStack {
//                                                    HStack {
//                                                        Image("clocc")
//                                                            .resizable()
//                                                            .frame(width: 20, height: 20)
//                                                        
//                                                        Text(shcudelTime.dateTimeFromTime ?? "")
//                                                    }
//                                                }
//                                                
//                                                HStack {
//                                                    Image(systemName: self.lang == "ar" ? "arrow.left" : "arrow.right")
//                                                        .resizable()
//                                                        .renderingMode(.original)
//                                                        .foregroundColor(.red)
//                                                        .frame(width: 50, height: 20)
//                                                }
//                                                
//                                                HStack {
//                                                    HStack {
//                                                        Image("clocc")
//                                                            .resizable()
//                                                            .frame(width: 20, height: 20)
//                                                        Text(shcudelTime.dateTimeToTime ?? "")
//                                                    }
//                                                }
//                                            }
//                                            
//                                            
//                                            VStack(alignment:.leading) {
//                                                HStack {
//                                                    Image("book_tab_bar")
//                                                        .resizable()
//                                                        .frame(width: 20, height: 20)
//                                                    
//                                                    Text(shcudelTime.educationalCategoryInfoData?.educationalCategoryFullNameCurrent ?? "")
//                                                }
//                                                
//                                                
//                                                HStack {
//                                                    Image("place")
//                                                        .resizable()
//                                                        .frame(width: 20, height: 20)
//                                                    Text(shcudelTime.placeInfoData?.placeFullNameCurrent ?? NSLocalizedString("placeName", comment: ""))
//                                                    
//                                                }
//                                            }
//                                        }
//                                        .frame(width: UIScreen.main.bounds.width - 20)
//                                        .padding(.bottom,10)
//                                        .background(isDark ? Color.gray.opacity(0.4) : Color.black.opacity(0.4))
//                                        .cornerRadius(5)
//                                        .padding(.trailing,10)
//                                        .padding(.leading,10)
//                                        
//                                        
//                                    }
//                                    .font(
//                                        Font.custom(Fonts().getFontBold(), size: 14)
//                                            .weight(.bold)
//                                    )
//                                    .multilineTextAlignment(.leading)
//                                    .lineLimit(4)
//                                    .foregroundColor(.white)
//                                    .onTapGesture(perform: {
//                                        
//                                    })
//                                    
//                                    
//                                    HStack {
//                                        Image("clocc")
//                                            .resizable()
//                                            .frame(width:20,height:20)
//                                        
//                                        Text(shcudelTime.durationCurrent ?? NSLocalizedString("duration", comment: ""))
//                                            .foregroundColor(isDark ? .white : .black)
//                                    }
//                                    .padding()
//                                    .frame(maxWidth:.infinity,alignment:.trailing)
//                                    
//                                    Rectangle()
//                                        .fill(isDark ? .white : .black)
//                                        .frame(height: 3)
//                                        .edgesIgnoringSafeArea(.horizontal)
//                                }
//                            }
//                        }
//                    }
//                }
//            }
//            
//            .navigationTitle(NSLocalizedString("schudelTime", comment: ""))
//            .navigationBarItems(leading: CustomBackButton(){
//                clearStatesWithAction(valueState: $showLecturersFromLecturerSchedule)
//            })
//            
//            .overlay(
//                shcudelTimesVm.showLogOut ?
//                AzDialogActions(isPresented: $shcudelTimesVm.showLogOut, dismissAzDialogActions:false,
//                                dismissAzDialogDirection: .none,
//                                showDismissButton: false, title: NSLocalizedString("alert", comment: ""), message: shcudelTimesVm.msg, imageTop: "logout_button", buttonClick: NSLocalizedString("logout", comment: ""), onClick: {
//                                    clearStatesWithAction(valueState: &showRegFromLecturerSchedule)
//                                    Helper.removeUserDefaultsAndCashes()
//                                }) : nil)
//            .overlay(
//                shcudelTimesVm.isLoading ?
//                GeometryReader { geometry in
//                    ZStack {
//                        LoadingView(placHolder: NSLocalizedString("loading", comment: ""))
//                            .frame(width: geometry.size.width, height: geometry.size.height)
//                            .transition(.scale)
//                    } } : nil
//            )
//            .onDisappear(perform: {
//                clearStatesWithAction(valueState: &dissapearView)
//            })
//            .fullScreenCover(isPresented: $showRegFromLecturerSchedule, content: {
//                RegistrationView()
//            })
//            .fullScreenCover(isPresented: $showLecturersFromLecturerSchedule, content: {
//                LecturersView()
//            })
//            
//            
//            
//        }
//        .background(isDark ? Color(Colors().darkBodyBg): Color(Colors().lightBodyBg))
//        .ipad()
//       
//    }
//        
//    private func clearStatesWithAction(valueState: inout Bool) {
//            valueState.toggle()
//            $backGeasture = false
//            $showHome = false
//        }
//        
//        
//    }
//    
