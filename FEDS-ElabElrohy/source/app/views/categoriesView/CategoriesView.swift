//
//  EducationCategories.swift
//  FPLS-Dev
//
//  Created by Omar pakr on 05/10/2023.
//

import SwiftUI

@available(iOS 16.0, *)
struct CategoriesView: View {
    @StateObject var educationCategoryViewModel : EducationCategoryViewModel = EducationCategoryViewModel()
    @StateObject var providerEducationCategoryVm : ProviderEducationCategoryViewModel = ProviderEducationCategoryViewModel()
    @StateObject var knowMethodVm : KnowMethodVm = KnowMethodVm()
    @StateObject var placesVm : PlaceVm = PlaceVm()
    @StateObject var genralVm : GeneralVm = GeneralVm()

    @FocusState var endEditingUserProvider : Bool
    @Environment(\.presentationMode) var presentationMode
    @State private var expandedGroups: Set<String> = []
    @State private var expandedPlaces: Set<String> = []
    @State private var isActionSheetPresented = false
    @State private var showCardView = false
    @State private var showJoiningApplication = false
//    @State private var dissapearView : Bool = false
    @State var preferdProvider : String = ""
    @State var preferdProviderToken : String = ""
    @State var preferdPlace : String = ""
    @State var preferdPlaceToken : String = ""
    @State var knownMethod : String = ""
    @State var knownMethodToken : String = ""
    @State var selectedNode : String = ""
    @State var showPassword : Bool = false
    @State var showLoading : Bool = false
    @State var showMenu : Bool = false
    @State var showingActionSheet : Bool = false
    @State private var toast: Toast? = nil
    @State private var isMenuVisiblePreferdProvider = false
    @State private var isMenuVisiblePreferdPlace = false
    @State private var isMenuVisibleKnowMethod = false
    @State private var selectedOption = "Option 1"
    @State private var showAzDialogReservationAlert = false
    @State private var selectedEducationCategoryName = ""
    @State var educationCategoryToken :String = ""
    @State var showToasting : Bool = false
    @State var showStudentMainFromCategries : Bool = false
    @State var showRegFromCategories : Bool = false
    @State var showCatergoriesHomeFromCategories : Bool = false
    
    let options = ["Option 1", "Option 2", "Option 3"]
    
   private let adaptiveColumns = [
        GridItem(.fixed(100))
    ]
    
    var body: some View {
        NavigationView {
            VStack {
                ZStack {
                    if educationCategoryViewModel.noData {
                        NoContent(message: self.educationCategoryViewModel.msg)
                    } else{
                        
                        VStack{
                            
                            educationCategories
                                .padding(.top,30)
                        }
                        .ipad()
                        .onAppear {
                            educationCategoryViewModel.getEducationCategoriesData(prevEducationCategoryToken: self.educationCategoryToken)
                        }
                    }
                }
            }
            .navigationTitle(NSLocalizedString("educationCategory", comment: ""))
            .navigationBarItems(leading: CustomBackButton(){
                clearStatesWithAction(valueState: &showStudentMainFromCategries)
            })
        }
        .background(genralVm.isDark ? Color(Colors().darkBodyBg): Color(Colors().lightBodyBg))
        .ipad()
        
        .fullScreenCover(isPresented: $showStudentMainFromCategries, content: {
            StudentMainTabView()
        })
        
        .fullScreenCover(isPresented: $educationCategoryViewModel.showLogOut, content: {
            RegistrationView()
        })
        
        .fullScreenCover(isPresented: $showCatergoriesHomeFromCategories, content: {
            CatergoriesHomeView()
        })
        .background(AzDialogActions(isPresented: $showAzDialogReservationAlert, title: NSLocalizedString("requestJoiningApp", comment: ""), message: NSLocalizedString("requestJoiningApp", comment: ""), imageTop: "logout_button", buttonClick: NSLocalizedString("reserve", comment: ""), onClick: {
            
            requestJoin(educationCategory: self.educationCategoryToken)
        }))
        .gesture(
            DragGesture()
                .onEnded { value in
                    // Check if the drag was mainly horizontal (left or right)
                    if abs(value.translation.width) > abs(value.translation.height) {
                        // Check if the drag was towards the left
                        if value.translation.width < 0 {
                            // Perform your action here
                            if educationCategoryViewModel.prevToken != "" {
                                educationCategoryViewModel.getEducationCategoriesData(getParentEducationCategoryOnly:"false",prevEducationCategoryToken: "",educationCategoryToken:educationCategoryViewModel.prevToken,getOnlyChildEducationalCategories:"true")
                            }
                            else {
                                educationCategoryViewModel.getEducationCategoriesData(getParentEducationCategoryOnly:"true",prevEducationCategoryToken: "",educationCategoryToken:"",getOnlyChildEducationalCategories:"false")
                            }
                            
                        } else if value.translation.width > 0 {
                            if educationCategoryViewModel.prevToken != "" {
                                educationCategoryViewModel.getEducationCategoriesData(getParentEducationCategoryOnly:"false",prevEducationCategoryToken: "",educationCategoryToken:educationCategoryViewModel.prevToken,getOnlyChildEducationalCategories:"true")
                            }
                            else {
                                educationCategoryViewModel.getEducationCategoriesData(getParentEducationCategoryOnly:"true",prevEducationCategoryToken: "",educationCategoryToken:"",getOnlyChildEducationalCategories:"false")
                            }
                        }
                    }
                }
        )
        
        .overlay(
            educationCategoryViewModel.showLogOut ?
            AzDialogActions(isPresented: $educationCategoryViewModel.showLogOut, dismissAzDialogActions:false,
                            dismissAzDialogDirection: .none,
                            showDismissButton: false, title: NSLocalizedString("alert", comment: ""), message: educationCategoryViewModel.msg, imageTop: "logout_button", buttonClick: NSLocalizedString("logout", comment: ""), onClick: {
                                clearStatesWithAction(valueState: &showRegFromCategories)
                                Helper.removeUserDefaultsAndCashes()
                            }) : nil)
        .overlay(
            educationCategoryViewModel.isLoading ?
            GeometryReader { geometry in
                ZStack {
                    LoadingView(placHolder: NSLocalizedString("loading", comment: ""))
                        .frame(width: geometry.size.width, height: geometry.size.height)
                        .transition(.scale)
                } } : nil
        )
        .onDisappear(perform: {
            UserDefaultss().removeObject(forKey: "categoriesHomeTag")
            showStudentMainFromCategries = false
            showRegFromCategories = false
            clearStatesWithAction(valueState: &genralVm.dissapearView)

        })
        .refreshable {
            educationCategoryViewModel.getEducationCategoriesData(prevEducationCategoryToken: self.educationCategoryToken)
            
        }
        
    }
    var educationCategories : some View {
        ZStack {
            NavigationView {
                ScrollView {
                    LazyVGrid(columns: adaptiveColumns,spacing: 40) {
                        ForEach(educationCategoryViewModel.educationCategoryData,id: \.educationalCategoryToken) { node in
                            HStack {
                                Image("closed_book")
                                    .resizable()
                                    .frame(width: 35,height: 35)
                                
                                Text(node.educationalCategoryNameCurrent ?? NSLocalizedString("notFound", comment: ""))
                                    .font(
                                        Font.custom(Fonts().getFontLight(), size: 18)
                                            .weight(.bold)
                                    )
                                    .multilineTextAlignment(.center)
                                    .lineLimit(1)
                                    .foregroundColor(genralVm.isDark ? Color(Colors().darkCardText): Color(Colors().lightCardText))
                                
                            }
                            .padding(.horizontal, 46)
                            .padding(.top, 12)
                            .padding(.bottom, 16)
                            .frame(width: 350, alignment: .leading)
                            .background(genralVm.isDark ? Color(Colors().darkCardBgText): Color(Colors().lightCardBgText))
                            .cornerRadius(12)
                            .shadow(color:genralVm.isDark ? .white.opacity(0.25) : .gray.opacity(0.25), radius: 4, x: 0, y: 3)
                            .onTapGesture {
                                self.selectedEducationCategoryName = node.educationalCategoryNameCurrent ?? ""
                        
                                self.educationCategoryToken = node.educationalCategoryToken ?? ""
                                if (node.isHaveChildrenStatus!) {
                                    educationCategoryViewModel.getEducationCategoriesData(getParentEducationCategoryOnly:"false",prevEducationCategoryToken: "",educationCategoryToken:self.educationCategoryToken,getOnlyChildEducationalCategories:"true")
                                }else{
                                    self.educationCategoryToken = node.educationalCategoryToken ?? ""
                                    UserDefaults.standard.set(educationCategoryToken, forKey: "categoryToken")
                                    UserDefaultss().saveStrings(value: genralVm.constants.ROUTE_FROM_CATEGORIES_COURESE, key: genralVm.constants.KEY_ROUTE_COURSES)

                                    
                                    clearStatesWithAction(valueState: &showCatergoriesHomeFromCategories)
                                }
                            }
                            .onLongPressGesture(perform: {
                                self.educationCategoryToken = node.educationalCategoryToken ?? ""
                                clearStatesWithAction(valueState: &showAzDialogReservationAlert)
                            })
                        }
                    }
                }
                
                .toastView(toast: $toast)
                
                .refreshable {
                    educationCategoryViewModel.getEducationCategoriesData(prevEducationCategoryToken: self.educationCategoryToken)
                    
                }
            }
            if showLoading{
                LoadingView(placHolder: NSLocalizedString("loading", comment: ""))
            }
            
        }
    }
    
    
    
    
    
    private func requestJoin(educationCategory: String) {
        if Helper.isConnectedToNetwork() {
            if educationCategory.isEmpty {
                toast = Helper.showToast(style: .error, message: NSLocalizedString("error_education_category", comment: ""))
                return
            }
            
            callApi(educationCategory: educationCategory, preferdProviderToken: "", preferdPlaceToken: "" , knownMethodToken: "" )
            
            
        } else {
            toast = Helper.showToast(style: .error, message: NSLocalizedString("error_connected_to_network", comment: ""))
            return
        }
    }
    
    private func callApi(educationCategory: String,preferdProviderToken:String,preferdPlaceToken:String,knownMethodToken:String) {
        showLoading = true
        
        do {
            try Api().addJoiningApplication(authToken: self.genralVm.authToken, educationalCategoryToken: educationCategory, userStudentToken: self.genralVm.userToken, userPreferredServiceProviderToken: "", userPreferredPlaceToken: "", knownMethodToken: ""){(status , msg) in
                
                
                if status == self.genralVm.constants.STATUS_SUCCESS {
                    toast = Helper.showToast(style: .success, message: msg)
                    self.showLoading = false
                    
                    
                } else if status == self.genralVm.constants.STATUS_ERROR {
                    
                    self.showLoading = false
                    toast = Helper.showToast(style: .error, message: msg)
                    
                } else if status == self.genralVm.constants.STATUS_CATCH {
                    self.showLoading = false
                    toast = Helper.showToast(style: .error, message: msg)
                    
                } else if status == self.genralVm.constants.STATUS_NO_CONTENT {
                    self.showLoading = false
                    toast = Helper.showToast(style: .error, message: msg)
                    
                } else {
                    self.showLoading = false
                    toast = Helper.showToast(style: .error, message: msg)
                    
                }
            }
        } catch {
            
            toast = Helper.showToast(style: .error, message: error.localizedDescription)
            
        }
    }
    
    private func clearStatesWithAction(valueState: inout Bool) {
        valueState.toggle()
        UserDefaultss().removeObject(forKey: "categoriesHomeTag")
        showStudentMainFromCategries = false
        showRegFromCategories = false
    }
}

