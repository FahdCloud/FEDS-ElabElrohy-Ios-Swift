
import Foundation

class EducationCourseVm : ObservableObject {
    @Published var educationalCoursesData : [EducationalCourseVMDatum] = []
    @Published var genralVm : GeneralVm = GeneralVm()
    @Published var selectedTab: Int = 0
    @Published var isLoading : Bool = false
    @Published var noData : Bool = false
    @Published var showLogOut : Bool = false
    @Published var paginated : Bool = false
    @Published var msg : String = ""
    @Published var userToken : String = ""
    var totalPages = 1
    var currentPage = 1
    var approvalToken : String = ""
    
    
    func getCourses(ownedUserToken : String = "" , educationalCategoryToken: String = ""){
        self.isLoading = true
        do {
            let data = try JSONEncoder().encode(GeneralSearch())
            UserDefaults.standard.set(data, forKey: "apiData")
            do {
                let decoder = JSONDecoder()
                let data = try decoder.decode(GeneralSearch.self, from: data)
                data.userAuthorizeToken = self.genralVm.authToken
                data.paginationStatus = "true"
                data.pageSize = self.genralVm.constants.PAGE_SIZE
                data.userServiceProviderToken = genralVm.userProviderToken
                data.educationalCategoryToken = genralVm.categoryToken
                data.page = currentPage
                data.activationTypeTokens = "AST-17400"
                data.filterStatus = "true"
            
                
                do {
                    try Api().getEducationCourses(generalSearch:data ,onCompletion: { status, msg, data,pagination in
              
                        if status == self.genralVm.constants.STATUS_SUCCESS {
                            
                            self.isLoading = false
                            self.noData = false
                            self.totalPages = pagination.totalPages ?? 1
                            if !self.paginated {
                                self.educationalCoursesData = []
                            }
                            self.educationalCoursesData.append(contentsOf: data)
                         
                        } else if status == self.genralVm.constants.STATUS_INVALID_TOKEN ||
                                    status == self.genralVm.constants.STATUS_VERSION{
                            self.isLoading = false
                            self.msg = msg
                            self.showLogOut = true
                            Helper.removeUserDefaultsAndCashes()
                            UserDefaults.standard.set(msg, forKey: "logoutMsg")
                        }else {
                            self.isLoading = false
                            self.noData = true
                            self.msg = msg
                        }
                    })
                } catch {
                    self.isLoading = false
                    self.msg = error.localizedDescription
                }
                
            } catch {
                
            }
            
            
        } catch {
        }
    }
    
    
    func getMyCourses(ownedUserToken : String = "" , educationalCategoryToken: String = ""){
        self.isLoading = true
        do {
            let data = try JSONEncoder().encode(GeneralSearch())
            UserDefaults.standard.set(data, forKey: "apiData")
            do {
                let decoder = JSONDecoder()
                let data = try decoder.decode(GeneralSearch.self, from: data)
                data.userAuthorizeToken = self.genralVm.authToken
                data.paginationStatus = "true"
                data.pageSize = self.genralVm.constants.PAGE_SIZE
                data.page = currentPage
                data.activationTypeTokens = "AST-17400"
                data.filterStatus = "true"
                data.userServiceProviderToken = genralVm.userProviderToken
                data.educationalCategoryToken = genralVm.categoryToken
                
                data.userStudentToken = self.genralVm.userToken
                
                do {
                    try Api().getEducationCourses(generalSearch:data ,onCompletion: { status, msg, data,pagination in
              
                        if status == self.genralVm.constants.STATUS_SUCCESS {
                            self.isLoading = false
                            self.noData = false
                            self.totalPages = pagination.totalPages ?? 1
                            if !self.paginated {
                                self.educationalCoursesData = []
                            }
                            self.educationalCoursesData.append(contentsOf: data)
                         
                        } else if status == self.genralVm.constants.STATUS_INVALID_TOKEN ||
                                    status == self.genralVm.constants.STATUS_VERSION{
                            self.isLoading = false
                            self.msg = msg
                            self.showLogOut = true
                            Helper.removeUserDefaultsAndCashes()
                            UserDefaults.standard.set(msg, forKey: "logoutMsg")
                        }else {
                            self.isLoading = false
                            self.noData = true
                            self.msg = msg
                        }
                    })
                } catch {
                    self.isLoading = false
                    self.msg = error.localizedDescription
                }
                
            } catch {
                
            }
            
            
        } catch {
        }
    }
    
    func fetchMoreData() {
          guard currentPage < totalPages else { return }
          currentPage += 1
          getCourses()
      }
}
