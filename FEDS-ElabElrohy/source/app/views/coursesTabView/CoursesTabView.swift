import SwiftUI

struct CoursesTabView: View {
    @StateObject var educationCourseVm : EducationCourseVm = EducationCourseVm()
    @StateObject var genralVm: GeneralVm = GeneralVm()
    
    @State var isMyCoursesTab : Bool = false
    @State private var tabs: [TabTitWithImage] = []
    @State private var showStudentMainFromMyCourses: Bool = false
    @State private var showLecturersFormLecturerCourses: Bool = false
    @State private var showCategoriesFormCategoriesCourses: Bool = false
    @State private var showCategoriesLecturersFormCategoriesLecturerCourses: Bool = false
    @State private var currentParameter: Int = 0
    @State private var selectedTab = 0

    private let isCoursesRouteFrom = UserDefaultss().restoreString(key: Constants().KEY_ROUTE_COURSES)
    var body: some View {
        NavigationStack {
            VStack {
                HStack {
                    ForEach(tabs) { tab in
                        Button(action: {
                            selectedTab = tabs.firstIndex(where: { $0.id == tab.id }) ?? 0
                            saveCurrentParameterValue(for: selectedTab)
                            loadParameterValue(for: selectedTab)
                            updateIsMyCoursesTab(for: tabs[selectedTab].title)
                        }) {
                            VStack {
                                CustomIcon(imageName: tab.imageName,
                                           width: 30,
                                           height: 30,
                                           darkColor: selectedTab == tabs.firstIndex(where: { $0.id == tab.id }) ? Color(Colors().darkMenuIconUnSelected) : Color(Colors().darkMenuIconSelected),
                                           lightColor: selectedTab == tabs.firstIndex(where: { $0.id == tab.id }) ? Color(Colors().lightMenuIconUnSelected) : Color(Colors().lightMenuIconSelected))
                                
                                Text(tab.title)
                                    .foregroundStyle(selectedTab == tabs.firstIndex(where: { $0.id == tab.id }) ?
                                                     (genralVm.isDark ? Color(Colors().darkMenuIconUnSelected) : Color(Colors().lightMenuIconUnSelected)) :
                                                        (genralVm.isDark ? Color(Colors().darkMenuIconSelected) : Color(Colors().lightMenuIconSelected)))
                                    .font(
                                        Font.custom(Fonts().getFontBold(), size: 20)
                                            .weight(.bold)
                                    )
                                // bottom line to show selected tab
                                Rectangle()
                                    .fill(selectedTab == tabs.firstIndex(where: { $0.id == tab.id }) ?
                                          (genralVm.isDark ? Color(Colors().darkToolbarSelected) : Color(Colors().lightToolbarSelected)) :
                                            Color.clear)
                                    .frame(height: 5)
                            }
                        }
                        .frame(maxWidth: .infinity)
                    }
                }
                .ignoresSafeArea()
                .padding(.top)
                .background(genralVm.isDark ? Color(Colors().darkBtnMenu): Color(Colors().lightBtnMenu))
                
                TabView(selection: $selectedTab) {
                   
                    OnlineContentView()
                        .tag(0)
                        
                    OnlineContentView()
                        .tag(1)
                       
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))  // Hide default page indicators
            }
            .onAppear {
                UserDefaultss().removeObject(forKey: "educationalCourseInfoData")
                setupTabs()
                loadParameterValue(for: selectedTab)
                updateIsMyCoursesTab(for: tabs[selectedTab].title)
               
                switch (isCoursesRouteFrom) {
                    
                case genralVm.constants.ROUTE_FROM_MAIN_PAGE ,
                     genralVm.constants.ROUTE_FROM_MY_COURSES :
                    UserDefaultss().removeObject(forKey: "userProviderToken")
                    UserDefaultss().removeObject(forKey: "categoryToken")
                    break
                    
                case genralVm.constants.ROUTE_FROM_CATEGORIES_COURESE :
                    UserDefaultss().removeObject(forKey: "userProviderToken")
                    break
                    
                case genralVm.constants.ROUTE_FROM_LECTUERES_COURSES :
                    UserDefaultss().removeObject(forKey: "categoryToken")
                    break

                default:
                        UserDefaultss().removeObject(forKey: "userProviderToken")
                        UserDefaultss().removeObject(forKey: "categoryToken")    
                    break
                    
                }
            }
            .toolbar {
                if isCoursesRouteFrom != genralVm.constants.ROUTE_FROM_MAIN_PAGE {
                    ToolbarItem(placement: .navigationBarLeading) {
                        CustomBackButton(){
                            
                            switch (isCoursesRouteFrom) {
                            case genralVm.constants.ROUTE_FROM_MY_COURSES :
                                clearStatesWithAction(valueState: &showStudentMainFromMyCourses)
                               

                                break
                                
                            case genralVm.constants.ROUTE_FROM_CATEGORIES_COURESE :
                                clearStatesWithAction(valueState: &showCategoriesFormCategoriesCourses)
                                break
                                
                            case genralVm.constants.ROUTE_FROM_LECTUERES_COURSES :
                                clearStatesWithAction(valueState: &showLecturersFormLecturerCourses)
                                break
                                
                            case genralVm.constants.ROUTE_FROM_CATEGORIES_LECTUERES_COURESE :
                                clearStatesWithAction(valueState: &showCategoriesLecturersFormCategoriesLecturerCourses)
                                break
                                
                            default:
                                clearStatesWithAction(valueState: &showStudentMainFromMyCourses)
                                break
                                
                            }
                            UserDefaultss().saveStrings(value: genralVm.constants.ROUTE_FROM_MAIN_PAGE, key: genralVm.constants.KEY_ROUTE_COURSES)
                        }
                    }
                }
            }
        }
        .background(genralVm.isDark ? Color(Colors().darkBodyBg): Color(Colors().lightBodyBg))
        .ipad()
        .navigationViewStyle(StackNavigationViewStyle())
        .fullScreenCover(isPresented: $showStudentMainFromMyCourses, content: {
            StudentMainTabView()
        })
        .fullScreenCover(isPresented: $showCategoriesFormCategoriesCourses, content: {
            CategoriesView()
        })
        .fullScreenCover(isPresented: $showLecturersFormLecturerCourses, content: {
            LecturersView()
        })
        .fullScreenCover(isPresented: $showCategoriesLecturersFormCategoriesLecturerCourses, content: {
            CategoriesLecturersView()
        })
    }
    
    private func clearStatesWithAction(valueState: inout Bool) {
        valueState.toggle()
        showStudentMainFromMyCourses = false
        showLecturersFormLecturerCourses = false
        showCategoriesFormCategoriesCourses = false
        showCategoriesLecturersFormCategoriesLecturerCourses = false
    }
    private func saveCurrentParameterValue(for tab: Int) {
        UserDefaultss().saveInt(value: tab, key: "currentTabCourses")
    }
    
    private func loadParameterValue(for tab: Int) {
        currentParameter = UserDefaultss().restoreInt(key: "currentTabCourses")
    }
    
    private func setupTabs() {
        if isCoursesRouteFrom == genralVm.constants.ROUTE_FROM_MY_COURSES {
            tabs = [
                TabTitWithImage(title: NSLocalizedString("myCourses", comment: ""), imageName: "studentCoursesIcon"),
                TabTitWithImage(title: NSLocalizedString("courses", comment: ""), imageName: "courses")
            ]
        } else {
            tabs = [
                TabTitWithImage(title: NSLocalizedString("courses", comment: ""), imageName: "courses"),
                TabTitWithImage(title: NSLocalizedString("myCourses", comment: ""), imageName: "studentCoursesIcon")
            ]
        }
    }
    
    private func updateIsMyCoursesTab(for title: String) {
        if title.lowercased() == NSLocalizedString("myCourses", comment: "").lowercased() {
            isMyCoursesTab  = true
            UserDefaultss().saveBool(value: isMyCoursesTab, key: "isMyCoursesTab")

        } else {
            isMyCoursesTab = false
            UserDefaultss().saveBool(value: isMyCoursesTab, key: "isMyCoursesTab")

        }
    }
}
