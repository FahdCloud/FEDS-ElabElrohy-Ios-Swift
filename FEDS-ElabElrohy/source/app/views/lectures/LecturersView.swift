//
//  TeachersCodesView.swift
//  FPLS-Dev
//
//  Created by Omar pakr on 26/11/2023.
//

import SwiftUI

@available(iOS 16.0, *)
struct LecturersView: View {
    @StateObject var usersVm : LecturerVm = LecturerVm()
    @StateObject var genralVm : GeneralVm = GeneralVm()

    let columns = [ GridItem(.fixed(150), spacing: 30), GridItem(.fixed(150), spacing: 30)]
    @State private var toast: Toast? = nil
    @State private var showStudentMainFromLectures : Bool = false
    @State private var showLectureHome: Bool = false
    @State var userProviderToken : String = ""
    var userToken = UserDefaultss().restoreString(key: "userToken")
    
    var body: some View {
        NavigationView {
            ZStack {
                if usersVm.noData {
                    NoContent(message: usersVm.msg)
                    
                } else {
                    VStack {
                        ScrollView {
                            LazyVGrid(columns: columns,spacing: 30) {
                                ForEach(usersVm.users,id: \.userToken) { user in
                                    CardBottomTxtWithBgImageUrl(
                                        width: (UIScreen.main.bounds.width-140)/1.8, height: 150,
                                        defaultImage: "lecturer",
                                        imageUrl: user.userThumbnailImageUrl ?? "",
                                        nameTitle: user.userNameCurrent ?? "",
                                        nameTitleSize: 16)
                                    {
                                        self.userProviderToken = user.userToken ?? ""
                                        UserDefaultss().saveStrings(value: user.userToken ?? "", key: "userProviderToken")
                                        clearStatesWithAction(valueState: &showLectureHome)
                                        UserDefaultss().saveStrings(value: genralVm.constants.ROUTE_FROM_LECTUERES_COURSES, key: genralVm.constants.KEY_ROUTE_COURSES)
                                        
                                    }
                                    .onTapGesture {
                                        self.userProviderToken = user.userToken ?? ""
                                        UserDefaultss().saveStrings(value: user.userToken ?? "", key: "userProviderToken")
                                        clearStatesWithAction(valueState: &showLectureHome)
                                        UserDefaultss().saveStrings(value: genralVm.constants.ROUTE_FROM_LECTUERES_COURSES, key: genralVm.constants.KEY_ROUTE_COURSES)
                                    }
                                }
                            }
                            .padding()
                        }
                        .refreshable {
                            usersVm.isLoading = false
                            usersVm.getUsers(refresh: true, userTypeToken: genralVm.constants.USER_TYPE_TOKEN_PROVIDER
                                             ,educationalCategoryToken: "")
                        }
                        .toastView(toast: $toast)
                        .onAppear {
                            UserDefaultss().removeObject(forKey: "userProviderToken")
                            usersVm.getUsers(refresh: false, userTypeToken: genralVm.constants.USER_TYPE_TOKEN_PROVIDER,
                                             educationalCategoryToken: "")
                        }
                    }
                    
                }
            }
            .navigationTitle(NSLocalizedString("teachers", comment: ""))
            .navigationBarItems(leading: CustomBackButton(){
                UserDefaultss().removeObject(forKey: "userProviderToken")
                clearStatesWithAction(valueState: &showStudentMainFromLectures)
            }
            )
            .fullScreenCover(isPresented: $showStudentMainFromLectures, content: {
                StudentMainTabView()
            })
            .fullScreenCover(isPresented: $showLectureHome, content: {
                LecturersHomeView()
            })
            .fullScreenCover(isPresented: $usersVm.showLogOut, content: {
                RegistrationView()
            })
            
            .overlay(usersVm.isLoading ?
                     GeometryReader { geometry in
                ZStack {
                    LoadingView(placHolder: NSLocalizedString("loading", comment: ""))
                        .frame(width: geometry.size.width, height: geometry.size.height)
                        .transition(.scale)
                } } : nil
            )
            
        }
        .onDisappear {
            clearStatesWithAction(valueState: &genralVm.dissapearView)
        }
    }
    
    private func loadMoreContentIfNeeded(currentItem user: UsersDatum) {
        guard !usersVm.isLoading, let lastUser = usersVm.users.last, lastUser.userToken == user.userToken else { return }
        usersVm.isLoading = true
        // Call your function to load more content here
        loadMoreContent()
    }
    
    private func loadMoreContent() {
        usersVm.getUsers(userTypeToken: genralVm.constants.USER_TYPE_TOKEN_PROVIDER
                         ,educationalCategoryToken: "")
    }
    
    
    private func clearStatesWithAction(valueState: inout Bool) {
        valueState.toggle()
        UserDefaultss().removeObject(forKey: "lectureHomeTag")
        showLectureHome = false
        showStudentMainFromLectures = false
    }
    
}



