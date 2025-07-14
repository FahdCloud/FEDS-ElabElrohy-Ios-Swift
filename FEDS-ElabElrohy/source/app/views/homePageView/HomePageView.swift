//
//  HomePageView.swift
//  FEDS-Center-Dev
//
//  Created by Mrwan on 19/12/2023.
//

import SwiftUI

@available(iOS 16.0, *)
struct HomePageView: View {
    @StateObject var homePageVm : HomePageVm = HomePageVm()
    @StateObject var newsVm : NewsVm = NewsVm()
    @StateObject var genralVm : GeneralVm = GeneralVm()

    @State private var isPresentSubjects : Bool = false
    @State private var isPresentHomeSchedule : Bool = false
    @State private var isPresentGroup : Bool = false
    @State private var isPresentStudentCodes : Bool = false
    @State private var isPresentExams : Bool = false
    @State private var showNews : Bool = false
    @State private var showRegFromHomePage : Bool = false


    let columns = [ GridItem(.fixed(150), spacing: 30), GridItem(.fixed(150), spacing: 30)]
    let userTypeToken  = UserDefaultss().restoreString(key: "userTypeToken")

    var body: some View {
        NavigationView {
            ZStack {
                ScrollView {
                    VStack {
                        HomeLatestNewsSlider()
                            .onTapGesture {
                                clearStatesWithAction(valueState: &showNews)
                                
                            }.padding(.bottom, 10)
                        
                        LazyVGrid(columns: columns,spacing: 30) {
                            ForEach(homePageVm.homePageList) { top in
                                CardBottomTxtWithBgImageAsset(imageAsset: top.image, tittleOfCard: top.name)
                                    .frame(width: 150, height: 150, alignment: .center)
                                    .onTapGesture {
                                        if top.route == "subjects" {
                                                clearStatesWithAction(valueState: &isPresentSubjects)
                                        } else if top.route == "schudelTime" {
                                            UserDefaultss().removeObject(forKey: "groupToken")
                                            clearStatesWithAction(valueState: &isPresentHomeSchedule)
                                        } else if top.route == "groups" {
                                            clearStatesWithAction(valueState: &isPresentGroup)
                                        } else if top.route == "teachersCodes" {
                                            clearStatesWithAction(valueState: &isPresentStudentCodes)
                                            
                                        } else if top.route == "exams" {
                                            UserDefaultss().removeObject(forKey: "groupToken")
                                            clearStatesWithAction(valueState: &isPresentExams)
                                        }
                                    }
                            }
                        }
                        .padding()
                    }
                    
                    
                }
                .background(genralVm.isDark ? Color(Colors().darkBodyBg): Color(Colors().lightBodyBg))
                .ipad()
            }
            .fullScreenCover(isPresented: $newsVm.showLogOut, content: {
                RegistrationView()
            })
            .fullScreenCover(isPresented: $isPresentSubjects, content: {
                CategoriesView()
            })
            .fullScreenCover(isPresented: $isPresentHomeSchedule, content: {
                GroupSchedule()
            })
            .fullScreenCover(isPresented: $showNews, content: {
                NewsView()
            })
            .fullScreenCover(isPresented: $isPresentStudentCodes, content: {
                LecturersView()
            })
            .fullScreenCover(isPresented: $isPresentExams, content: {
                StudentExamTabView()
            })
            .fullScreenCover(isPresented: $isPresentGroup, content: {
                GroupsView(isFinished: false)
            })
            
        }
        .overlay(
            newsVm.isLoading ?
            GeometryReader { geometry in
                ZStack {
                    LoadingView(placHolder: NSLocalizedString("loading", comment: ""))
                        .frame(width: geometry.size.width, height: geometry.size.height)
                        .transition(.scale)
                } } : nil
        )
    
        .onAppear {
            newsVm.getNews(isSlider: true)
            UserDefaultss().removeObject(forKey: "categoryToken")
            UserDefaultss().removeObject(forKey: "userProviderToken")
        }
        .onDisappear(perform: {
            clearStatesWithAction(valueState: &genralVm.dissapearView)
        })
        .refreshable {
            newsVm.getNews(isSlider: true)
            UserDefaultss().removeObject(forKey: "categoryToken")
            UserDefaultss().removeObject(forKey: "userProviderToken")
        }
    }
    private func clearStatesWithAction(valueState: inout Bool) {
        valueState.toggle()
        isPresentSubjects = false
        isPresentHomeSchedule = false
        showNews = false
        isPresentStudentCodes = false
        isPresentExams = false
        isPresentGroup = false
    }
}
