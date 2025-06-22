//
//  Api.swift
//  FPLS-Dev
//
//  Created by Omar pakr on 03/09/2023.
//

import Foundation
import Alamofire

class Api {
    
    
    let baseUrl = URL(string: Constants().BASE_URL + Constants().BASE_URL_API)!
    
    let apiAppData = APIAppData()
    let userVersion = UsersVersion()
    let userEducationalGroupScheduleTimesDatum = [UserEducationalGroupScheduleTimesDatum]()
    let pagination = Pagination()
    let constant = Constants()
    let ApiDataCheckUser = APIAppDataCheckUser()
    let users = [UsersDatum]()
    let places = [TreesData]()
    let knownMethodsDatum = [KnownMethodsDatum]()
    let educationJoiningApplication = [EducationalJoiningApplicationsDatum]()
    let educationalStudentGroupsData = [EducationalGroupStudentsDatum]()
    let educationalGroupAttendancesData = [EducationalGroupAttendancesDatum]()
    let educationalStudentCoursesData = [EducationalCourseStudentsDatum]()
    let joiningApplicationData = [LastJoiningApplicationSubscription]()
    let educationGroupTimesMedia = [SystemMediaDatum]()
    let studentExamInfoData = [StudentExamInfoDatum]()
    let examParagraphsInfoData = [ExamParagraphsInfoData]()
    let newsData = [NewsArticlesDatum]()
    let startStudentExamData = ExamPargraphInfo()
    let studentExamInfoDataReview = ExamReviewInfoData()
    let educationalJoiningApplicationsStatistics = EducationalJoiningApplicationsStatistics()
    let teacherCodeAvailablePricesStatistics = [TeacherCodeAvailablePricesStatistic]()
    let teacherCodeData = [TeacherCodesDatum]()
    let educationalGroupsData = [EducationalGroupsDatum]()
    let teacherCodeStatistics = TeacherCodeStatistics()
    let notificationData = [NotificationsDatum]()
    let userDetails = UserDetails()
    let userAppSettingData = UserAppSetting()
    let appSetting = GetAppSettingModel()
    let educationalJoiningApplicationDetails = EducationalJoiningApplication()
    let educationalGroupsDataModel = [EducationalGroupsData]()
    let educationalCategoriesData = [EducationalCategoriesDatum]()
    let systemMediaData = [SystemMediaData]()
    let treeData = [TreesDatum]()
    let educationalCoursesData = [EducationalCourseVMDatum]()
    let educationalCourseDetails = EducationalCourseInfoData()
    let userFinanceStatisticData = UserFinanceStatisticData()
    let userWalletTransactionsData = [UserWalletTransactionsDatum]()
    let academicYearsData = [ItemsDatum]()
    let centerPlaces = [ItemsDatum]()
    let constantsList = ConstantsListsDataa()
    
    

    
    
    func getEducationalCategory(generalSearch : GeneralSearch ,onCompletion: @escaping (Int, String,[TreesDatum])->()) throws{
        
        let header = HTTPHeaders(["userAuthorizeToken":generalSearch.userAuthorizeToken!])
    
        AF.request(Api().baseUrl.absoluteString + "EducationalCategories/GetTrees" , method: .get,parameters: apiHelper.getGenralDataSearch(generalSearch: generalSearch),headers: header)
          .validate()
          .responseDecodable(of: EducationCategoryTreeModel.self){ (response) in
              if response.response?.statusCode == 200{
                  guard let data = response.value else {
                      onCompletion(self.constant.STATUS_ERROR,NSLocalizedString("message_error_in_fetching_data", comment: "") , self.treeData)
                      return
                  }
                  onCompletion(data.status!,data.msg! ,data.treesData ?? self.treeData)
              } else {
                  onCompletion(self.constant.STATUS_ERROR,NSLocalizedString("message_error_in_fetching_data", comment: "") , self.treeData)
            }
        }
    }
    
    func addEducationCatgeoryJoiningApplication(authToken : String , educationCategoryToken : String , userStudentToken : String , userPreferredServiceProviderToken : String , knownMethodToken : String,onCompletion: @escaping (Int, String)->()) throws {
        let params : [String : Any] = ["educationalCategoryToken":educationCategoryToken,
                                      "userStudentToken":userStudentToken,
                                      "userPreferredServiceProviderToken" : userPreferredServiceProviderToken,
                                      "knownMethodToken":knownMethodToken]
        
        let header = HTTPHeaders(["userAuthorizeToken":authToken])
        
        AF.request(Api().baseUrl.absoluteString + "EducationalJoiningApplications/AddEducationalJoiningApplication" , method: .post,parameters: params,headers: header)
          .validate()
          .responseDecodable(of: GeneralModel.self){ (response) in
              if response.response?.statusCode == 200{
                  guard let data = response.value else {
                      onCompletion(self.constant.STATUS_ERROR,NSLocalizedString("message_error_in_fetching_data", comment: ""))
                      return
                  }
                  onCompletion(data.status!,data.msg!)
              } else {
                  onCompletion(self.constant.STATUS_ERROR,NSLocalizedString("message_error_in_fetching_data", comment: ""))
            }
        }

    }
    
    
    func login(statusEncoding :Bool,data : logData ,onCompletion: @escaping (Int, String, UsersVersion,APIAppData) -> ()) throws {
        var json = ""
        if statusEncoding == true {
            let jsonEncoder = JSONEncoder()
            let jsonData = try jsonEncoder.encode(data)
            json = String(data: jsonData, encoding: String.Encoding.utf8)!
        }
        var request = URLRequest(url: URL(string: Api().baseUrl.absoluteString + "UsersAuthentication/UserLogin")!)
        request.httpMethod = HTTPMethod.post.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let data = (json.data(using: .utf8))! as Data
        request.httpBody = data
        AF.request(request)
            .responseDecodable(of:  LogineModel.self){ (response) in
                
                if response.response?.statusCode == 200 {
                    guard let data = response.value else {
                        onCompletion(Constants().STATUS_ERROR,NSLocalizedString("message_error_in_fetching_data", comment: ""), self.userVersion, self.apiAppData)
                        return
                    }
                    onCompletion(data.status! , data.msg! , data.usersVersion ?? self.userVersion , data.apiAppData ?? self.apiAppData)
                } else {
                    onCompletion(Constants().STATUS_ERROR,NSLocalizedString("message_error_in_fetching_data", comment: ""), self.userVersion, self.apiAppData)
                    
                }
            }
    }
    
    func signUpWithImage(registrationModule :String ,mediaFile : Data, onCompletion: @escaping (Int, String, UsersVersion,APIAppData) -> ())throws{
        let params = ["registrationModule": registrationModule]
        let fullUrl =  baseUrl.absoluteString + "UsersAuthentication/UserSignUp"
        var urlRequest = try! URLRequest(url: URL(string:fullUrl)!, method: .post)
        urlRequest.timeoutInterval = 860000
        AF.upload(
            multipartFormData: { multipartFormData in
                multipartFormData.append((params["registrationModule"]?.data(using: .utf8))!, withName: "registrationModule")
                multipartFormData.append(mediaFile, withName: "mediaFile", fileName: UUID().uuidString + ".png", mimeType: "image/*")
            }, with: urlRequest)
        .responseDecodable(of:  LogineModel.self){ (response) in
            if response.response?.statusCode == 200 {
                guard let data = response.value else {
                    onCompletion(Constants().STATUS_ERROR,NSLocalizedString("message_error_in_fetching_data", comment: ""), self.userVersion, self.apiAppData)
                    return
                    
                }
                onCompletion(data.status! , data.msg! , data.usersVersion ?? self.userVersion , data.apiAppData ?? self.apiAppData)
            } else{
                onCompletion(Constants().STATUS_ERROR,NSLocalizedString("message_error_in_fetching_data", comment: ""), self.userVersion, self.apiAppData)
                
            }
        }
    }
    
    
    func signUp(registrationModule :String , onCompletion: @escaping (Int, String, UsersVersion,APIAppData) -> ())throws{
        let params = ["registrationModule": registrationModule]
        
        AF.request(Api().baseUrl.absoluteString + "UsersAuthentication/UserSignUp" , method: .post,parameters:params)
            .validate()
            .responseDecodable(of: LogineModel.self){ (response) in
                if response.response?.statusCode == 200 {
                    guard let data = response.value else {
                        onCompletion(Constants().STATUS_ERROR,NSLocalizedString("message_error_in_fetching_data", comment: ""), self.userVersion, self.apiAppData)
                        return
                    }
                    onCompletion(data.status! , data.msg! , data.usersVersion ?? self.userVersion , data.apiAppData ?? self.apiAppData)
                } else{
                    onCompletion(Constants().STATUS_ERROR,NSLocalizedString("message_error_in_fetching_data", comment: ""), self.userVersion, self.apiAppData)
                    
                }
            }
    }
    
    func checkUser(languageToken : String , userEmailOrPhone:String, onCompletion: @escaping (Int, String,APIAppData) -> ()) throws{
        let header = HTTPHeaders(["userAuthorizeToken":""])
        let params = ["languageToken":languageToken,
                      "userEmailOrPhone" : userEmailOrPhone]
        AF.request(Api().baseUrl.absoluteString + "UsersForgetPassword/CheckUser" , method: .post,parameters: params ,headers: header)
            .validate()
            .responseDecodable(of: CheckUserModel.self){ (response) in
                if response.response?.statusCode == 200{
                    guard let data = response.value else {
                     onCompletion(self.constant.STATUS_ERROR,NSLocalizedString("message_error_in_fetching_data", comment: ""),self.apiAppData)
                        return
                    }
                    onCompletion(data.status!,data.msg!,data.apiAppData ?? self.apiAppData)
                } else {
                  onCompletion(self.constant.STATUS_ERROR,NSLocalizedString("message_error_in_fetching_data", comment: ""),self.apiAppData)
                }
            }
    }
    
//    func verifyForgetPassCode(languageToken : String , userToken:String,  verificationCode:String, onCompletion: @escaping (Int, String,APIAppDataCheckUser) -> ()) throws{
//        let header = HTTPHeaders(["userAuthorizeToken":""])
//        let params = ["languageToken":languageToken,
//                      "userToken":userToken,
//                      "verificationCode" : verificationCode]
//        AF.request(Api().baseUrl.absoluteString + "UsersForgetPassword/VerifyCode" , method: .post,parameters: params ,headers: header)
//            .validate()
//            .responseDecodable(of: CheckUserModel.self){ (response) in
//                if response.response?.statusCode == 200{
//                    guard let data = response.value else {
//                     onCompletion(self.constant.STATUS_ERROR,NSLocalizedString("message_error_in_fetching_data", comment: ""),self.ApiDataCheckUser)
//                        return
//                    }
//                    onCompletion(data.status!,data.msg!,data.apiAppData ?? self.ApiDataCheckUser)
//                } else {
//                  onCompletion(self.constant.STATUS_ERROR,NSLocalizedString("message_error_in_fetching_data", comment: ""),self.ApiDataCheckUser)
//                }
//            }
//    }
    
    func verifyForgetPassCode(languageToken : String, userToken:String ,verificationCode : String ,onCompletion: @escaping (Int, String)->()) throws{
        let header = HTTPHeaders(["userAuthorizeToken":""])
        let params = ["languageToken":languageToken,
                      "userToken":userToken,
                      "verificationCode" : verificationCode]
    
    AF.request( Api().baseUrl.absoluteString + "UsersForgetPassword/VerifyCode" , method: .post, parameters:params,headers: header)
        .validate()
        .responseDecodable(of: GeneralModel.self){ (response) in
            if response.response?.statusCode == 200{
                guard let data = response.value else {
                    onCompletion(self.constant.STATUS_ERROR,NSLocalizedString("message_error_in_fetching_data", comment: ""))
                    return
                }
                onCompletion(data.status!,data.msg!)
            } else {
                onCompletion(self.constant.STATUS_ERROR,NSLocalizedString("message_error_in_fetching_data", comment: ""))
            }
        }
}
    
    func changePassword(userAuthorizeToken : String ,userToken:String ,userPassword : String,languageToken : String ,onCompletion: @escaping (Int, String)->()) throws{
        let header = HTTPHeaders(["userAuthorizeToken":userAuthorizeToken])
        let params : [String : Any] = ["language":languageToken,
                                       "userToken":userToken,
                                       "userPassword":userPassword]
        
        AF.request( Api().baseUrl.absoluteString + "UsersAuthentication/ChangeUserPassword" , method: .post, parameters:params,headers: header)
            .validate()
            .responseDecodable(of: GeneralModel.self){ (response) in
                print("1")
                print(response)
                print(params)
                if response.response?.statusCode == 200{
                    guard let data = response.value else {
                        onCompletion(self.constant.STATUS_ERROR,NSLocalizedString("message_error_in_fetching_data", comment: ""))
                        return
                    }
                    onCompletion(data.status!,data.msg!)
                } else {
                    onCompletion(self.constant.STATUS_ERROR,NSLocalizedString("message_error_in_fetching_data", comment: ""))
                }
            }
    }

    
    func forgetPassCheckUser(languageToken : String , userEmailOrPhone:String ,onCompletion: @escaping (Int, String)->()) throws{
    let params : [String : Any] = ["languageToken":languageToken,
                                   "userEmailOrPhone":userEmailOrPhone
                                   ]
    
    AF.request( Api().baseUrl.absoluteString + "UsersForgetPassword/CheckUser" , method: .post, parameters:params)
        .validate()
        .responseDecodable(of: GeneralModel.self){ (response) in
            if response.response?.statusCode == 200{
                guard let data = response.value else {
                    onCompletion(self.constant.STATUS_ERROR,NSLocalizedString("message_error_in_fetching_data", comment: ""))
                    return
                }
                onCompletion(data.status!,data.msg!)
            } else {
                onCompletion(self.constant.STATUS_ERROR,NSLocalizedString("message_error_in_fetching_data", comment: ""))
            }
        }
}

    
    //MARK: - Groups
    
    func getEducationalGroupScheduleTimes(generalSearch : GeneralSearch ,onCompletion: @escaping (Int, String,[UserEducationalGroupScheduleTimesDatum],Pagination)->()) throws{
        let header = HTTPHeaders(["userAuthorizeToken":generalSearch.userAuthorizeToken!])
        
        AF.request(Api().baseUrl.absoluteString + "EducationalGroupScheduleTimes/EnquiryOfStudentGroupsScheduleTimes" , method: .get,parameters: apiHelper.getGenralDataSearch(generalSearch: generalSearch),headers: header)
            .validate()
            .responseDecodable(of: EducationalGroupScheduleTimes.self){ (response) in
                if response.response?.statusCode == 200{
                    guard let data = response.value else {
                        onCompletion(self.constant.STATUS_ERROR,NSLocalizedString("message_error_in_fetching_data", comment: "") , self.userEducationalGroupScheduleTimesDatum,self.pagination)
                        return
                    }
                    onCompletion(data.status!,data.msg! ,data.userEducationalGroupScheduleTimesData ?? self.userEducationalGroupScheduleTimesDatum,data.pagination ?? self.pagination)
                } else {
                    onCompletion(self.constant.STATUS_ERROR,NSLocalizedString("message_error_in_fetching_data", comment: "") , self.userEducationalGroupScheduleTimesDatum,self.pagination)
                }
            }
    }
    
    
    func getEducationalGroupScheduleTimesMedia(generalSearch : GeneralSearch ,onCompletion: @escaping (Int, String,[SystemMediaDatum],Pagination)->()) throws{
        let header = HTTPHeaders(["userAuthorizeToken":generalSearch.userAuthorizeToken!])
        
        AF.request(Api().baseUrl.absoluteString + "SystemMedias/GetAllSystemMedias" , method: .get,parameters: apiHelper.getGenralDataSearch(generalSearch: generalSearch),headers: header)
            .validate()
            .responseDecodable(of: EducationGroueTimeMediaModel.self){ (response) in
                if response.response?.statusCode == 200{
                    guard let data = response.value else {
                        onCompletion(self.constant.STATUS_ERROR,NSLocalizedString("message_error_in_fetching_data", comment: "") , self.educationGroupTimesMedia,self.pagination)
                        return
                    }
                    onCompletion(data.status!,data.msg! ,data.systemMediaData ?? self.educationGroupTimesMedia,data.pagination ?? self.pagination)
                } else {
                    onCompletion(self.constant.STATUS_ERROR,NSLocalizedString("message_error_in_fetching_data", comment: "") , self.educationGroupTimesMedia,self.pagination)
                }
            }
    }
    
    func getAllGroups(generalSearch : GeneralSearch ,onCompletion: @escaping (Int, String,[EducationalGroupsDatum],Pagination)->()) throws{
        let header = HTTPHeaders(["userAuthorizeToken":generalSearch.userAuthorizeToken!])
        
        AF.request(Api().baseUrl.absoluteString + "EducationalGroups/GetAllEducationalGroups" , method: .get,parameters: apiHelper.getGenralDataSearch(generalSearch: generalSearch),headers: header)
            .validate()
            .responseDecodable(of: GetAllTeacherGroupsModel.self){ (response) in
                if response.response?.statusCode == 200{
                    guard let data = response.value else {
                        onCompletion(self.constant.STATUS_ERROR,NSLocalizedString("message_error_in_fetching_data", comment: "") , self.educationalGroupsData,self.pagination)
                        return
                    }
                    onCompletion(data.status!,data.msg! ,data.educationalGroupsData ?? self.educationalGroupsData,data.pagination ?? self.pagination)
                } else {
                    onCompletion(self.constant.STATUS_ERROR,NSLocalizedString("message_error_in_fetching_data", comment: "") , self.educationalGroupsData,self.pagination)
                }
            }
    }
    
    
    //MARK: - Add Joining application
    
    func addJoiningApplication(authToken:String,educationalCategoryToken : String ,  userStudentToken:String,userPreferredServiceProviderToken:String,userPreferredPlaceToken:String,knownMethodToken:String,onCompletion: @escaping (Int, String)->()) throws {
        let header = HTTPHeaders(["userAuthorizeToken":authToken])
        let params : [String : Any] = ["educationalCategoryToken" : educationalCategoryToken ,
                                       "userStudentToken":userStudentToken,
                                       "userPreferredServiceProviderToken":userPreferredServiceProviderToken,
                                       "userPreferredPlaceToken":userPreferredPlaceToken,
                                       "knownMethodToken":knownMethodToken,
                                       "canRelatedTypeToken" : self.constant.CANRELATED_TYPE_YES]
        AF.request(Api().baseUrl.absoluteString + "EducationalJoiningApplications/AddEducationalJoiningApplication" , method: .post,parameters: params,headers: header)
            .validate()
            .responseDecodable(of: GeneralModel.self){ (response) in
                if response.response?.statusCode == 200{
                    guard let data = response.value else {
                        onCompletion(self.constant.STATUS_ERROR,NSLocalizedString("message_error_in_fetching_data", comment: ""))
                        return
                    }
                    onCompletion(data.status!,data.msg!)
                } else {
                    onCompletion(self.constant.STATUS_ERROR,NSLocalizedString("message_error_in_fetching_data", comment: ""))
                }
            }
        
    }
    
    //MARK: - Get provider
    func getUserOfEducationCategory(generalSearch : GeneralSearch ,onCompletion: @escaping (Int, String,[UsersDatum],Pagination)->()) throws{
        let header = HTTPHeaders(["userAuthorizeToken":generalSearch.userAuthorizeToken!])
        
        AF.request(Api().baseUrl.absoluteString + "Users/GetAllUsers" , method: .get,parameters: apiHelper.getGenralDataSearch(generalSearch: generalSearch),headers: header)
            .validate()
            .responseDecodable(of: Users.self){ (response) in
                if response.response?.statusCode == 200{
                    guard let data = response.value else {
                        onCompletion(self.constant.STATUS_ERROR,NSLocalizedString("message_error_in_fetching_data", comment: "") , self.users,self.pagination)
                        return
                    }
                    onCompletion(data.status!,data.msg! ,data.usersData ?? self.users,data.pagination ?? self.pagination)
                } else {
                    onCompletion(self.constant.STATUS_ERROR,NSLocalizedString("message_error_in_fetching_data", comment: "") , self.users,self.pagination)
                }
            }
    }
    
    func getUsers(authToken:String,activationTypeTokens : String ,  userTypeToken:String,filterStatus:String,paginationStatus:String,userEducationlInterestToken:String ,onCompletion: @escaping (Int, String,[UsersDatum],Pagination)->()) throws{
        
        let header = HTTPHeaders(["userAuthorizeToken":authToken])
        let params : [String : Any] = ["activationTypeTokens" : activationTypeTokens ,
                                       "userTypeToken":userTypeToken,
                                       "filterStatus":filterStatus,
                                       "paginationStatus":paginationStatus,
                                       "userEducationalInterestToken":userEducationlInterestToken
                                       ]
        
        AF.request(Api().baseUrl.absoluteString + "Users/GetAllUsers" , method: .get,parameters: params,headers: header)
            .validate()
            .responseDecodable(of: Users.self){ (response) in
                if response.response?.statusCode == 200{
                    guard let data = response.value else {
                        onCompletion(self.constant.STATUS_ERROR,NSLocalizedString("message_error_in_fetching_data", comment: "") , self.users,self.pagination)
                        return
                    }
                    onCompletion(data.status!,data.msg! ,data.usersData ?? self.users,data.pagination ?? self.pagination)
                } else {
                    onCompletion(self.constant.STATUS_ERROR,NSLocalizedString("message_error_in_fetching_data", comment: "") , self.users,self.pagination)
                }
            }
    }
    
    func getUserDetails(userAuthorizeToken:String,token:String ,onCompletion: @escaping (Int, String,UserDetails)->()) throws{
        
        let header = HTTPHeaders(["userAuthorizeToken":userAuthorizeToken])
        let params = ["token":token]
        
        AF.request(Api().baseUrl.absoluteString + "Users/GetUserDetails" , method: .get,parameters: params,headers: header)
            .validate()
            .responseDecodable(of: GetUserDetailsModel.self){ (response) in
                if response.response?.statusCode == 200{
                    guard let data = response.value else {
                        onCompletion(self.constant.STATUS_ERROR,NSLocalizedString("message_error_in_fetching_data", comment: "") ,self.userDetails)
                        return
                    }
                    onCompletion(data.status!,data.msg! ,data.user ?? self.userDetails)
                } else {
                    onCompletion(self.constant.STATUS_ERROR,NSLocalizedString("message_error_in_fetching_data", comment: "") , self.userDetails)
                }
            }
    }

    
    //MARK: - Get Places
    func getPlaces(authToken:String ,onCompletion: @escaping (Int, String,[TreesData])->()) throws{
        let header = HTTPHeaders(["userAuthorizeToken":authToken])
        let params = ["activationTypeTokens":"AST-17400"]
        
        AF.request(Api().baseUrl.absoluteString + "Places/GetTrees" , method: .get,parameters: params,headers: header)
            .validate()
            .responseDecodable(of: PlaceTree.self){ (response) in
                if response.response?.statusCode == 200{
                    guard let data = response.value else {
                        onCompletion(self.constant.STATUS_ERROR,NSLocalizedString("message_error_in_fetching_data", comment: "") , self.places)
                        return
                    }
                    onCompletion(data.status!,data.msg! ,data.treesData ?? self.places)
                } else {
                    onCompletion(self.constant.STATUS_ERROR,NSLocalizedString("message_error_in_fetching_data", comment: "") , self.places)
                }
            }
    }
    
    //MARK: - Get Known method
    func getKnowMethod(authToken:String ,onCompletion: @escaping (Int, String,[KnownMethodsDatum])->()) throws{
        let header = HTTPHeaders(["userAuthorizeToken":authToken])
        let params : [String : Any] = ["paginationStatus":"false",
                                       "activationTypeTokens":"AST-17400"]
        
        AF.request(Api().baseUrl.absoluteString + "KnownMethods/GetAllKnownMethods" , method: .get,parameters: params,headers: header)
            .validate()
            .responseDecodable(of: KnownMethodModel.self){ (response) in
                if response.response?.statusCode == 200{
                    guard let data = response.value else {
                        onCompletion(self.constant.STATUS_ERROR,NSLocalizedString("message_error_in_fetching_data", comment: "") , self.knownMethodsDatum)
                        return
                    }
                    onCompletion(data.status!,data.msg! ,data.knownMethodsData ?? self.knownMethodsDatum)
                } else {
                    onCompletion(self.constant.STATUS_ERROR,NSLocalizedString("message_error_in_fetching_data", comment: "") , self.knownMethodsDatum)
                }
            }
    }
    
    //MARK: - Get Joining applications
    
    func getEducationJoiningApplication(generalSearch:GeneralSearch ,onCompletion: @escaping (Int, String,[EducationalJoiningApplicationsDatum],Pagination,EducationalJoiningApplicationsStatistics)->()) throws{
        let header = HTTPHeaders(["userAuthorizeToken":generalSearch.userAuthorizeToken!])
        
        AF.request(Api().baseUrl.absoluteString + "EducationalJoiningApplications/GetAllEducationalJoiningApplications" , method: .get,parameters: apiHelper.getGenralDataSearch(generalSearch: generalSearch),headers: header)
            .validate()
            .responseDecodable(of: JoiningApplicationModel.self){ (response) in
                if response.response?.statusCode == 200{
                    guard let data = response.value else {
                        onCompletion(self.constant.STATUS_ERROR,NSLocalizedString("message_error_in_fetching_data", comment: "") , self.educationJoiningApplication,self.pagination,self.educationalJoiningApplicationsStatistics)
                        return
                    }
                    onCompletion(data.status!,data.msg! ,data.educationalJoiningApplicationsData ?? self.educationJoiningApplication,data.pagination ?? self.pagination,data.educationalJoiningApplicationsStatistics ?? self.educationalJoiningApplicationsStatistics)
                } else {
                    onCompletion(self.constant.STATUS_ERROR,NSLocalizedString("message_error_in_fetching_data", comment: "") , self.educationJoiningApplication,self.pagination,self.educationalJoiningApplicationsStatistics)
                }
            }
    }
    
    func getEducationJoiningApplicationDetails(userAuthorizeToken:String,token :String,onCompletion: @escaping (Int, String,EducationalJoiningApplication)->()) throws{
        let header = HTTPHeaders(["userAuthorizeToken":userAuthorizeToken])
        let params = ["token" : token]
        
        AF.request(Api().baseUrl.absoluteString + "EducationalJoiningApplications/GetEducationalJoiningApplicationDetails" , method: .get,parameters: params,headers: header)
            .validate()
            .responseDecodable(of: JoiningAppDetails.self){ (response) in
                if response.response?.statusCode == 200{
                    guard let data = response.value else {
                        onCompletion(self.constant.STATUS_ERROR,NSLocalizedString("message_error_in_fetching_data", comment: "") , self.educationalJoiningApplicationDetails)
                        return
                    }
                    onCompletion(data.status!,data.msg! ,data.educationalJoiningApplication ?? self.educationalJoiningApplicationDetails)
                } else {
                    onCompletion(self.constant.STATUS_ERROR,NSLocalizedString("message_error_in_fetching_data", comment: "") ,self.educationalJoiningApplicationDetails)
                }
            }
    }
    
    func getJoiningApplicationSubscription(generalSearch:GeneralSearch ,onCompletion: @escaping (Int, String,[LastJoiningApplicationSubscription],Pagination)->()) throws{
        let header = HTTPHeaders(["userAuthorizeToken":generalSearch.userAuthorizeToken!])
        
        AF.request(Api().baseUrl.absoluteString + "JoiningApplicationSubscriptions/GetAllJoiningApplicationSubscriptions" , method: .get,parameters: apiHelper.getGenralDataSearch(generalSearch: generalSearch),headers: header)
            .validate()
            .responseDecodable(of: JoiningApplicationSubscriptionModel.self){ (response) in
                if response.response?.statusCode == 200{
                    guard let data = response.value else {
                        onCompletion(self.constant.STATUS_ERROR,NSLocalizedString("message_error_in_fetching_data", comment: "") , self.joiningApplicationData,self.pagination)
                        return
                    }
                    onCompletion(data.status!,data.msg! ,data.joiningApplicationSubscriptionsData ?? self.joiningApplicationData,data.pagination ?? self.pagination)
                } else {
                    onCompletion(self.constant.STATUS_ERROR,NSLocalizedString("message_error_in_fetching_data", comment: "") , self.joiningApplicationData,self.pagination)
                }
            }
    }
    
    
    
    func getStudentEducationCourses(generalSearch:GeneralSearch ,onCompletion: @escaping (Int, String,[EducationalCourseStudentsDatum],Pagination)->()) throws {
        let header = HTTPHeaders(["userAuthorizeToken":generalSearch.userAuthorizeToken!])
        
        AF.request(Api().baseUrl.absoluteString + "EducationalCourseStudents/GetAllEducationalCourseStudents" , method: .get,parameters: apiHelper.getGenralDataSearch(generalSearch: generalSearch),headers: header)
            .validate()
            .responseDecodable(of: GetStudentCoursesModel.self){ (response) in
                if response.response?.statusCode == 200{
                    guard let data = response.value else {
                        onCompletion(self.constant.STATUS_ERROR,NSLocalizedString("message_error_in_fetching_data", comment: "") , self.educationalStudentCoursesData,self.pagination)
                        return
                    }
                    onCompletion(data.status!,data.msg! ,data.educationalCourseStudentsData ?? self.educationalStudentCoursesData,data.pagination ?? self.pagination)
                } else {
                    onCompletion(self.constant.STATUS_ERROR,NSLocalizedString("message_error_in_fetching_data", comment: "") , self.educationalStudentCoursesData,self.pagination)
                }
            }
    }
    

    
    //MARK: - Educational Groups
    
    func getStudentEduactionGroups(generalSearch:GeneralSearch  ,onCompletion: @escaping (Int, String,[EducationalGroupStudentsDatum],Pagination)->()) throws{
        let header = HTTPHeaders(["userAuthorizeToken":generalSearch.userAuthorizeToken!])
        
        AF.request(Api().baseUrl.absoluteString + "EducationalGroupStudents/GetEducationalGroupStudents" , method: .get,parameters: apiHelper.getGenralDataSearch(generalSearch: generalSearch),headers: header)
            .validate()
            .responseDecodable(of: EducationGroupModel.self){ (response) in
                if response.response?.statusCode == 200{
                    guard let data = response.value else {
                        onCompletion(self.constant.STATUS_ERROR,NSLocalizedString("message_error_in_fetching_data", comment: "") , self.educationalStudentGroupsData,self.pagination)
                        return
                    }
                    onCompletion(data.status!,data.msg! ,data.educationalGroupStudentsData ?? self.educationalStudentGroupsData,data.pagination ?? self.pagination)
                } else {
                    onCompletion(self.constant.STATUS_ERROR,NSLocalizedString("message_error_in_fetching_data", comment: "") , self.educationalStudentGroupsData, self.pagination)
                }
            }
    }
    
    func getEduactionGroups(generalSearch:GeneralSearch  ,onCompletion: @escaping (Int, String,[EducationalGroupsData],Pagination)->()) throws{
        let header = HTTPHeaders(["userAuthorizeToken":generalSearch.userAuthorizeToken!])
        
        AF.request(Api().baseUrl.absoluteString + "EducationalGroups/GetAllEducationalGroups" , method: .get,parameters: apiHelper.getGenralDataSearch(generalSearch: generalSearch),headers: header)
            .validate()
            .responseDecodable(of: EducationGroupModel.self){ (response) in
                if response.response?.statusCode == 200{
                    guard let data = response.value else {
                        onCompletion(self.constant.STATUS_ERROR,NSLocalizedString("message_error_in_fetching_data", comment: "") , self.educationalGroupsDataModel,self.pagination)
                        return
                    }
                    onCompletion(data.status!,data.msg! ,data.educationalGroupsData ?? self.educationalGroupsDataModel,data.pagination ?? self.pagination)
                } else {
                    onCompletion(self.constant.STATUS_ERROR,NSLocalizedString("message_error_in_fetching_data", comment: "") , self.educationalGroupsDataModel, self.pagination)
                }
            }
    }
    
    //MARK: -  Attendance
    
    func getAttendanceHistoryData(generalSearch:GeneralSearch  ,onCompletion: @escaping (Int, String,[EducationalGroupAttendancesDatum],Pagination)->()) throws{
        let header = HTTPHeaders(["userAuthorizeToken":generalSearch.userAuthorizeToken!])
        
        AF.request(Api().baseUrl.absoluteString + "EducationalGroupAttendances/GetAllEducationalGroupAttendances" , method: .get,parameters: apiHelper.getGenralDataSearch(generalSearch: generalSearch),headers: header)
            .validate()
            .responseDecodable(of: EducationalAttendnaceHistoryModel.self){ (response) in
                if response.response?.statusCode == 200{
                    guard let data = response.value else {
                        onCompletion(self.constant.STATUS_ERROR,NSLocalizedString("message_error_in_fetching_data", comment: "") , self.educationalGroupAttendancesData,self.pagination)
                        return
                    }
                    onCompletion(data.status!,data.msg! ,data.educationalGroupAttendancesData ?? self.educationalGroupAttendancesData,data.pagination ?? self.pagination)
                } else {
                    onCompletion(self.constant.STATUS_ERROR,NSLocalizedString("message_error_in_fetching_data", comment: "") , self.educationalGroupAttendancesData, self.pagination)
                }
            }
    }
    //MARK: -  Exams
    
    func getStudentExams(generalSearch:GeneralSearch  ,onCompletion: @escaping (Int, String,[StudentExamInfoDatum],Pagination)->()) throws{
        let header = HTTPHeaders(["userAuthorizeToken":generalSearch.userAuthorizeToken!])
        
        AF.request(Api().baseUrl.absoluteString + "StudentExams/GetAllStudentExams" , method: .get,parameters: apiHelper.getGenralDataSearch(generalSearch: generalSearch),headers: header)
            .validate()
            .responseDecodable(of: EducationStudentExamsModel.self){ (response) in
                if response.response?.statusCode == 200{
                    guard let data = response.value else {
                        onCompletion(self.constant.STATUS_ERROR,NSLocalizedString("message_error_in_fetching_data", comment: "") , self.studentExamInfoData,self.pagination)
                        return
                    }
                    onCompletion(data.status!,data.msg! ,data.studentExamInfoData ?? self.studentExamInfoData,data.pagination ?? self.pagination)
                } else {
                    onCompletion(self.constant.STATUS_ERROR,NSLocalizedString("message_error_in_fetching_data", comment: "") , self.studentExamInfoData, self.pagination)
                }
            }
    }
    
    func getStudentExamReview(userAuthorizeToken:String,studentExamToken:String  ,onCompletion: @escaping (Int, String,ExamReviewInfoData)->()) throws{
        let header = HTTPHeaders(["userAuthorizeToken":userAuthorizeToken])
        let params = ["studentExamToken" : studentExamToken]
        AF.request(Api().baseUrl.absoluteString + "StudentExams/ReviewExam" , method: .get,parameters: params,headers: header)
            .validate()
            .responseDecodable(of: ExamReviewModel.self){ (response) in
                if response.response?.statusCode == 200{
                    guard let data = response.value else {
                        onCompletion(self.constant.STATUS_ERROR,NSLocalizedString("message_error_in_fetching_data", comment: "") , self.studentExamInfoDataReview)
                        return
                    }
                    onCompletion(data.status!,data.msg! ,data.studentExamInfoData ?? self.studentExamInfoDataReview)
                } else {
                    onCompletion(self.constant.STATUS_ERROR,NSLocalizedString("message_error_in_fetching_data", comment: "") , self.studentExamInfoDataReview)
                }
            }
    }
    
    
    func requestExam(userAuthorizeToken:String,languageToken:String , educationalCourseLessonToken:String,educationalCourseStudentToken:String,onCompletion: @escaping (Int, String,String)->()) throws{
        let header = HTTPHeaders(["userAuthorizeToken":userAuthorizeToken])
        let params = ["languageToken" : languageToken,
                      "educationalCourseLessonToken":educationalCourseLessonToken,
                      "educationalCourseStudentToken":educationalCourseStudentToken]
        AF.request(Api().baseUrl.absoluteString + "EducationalCourseLessons/GetRequestGenerateExam" , method: .get,parameters: params,headers: header)
            .validate()
            .responseDecodable(of: ExamStudentModelCourse.self){ (response) in
                if response.response?.statusCode == 200{
                    guard let data = response.value else {
                        onCompletion(self.constant.STATUS_ERROR,NSLocalizedString("message_error_in_fetching_data", comment: "") ,"")
                        return
                    }
                    onCompletion(data.status!,data.msg! ,data.studentExamToken ?? "")
                } else {
                    onCompletion(self.constant.STATUS_ERROR,NSLocalizedString("message_error_in_fetching_data", comment: ""), "")
                }
            }
    }
  
    
    func startExam(authToken : String , token :String,onCompletion: @escaping (Int, String,ExamPargraphInfo)->()) throws{
        let header = HTTPHeaders(["userAuthorizeToken":authToken])
        let params = ["studentExamToken":token]
        
        AF.request(Api().baseUrl.absoluteString + "StudentExams/StartStudentExam" , method: .post,parameters: params,headers: header)
            .validate()
            .responseDecodable(of: ExamModel.self){ (response) in
                if response.response?.statusCode == 200{
                    guard let data = response.value else {
                        onCompletion(self.constant.STATUS_ERROR,NSLocalizedString("message_error_in_fetching_data", comment: "") , self.startStudentExamData)
                        return
                    }
                    onCompletion(data.status!,data.msg! ,data.startStudentExamData ?? self.startStudentExamData)
                } else {
                    onCompletion(self.constant.STATUS_ERROR,NSLocalizedString("message_error_in_fetching_data", comment: "") , self.startStudentExamData)
                }
            }
    }
    
    func reviewExam(authToken : String , token :String,onCompletion: @escaping (Int, String,ExamReviewInfoData)->()) throws{
        let header = HTTPHeaders(["userAuthorizeToken":authToken])
            let params = ["studentExamToken" : token]
            AF.request(Api().baseUrl.absoluteString + "StudentExams/ReviewExam" , method: .get,parameters: params,headers: header)
                .validate()
                .responseDecodable(of: ExamReviewModel.self){ (response) in
                    if response.response?.statusCode == 200{
                        guard let data = response.value else {
                            onCompletion(self.constant.STATUS_ERROR,NSLocalizedString("message_error_in_fetching_data", comment: "") , self.studentExamInfoDataReview)
                            return
                        }
                        onCompletion(data.status!,data.msg! ,data.studentExamInfoData ?? self.studentExamInfoDataReview)
                    } else {
                        onCompletion(self.constant.STATUS_ERROR,NSLocalizedString("message_error_in_fetching_data", comment: "") , self.studentExamInfoDataReview)
                    }
                }
    }
    
    //MARK: -  News
    
    func getNews(generalSearch:GeneralSearch  ,onCompletion: @escaping (Int, String,[NewsArticlesDatum],Pagination)->()) throws{
        let header = HTTPHeaders(["userAuthorizeToken":generalSearch.userAuthorizeToken!])
        
        AF.request(Api().baseUrl.absoluteString + "NewsArticles/GetAllNewsArticles" , method: .get,parameters: apiHelper.getGenralDataSearch(generalSearch: generalSearch),headers: header)
            .validate()
            .responseDecodable(of: NewsModel.self){ (response) in
                if response.response?.statusCode == 200{
                    guard let data = response.value else {
                        onCompletion(self.constant.STATUS_ERROR,NSLocalizedString("message_error_in_fetching_data", comment: "") , self.newsData,self.pagination)
                        return
                    }
                    onCompletion(data.status!,data.msg! ,data.newsArticlesData ?? self.newsData ,data.pagination ?? self.pagination)
                } else {
                    onCompletion(self.constant.STATUS_ERROR,NSLocalizedString("message_error_in_fetching_data", comment: "") , self.newsData, self.pagination)
                }
            }
    }
    
    //MARK: -  Education categories
    
    func getEducationalCategory(generalSearch : GeneralSearch ,onCompletion: @escaping (Int, String,[EducationalCategoriesDatum],Pagination,String)->()) throws{
        
        let header = HTTPHeaders(["userAuthorizeToken":generalSearch.userAuthorizeToken!])
        
        AF.request(Api().baseUrl.absoluteString + "EducationalCategories/GetAllEducationalCategories" , method: .get,parameters: apiHelper.getGenralDataSearch(generalSearch: generalSearch),headers: header)
            .validate()
            .responseDecodable(of: EducationCategoriesCRUD.self){ (response) in
                if response.response?.statusCode == 200{
                    guard let data = response.value else {
                        onCompletion(self.constant.STATUS_ERROR,NSLocalizedString("message_error_in_fetching_data", comment: "") , self.educationalCategoriesData,self.pagination ,"")
                        return
                    }
                    onCompletion(data.status!,data.msg! ,data.educationalCategoriesData ?? self.educationalCategoriesData,data.pagination ?? self.pagination , data.prevEducationalCategoryToken ?? "")
                } else {
                    onCompletion(self.constant.STATUS_ERROR,NSLocalizedString("message_error_in_fetching_data", comment: "") , self.educationalCategoriesData,self.pagination , "")
                }
            }
    }
    
    
    //MARK: -  Submit exam
    
    
    func submitExam(statusEncoding :Bool,data : SubmitExam ,onCompletion: @escaping (Int, String) -> ()) throws {
        var json = ""
        if statusEncoding == true {
            let jsonEncoder = JSONEncoder()
            let jsonData = try jsonEncoder.encode(data)
            json = String(data: jsonData, encoding: String.Encoding.utf8)!
        }
        var request = URLRequest(url: URL(string: Api().baseUrl.absoluteString + "StudentExams/SubmitExamQuestions")!)
        request.httpMethod = HTTPMethod.post.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let data = (json.data(using: .utf8))! as Data
        request.httpBody = data
        AF.request(request)
            .responseDecodable(of:GeneralModel.self){ (response) in
                
                if response.response?.statusCode == 200 {
                    guard let data = response.value else {
                        onCompletion(Constants().STATUS_ERROR,NSLocalizedString("message_error_in_fetching_data", comment: ""))
                        return
                    }
                    onCompletion(data.status! , data.msg!)
                } else {
                    onCompletion(Constants().STATUS_ERROR,NSLocalizedString("message_error_in_fetching_data", comment: ""))
                    
                }
            }
    }
    
    //MARK: -  Teacher Codes
    
    func getTeacherCodeAvailablePricesStatistics(userAuthorizeToken : String,userServiceProviderToken : String ,onCompletion: @escaping (Int, String,[TeacherCodeAvailablePricesStatistic])->()) throws{
        
        let header = HTTPHeaders(["userAuthorizeToken":userAuthorizeToken])
        let params = ["userServiceProviderToken" :userServiceProviderToken ]
        
        AF.request(Api().baseUrl.absoluteString + "TeacherCodes/GetTeacherCodeAvailablePricesStatistics" , method: .get,parameters: params,headers: header)
            .validate()
            .responseDecodable(of: GetAllTeachersCodeStatisticsModel.self){ (response) in
                if response.response?.statusCode == 200{
                    guard let data = response.value else {
                        onCompletion(self.constant.STATUS_ERROR,NSLocalizedString("message_error_in_fetching_data", comment: "") , self.teacherCodeAvailablePricesStatistics)
                        return
                    }
                    onCompletion(data.status!,data.msg! ,data.teacherCodeAvailablePricesStatistics ?? self.teacherCodeAvailablePricesStatistics)
                } else {
                    onCompletion(self.constant.STATUS_ERROR,NSLocalizedString("message_error_in_fetching_data", comment: "") , self.teacherCodeAvailablePricesStatistics)
                }
            }
    }
    
    func buyTeacherCode(userAuthorizeToken : String , userServiceProviderToken :String , teacherCodePrice : Double , onCompletion:@escaping ( Int , String)->()) throws {
        let header = HTTPHeaders(["userAuthorizeToken":userAuthorizeToken])
        let params : [String :Any] = ["userServiceProviderToken":userServiceProviderToken,
                                      "teacherCodePrice" :teacherCodePrice]
        
        AF.request(Api().baseUrl.absoluteString + "TeacherCodes/RequstTeacherCode" , method: .post,parameters: params,headers: header)
            .validate()
            .responseDecodable(of: GeneralModel.self){ (response) in
                if response.response?.statusCode == 200{
                    guard let data = response.value else {
                        onCompletion(self.constant.STATUS_ERROR,NSLocalizedString("message_error_in_fetching_data", comment: ""))
                        return
                    }
                    onCompletion(data.status!,data.msg!)
                } else {
                    onCompletion(self.constant.STATUS_ERROR,NSLocalizedString("message_error_in_fetching_data", comment: ""))
                }
            }
    }
    
    func myTeacherCodes(generalSearch : GeneralSearch, onCompletion:@escaping ( Int , String,[TeacherCodesDatum],TeacherCodeStatistics,Pagination)->()) throws {
        let header = HTTPHeaders(["userAuthorizeToken":generalSearch.userAuthorizeToken!])
        
        AF.request(Api().baseUrl.absoluteString + "TeacherCodes/GetAllTeacherCodes" , method: .get,parameters: apiHelper.getGenralDataSearch(generalSearch: generalSearch),headers: header)
            .validate()
            .responseDecodable(of: GetAllMyCodeModel.self){ (response) in
                if response.response?.statusCode == 200{
                    guard let data = response.value else {
                        onCompletion(self.constant.STATUS_ERROR,NSLocalizedString("message_error_in_fetching_data", comment: ""),self.teacherCodeData,self.teacherCodeStatistics,self.pagination)
                        return
                    }
                    onCompletion(data.status!,data.msg!,data.teacherCodesData ?? self.teacherCodeData , data.teacherCodeStatistics ?? self.teacherCodeStatistics,data.pagination ?? self.pagination)
                } else {
                    onCompletion(self.constant.STATUS_ERROR,NSLocalizedString("message_error_in_fetching_data", comment: ""),self.teacherCodeData,self.teacherCodeStatistics,self.pagination)
                }
            }
    }
    
    //MARK: -  Notification
    
    func notification(generalSearch : GeneralSearch, onCompletion:@escaping ( Int , String,[NotificationsDatum],Pagination)->()) throws {
        let header = HTTPHeaders(["userAuthorizeToken":generalSearch.userAuthorizeToken!])
        
        AF.request(Api().baseUrl.absoluteString + "Notifications/GetAllNotifications" , method: .get,parameters: apiHelper.getGenralDataSearch(generalSearch: generalSearch),headers: header)
            .validate()
            .responseDecodable(of: GetNotification.self){ (response) in
                if response.response?.statusCode == 200{
                    guard let data = response.value else {
                        onCompletion(self.constant.STATUS_ERROR,NSLocalizedString("message_error_in_fetching_data", comment: ""),self.notificationData,self.pagination)
                        return
                    }
                    onCompletion(data.status!,data.msg!,data.notificationsData ?? self.notificationData , data.pagination ?? self.pagination)
                } else {
                    onCompletion(self.constant.STATUS_ERROR,NSLocalizedString("message_error_in_fetching_data", comment: ""),self.notificationData,self.pagination)
                }
            }
    }

    func readNotification(authToken :String , notificationToken:String, onCompletion:@escaping ( Int , String)->()) throws {
        let header = HTTPHeaders(["userAuthorizeToken":authToken])
        let params = ["notificationToken":notificationToken]
        AF.request(Api().baseUrl.absoluteString + "Notifications/GetAllNotifications" , method: .post,parameters: params,headers: header)
            .validate()
            .responseDecodable(of: GeneralModel.self){ (response) in
                if response.response?.statusCode == 200{
                    guard let data = response.value else {
                        onCompletion(self.constant.STATUS_ERROR,NSLocalizedString("message_error_in_fetching_data", comment: ""))
                        return
                    }
                    onCompletion(data.status!,data.msg!)
                } else {
                    onCompletion(self.constant.STATUS_ERROR,NSLocalizedString("message_error_in_fetching_data", comment: ""))
                }
            }
    }
    
    func readNotification(statusEncoding :Bool,data : ReadNotification ,onCompletion: @escaping (Int, String) -> ()) throws {
        var json = ""
        if statusEncoding == true {
            let jsonEncoder = JSONEncoder()
            let jsonData = try jsonEncoder.encode(data)
            json = String(data: jsonData, encoding: String.Encoding.utf8)!
        }
        var request = URLRequest(url: URL(string: Api().baseUrl.absoluteString + "Notifications/ReadNotification")!)
        request.httpMethod = HTTPMethod.post.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let data = (json.data(using: .utf8))! as Data
        request.httpBody = data
        AF.request(request)
            .responseDecodable(of:GeneralModel.self){ (response) in
                if response.response?.statusCode == 200 {
                    guard let data = response.value else {
                        onCompletion(Constants().STATUS_ERROR,NSLocalizedString("message_error_in_fetching_data", comment: ""))
                        return
                    }
                    onCompletion(data.status! , data.msg! )
                } else {
                    onCompletion(Constants().STATUS_ERROR,NSLocalizedString("message_error_in_fetching_data", comment: ""))
                }
            }
    }
    
    func readAllNotification(statusEncoding :Bool,data : ReadNotification ,onCompletion: @escaping (Int, String) -> ()) throws {
        var json = ""
        if statusEncoding == true {
            let jsonEncoder = JSONEncoder()
            let jsonData = try jsonEncoder.encode(data)
            json = String(data: jsonData, encoding: String.Encoding.utf8)!
        }
        var request = URLRequest(url: URL(string: Api().baseUrl.absoluteString + "Notifications/ReadAllNotifications")!)
        request.httpMethod = HTTPMethod.post.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let data = (json.data(using: .utf8))! as Data
        request.httpBody = data
        AF.request(request)
            .responseDecodable(of:GeneralModel.self){ (response) in
                if response.response?.statusCode == 200 {
                    guard let data = response.value else {
                        onCompletion(Constants().STATUS_ERROR,NSLocalizedString("message_error_in_fetching_data", comment: ""))
                        return
                    }
                    onCompletion(data.status! , data.msg! )
                } else {
                    onCompletion(Constants().STATUS_ERROR,NSLocalizedString("message_error_in_fetching_data", comment: ""))
                }
            }
    }
    
    func getCountNotification(authToken : String,onCompletion: @escaping (Int, String,Int) -> ()) throws {
        let header = HTTPHeaders(["userAuthorizeToken":authToken])
        AF.request(Api().baseUrl.absoluteString + "Notifications/GetCountNotReadNotfcations" , method: .get,headers: header)
            .validate()
            .responseDecodable(of: GetNotificationCount.self){ (response) in
                if response.response?.statusCode == 200{
                    guard let data = response.value else {
                        onCompletion(self.constant.STATUS_ERROR,NSLocalizedString("message_error_in_fetching_data", comment: ""),0)
                        return
                    }
                    onCompletion(data.status!,data.msg!,data.notificationsCount ?? 0)
                } else {
                    onCompletion(self.constant.STATUS_ERROR,NSLocalizedString("message_error_in_fetching_data", comment: ""),0)
                }
            }
    }

    
    //MARK: -  App setting
    
    
    func getAppSettings(userAuth :String, onCompletion:@escaping ( Int , String,UserAppSetting)->()) throws {
        let header = HTTPHeaders(["userAuthorizeToken":userAuth])
        
        AF.request(Api().baseUrl.absoluteString + "UserAppSettings/GetUserAppSettingDetails" , method: .get,headers: header)
            .validate()
            .responseDecodable(of: GetAppSettingModel.self){ (response) in
                if response.response?.statusCode == 200{
                    guard let data = response.value else {
                        onCompletion(self.constant.STATUS_ERROR,NSLocalizedString("message_error_in_fetching_data", comment: ""),self.userAppSettingData)
                        return
                    }
                    onCompletion(data.status!,data.msg!,data.userAppSettingData ?? self.userAppSettingData)
                } else {
                    onCompletion(self.constant.STATUS_ERROR,NSLocalizedString("message_error_in_fetching_data", comment: ""),self.userAppSettingData)
                }
            }
    }
    
    func updateUserAppSettings(userAuth :String,languageToken:String,themeToken:String,timeZoneToken:String,dateFormatToken:String,timeFormatToken:String,customSettings : String , receiveNotificationStatus:String, onCompletion:@escaping (Int ,String, GetAppSettingModel)->()) throws {
        let header = HTTPHeaders(["userAuthorizeToken":userAuth])
        let param : [String : Any] = ["languageToken":languageToken,
                                      "themeToken":themeToken,
                                      "timeZoneToken":timeZoneToken,
                                      "dateFormatToken":dateFormatToken,
                                      "timeFormatToken":timeFormatToken,
                                      "customSettings":customSettings,
                                      "receiveNotificationStatus":receiveNotificationStatus]
        
        
        AF.request(Api().baseUrl.absoluteString + "UserAppSettings/UpdateUserAppSetting" , method: .post,parameters: param,headers: header)
            .validate()
            .responseDecodable(of: GetAppSettingModel.self){ (response) in
                if response.response?.statusCode == 200{
                   
                    guard let data = response.value else {
                        onCompletion(self.constant.STATUS_ERROR,NSLocalizedString("message_error_in_fetching_data", comment: ""),self.appSetting)
                        return
                    }
                    onCompletion(data.status!,data.msg!, data)
                } else {
                    onCompletion(self.constant.STATUS_ERROR,NSLocalizedString("message_error_in_fetching_data", comment: ""),self.appSetting)
                }
            }
    }
    //MARK: -  All Media

    func getAllMediaData(generalSearch : GeneralSearch, onCompletion:@escaping ( Int , String,[SystemMediaData],Pagination)->()) throws {
        let header = HTTPHeaders(["userAuthorizeToken":generalSearch.userAuthorizeToken!])
        
        AF.request(Api().baseUrl.absoluteString + "SystemMedias/GetAllSystemMedias" , method: .get,parameters: apiHelper.getGenralDataSearch(generalSearch: generalSearch),headers: header)
            .validate()
            .responseDecodable(of: AllMedia.self){ (response) in
                if response.response?.statusCode == 200{
                    guard let data = response.value else {
                        onCompletion(self.constant.STATUS_ERROR,NSLocalizedString("message_error_in_fetching_data", comment: ""),self.systemMediaData,self.pagination)
                        return
                    }
                    onCompletion(data.status!,data.msg!,data.systemMediaData ?? self.systemMediaData,data.pagination ?? self.pagination)
                } else {
                    onCompletion(self.constant.STATUS_ERROR,NSLocalizedString("message_error_in_fetching_data", comment: ""),self.systemMediaData,self.pagination)
                }
            }
    }
    
    //MARK: - Get Education courses
    func getEducationCourses(generalSearch:GeneralSearch ,onCompletion: @escaping (Int, String,[EducationalCourseVMDatum],Pagination)->()) throws {
        let header = HTTPHeaders(["userAuthorizeToken":generalSearch.userAuthorizeToken!])
        
        AF.request(Api().baseUrl.absoluteString + "EducationalCourses/GetAllEducationalCourses" , method: .get,parameters: apiHelper.getMyCourses(generalSearch: generalSearch),headers: header)
            .validate()
            .responseDecodable(of: EducationalCourseModel.self){ (response) in
                if response.response?.statusCode == 200{
                    guard let data = response.value else {
                        
                        onCompletion(self.constant.STATUS_ERROR,response.value?.msg ?? "Error" , self.educationalCoursesData,self.pagination)
                        return
                    }
                    onCompletion(data.status!,data.msg! ,data.educationalCourseVMData ?? self.educationalCoursesData,data.pagination ?? self.pagination)
                } else {
                    onCompletion(self.constant.STATUS_ERROR,NSLocalizedString("message_error_in_fetching_data", comment: "") , self.educationalCoursesData,self.pagination)
                }
            }
    }
    
    
    func getEducationCourseDetails(userAuth : String, userStudentToken:String ,token : String ,onCompletion: @escaping (Int, String,EducationalCourseInfoData)->()) throws {
        let header = HTTPHeaders(["userAuthorizeToken":userAuth])
        let params : [String : Any] = [ "userStudentToken":userStudentToken,
                       "token" : token]
        
        AF.request(Api().baseUrl.absoluteString + "EducationalCourses/GetEducationalCourseDetails" , method: .get,parameters: params,headers: header)
            .validate()
            .responseDecodable(of: EducationalCoursDetailsModel.self){ (response) in
                if response.response?.statusCode == 200 {
                    
                    guard let data = response.value else {
                        onCompletion(self.constant.STATUS_ERROR,NSLocalizedString("message_error_in_fetching_data", comment: "") , self.educationalCourseDetails)
                        return
                    }
                    onCompletion(data.status!,data.msg! ,data.educationalCourseInfoData ?? self.educationalCourseDetails)
                } else {
                    onCompletion(self.constant.STATUS_ERROR,NSLocalizedString("message_error_in_fetching_data", comment: "") , self.educationalCourseDetails)
                }
            }
    }
    
    
    func buyCourse(authToken : String, userStudentToken:String ,educationalCourseToken : String, amountBePaid : Double ,onCompletion: @escaping (Int, String)->()) throws{
        let header = HTTPHeaders(["userAuthorizeToken":authToken])
        let params : [String : Any] = ["userStudentToken":userStudentToken,
                                       "educationalCourseToken":educationalCourseToken,
                                       "amountBePaid": amountBePaid
                                       ]
        
        AF.request( Api().baseUrl.absoluteString + "EducationalCourseStudentSubscriptions/BuyEducationalCourse" , method: .post, parameters:params,headers: header)
            .validate()
            .responseDecodable(of: GetEducationCoursBuyModel.self){ (response) in
                if response.response?.statusCode == 200{
                    guard let data = response.value else {
                        onCompletion(self.constant.STATUS_ERROR,NSLocalizedString("message_error_in_fetching_data", comment: ""))
                        return
                    }
                    onCompletion(data.status!,data.msg!)
                } else {
                    onCompletion(self.constant.STATUS_ERROR,NSLocalizedString("message_error_in_fetching_data", comment: ""))
                }
            }
    }
    
     
    func buyCourseFromCourseCode(authToken : String, userStudentToken:String ,educationalCourseToken : String, coursePurchaseType : String, code : String ,onCompletion: @escaping (Int, String)->()) throws{
        let header = HTTPHeaders(["userAuthorizeToken":authToken])
        let params : [String : Any] = ["userStudentToken":userStudentToken,
                                       "educationalCourseToken":educationalCourseToken,
                                       "educationalCourseNaturePurchaseType": coursePurchaseType,
                                       "cardCode": code
                                       ]
        
        AF.request( Api().baseUrl.absoluteString + "EducationalCourseCards/UseEducationalCourseCard" , method: .post, parameters:params,headers: header)
            .validate()
            .responseDecodable(of: GetEducationCoursBuyModel.self){ (response) in
                if response.response?.statusCode == 200{
                    guard let data = response.value else {
                        onCompletion(self.constant.STATUS_ERROR,NSLocalizedString("message_error_in_fetching_data", comment: ""))
                        return
                    }
                    onCompletion(data.status!,data.msg!)
                } else {
                    onCompletion(self.constant.STATUS_ERROR,NSLocalizedString("message_error_in_fetching_data", comment: ""))
                }
            }
    }
    
    func buyCourseFromWalletCode(authToken : String, userStudentToken:String ,educationalCourseToken : String, coursePurchaseType : String, code : String ,onCompletion: @escaping (Int, String)->()) throws{
        let header = HTTPHeaders(["userAuthorizeToken":authToken])
        let params : [String : Any] = ["userStudentToken":userStudentToken,
                                       "educationalCourseToken":educationalCourseToken,
                                       "educationalCourseNaturePurchaseType": coursePurchaseType,
                                       "cardCode": code
                                       ]
        
        AF.request( Api().baseUrl.absoluteString + "WalletChargingCards/BuyEducationalCourseByWalletChargingCard" , method: .post, parameters:params,headers: header)
            .validate()
            .responseDecodable(of: GetEducationCoursBuyModel.self){ (response) in
                if response.response?.statusCode == 200{
                    guard let data = response.value else {
                        onCompletion(self.constant.STATUS_ERROR,NSLocalizedString("message_error_in_fetching_data", comment: ""))
                        return
                    }
                    onCompletion(data.status!,data.msg!)
                } else {
                    onCompletion(self.constant.STATUS_ERROR,NSLocalizedString("message_error_in_fetching_data", comment: ""))
                }
            }
    }
    
    func buyCourseFromAcademicYearCode(authToken : String, userStudentToken:String ,educationalCourseToken : String, coursePurchaseType : String, code : String ,onCompletion: @escaping (Int, String)->()) throws{
            let header = HTTPHeaders(["userAuthorizeToken":authToken])
            let params : [String : Any] = ["userStudentToken":userStudentToken,
                                           "educationalCourseToken":educationalCourseToken,
                                           "educationalCourseNaturePurchaseType": coursePurchaseType,
                                           "cardCode": code
                                           ]
            
            AF.request( Api().baseUrl.absoluteString + "AcademicYearTeacherCards/UseAcademicYearTeacherCard" , method: .post, parameters:params,headers: header)
                .validate()
                .responseDecodable(of: GetEducationCoursBuyModel.self){ (response) in

                    if response.response?.statusCode == 200{
                        guard let data = response.value else {
                            onCompletion(self.constant.STATUS_ERROR,NSLocalizedString("message_error_in_fetching_data", comment: ""))
                            return
                        }
                        onCompletion(data.status!,data.msg!)
                    } else {
                        onCompletion(self.constant.STATUS_ERROR,NSLocalizedString("message_error_in_fetching_data", comment: ""))
                    }
                }
        }
    
    func payWallet(authToken : String,chargeValue : Double,paymentPhoneNumber:String , paymentTypeToken:String  ,onCompletion: @escaping (String, Int, String)->()) throws{
        let header = HTTPHeaders(["userAuthorizeToken":authToken])
        let params : [String : Any] = ["chargeValue":chargeValue,
                                       "paymentPhoneNumber":paymentPhoneNumber,
                                       "paymentTypeToken":paymentTypeToken]
        
        AF.request( Api().baseUrl.absoluteString + "OnlinePayments/RequestChargeWallet" , method: .post, parameters:params,headers: header)
            .validate()
            .responseDecodable(of: WalletModel.self){ (response) in
                if response.response?.statusCode == 200{
                    guard let data = response.value else {
                        
                        onCompletion("",self.constant.STATUS_ERROR,NSLocalizedString("message_error_in_fetching_data", comment: "") )
                        return
                    }
                    onCompletion(data.paymentUrl ?? "",data.status!,data.msg!)
                } else {
                    onCompletion("",self.constant.STATUS_ERROR,NSLocalizedString("message_error_in_fetching_data", comment: ""))
                }
            }
    }
    
    func payCode(authToken : String,code : String  ,onCompletion: @escaping (Int, String)->()) throws{
        let header = HTTPHeaders(["userAuthorizeToken":authToken])
        let params : [String : Any] = ["cardCode":code]
        
        AF.request( Api().baseUrl.absoluteString + "WalletChargingCards/UseWalletChargingCard" , method: .post, parameters:params,headers: header)
            .validate()
            .responseDecodable(of: GeneralModel.self){ (response) in
                if response.response?.statusCode == 200{
                    guard let data = response.value else {
                        onCompletion(self.constant.STATUS_ERROR,NSLocalizedString("message_error_in_fetching_data", comment: "") )
                        return
                    }
                    onCompletion(data.status!,data.msg ?? "")
                } else {
                    onCompletion(self.constant.STATUS_ERROR,NSLocalizedString("message_error_in_fetching_data", comment: ""))
                }
            }
    }
    
    func attendFromZoom(authToken : String,educationalGroupScheduleTimeToken : String  ,onCompletion: @escaping (Int, String)->()) throws{
        let header = HTTPHeaders(["userAuthorizeToken":authToken])
        let params : [String : Any] = ["educationalGroupScheduleTimeToken":educationalGroupScheduleTimeToken]
        
        AF.request( Api().baseUrl.absoluteString + "EducationalGroupAttendances/AttendanceMyself" , method: .post, parameters:params,headers: header)
            .validate()
            .responseDecodable(of: GeneralModel.self){ (response) in
                if response.response?.statusCode == 200{
                    guard let data = response.value else {
                        onCompletion(self.constant.STATUS_ERROR,NSLocalizedString("message_error_in_fetching_data", comment: "") )
                        return
                    }
                    onCompletion(data.status!,data.msg ?? "")
                } else {
                    onCompletion(self.constant.STATUS_ERROR,NSLocalizedString("message_error_in_fetching_data", comment: ""))
                }
            }
    }
    
    //MARK: - Finance
    func getUserFinanceData(authToken : String , userToken : String ,onCompletion: @escaping (Int, String,UserFinanceStatisticData)->()) throws {
        let header = HTTPHeaders(["userAuthorizeToken":authToken])
        let params = ["userToken" : userToken]
        
        AF.request(Api().baseUrl.absoluteString + "UserFinanceStatistics/UpdateAndGetUserFinanceStatistic" , method: .post,parameters: params,headers: header)
            .validate()
            .responseDecodable(of: FinanceModel.self){ (response) in
                if response.response?.statusCode == 200{
                    guard let data = response.value else {
                        onCompletion(self.constant.STATUS_ERROR,NSLocalizedString("message_error_in_fetching_data", comment: "") , self.userFinanceStatisticData)
                        return
                    }
                    onCompletion(data.status!,data.msg! ,data.userFinanceStatisticData ?? self.userFinanceStatisticData)
                } else {
                    onCompletion(self.constant.STATUS_ERROR,NSLocalizedString("message_error_in_fetching_data", comment: "") , self.userFinanceStatisticData)
                }
            }
    }
    
    func getUserWalletTransactionData(generalSearch:GeneralSearch  ,onCompletion: @escaping (Int, String,[UserWalletTransactionsDatum])->()) throws {
        let header = HTTPHeaders(["userAuthorizeToken":generalSearch.userAuthorizeToken!])
        
        AF.request(Api().baseUrl.absoluteString + "UserWalletTransactions/GetAllUserWalletTransactions" , method: .get,parameters: apiHelper.getGenralDataSearch(generalSearch: generalSearch),headers: header)
            .validate()
            .responseDecodable(of: UserWalletTransactionModel.self){ (response) in
                if response.response?.statusCode == 200 {
                    guard let data = response.value else {
                        onCompletion(self.constant.STATUS_ERROR,NSLocalizedString("message_error_in_fetching_data", comment: "") , self.userWalletTransactionsData)
                        return
                    }
                    onCompletion(data.status!,data.msg! ,data.userWalletTransactionsData ?? self.userWalletTransactionsData)
                } else {
                    onCompletion(self.constant.STATUS_ERROR,NSLocalizedString("message_error_in_fetching_data", comment: "") , self.userWalletTransactionsData)
                }
            }
    }
    
    //MARK: - Academic year
    func getAcademicYears(generalSearch:GeneralSearch ,onCompletion: @escaping (Int, String,[ItemsDatum])->()) throws {
        let header = HTTPHeaders(["userAuthorizeToken":generalSearch.userAuthorizeToken!])
        AF.request(Api().baseUrl.absoluteString + "EducationalCategories/GetEducationalCategoryDialog" , method: .get,parameters: apiHelper.getGenralDataSearch(generalSearch: generalSearch),headers: header)
            .validate()
            .responseDecodable(of: AcademicYearsModel.self){ (response) in
                if response.response?.statusCode == 200{
                    guard let data = response.value else {
                        onCompletion(self.constant.STATUS_ERROR,NSLocalizedString("message_error_in_fetching_data", comment: "") , self.academicYearsData)
                        return
                    }
                   
                    onCompletion(data.status!,data.msg! ,data.itemsData ?? self.academicYearsData)
                   
                } else {
                    onCompletion(self.constant.STATUS_ERROR,NSLocalizedString("message_error_in_fetching_data", comment: "") , self.academicYearsData)
                }
            }
    }
    //MARK: - Center
    func getCenterPlaces(generalSearch:GeneralSearch ,onCompletion: @escaping (Int, String,[ItemsDatum])->()) throws {
        let header = HTTPHeaders(["userAuthorizeToken":generalSearch.userAuthorizeToken!])
        AF.request(Api().baseUrl.absoluteString + "Places/GetPlaceDialog" , method: .get,parameters: apiHelper.getGenralDataSearch(generalSearch: generalSearch),headers: header)
            .validate()
            .responseDecodable(of: CenterPlacesModel.self){ (response) in
                if response.response?.statusCode == 200{
                    guard let data = response.value else {
                        onCompletion(self.constant.STATUS_ERROR,NSLocalizedString("message_error_in_fetching_data", comment: "") , self.centerPlaces)
                        return
                    }
                   
                    onCompletion(data.status!,data.msg! ,data.itemsData ?? self.centerPlaces)
                   
                } else {
                    onCompletion(self.constant.STATUS_ERROR,NSLocalizedString("message_error_in_fetching_data", comment: "") , self.centerPlaces)
                }
            }
    }
    //MARK: - Governments
    func getConstantsList(generalSearch:GeneralSearch ,onCompletion: @escaping (Int, String,ConstantsListsDataa)->()) throws {
        let header = HTTPHeaders(["userAuthorizeToken":generalSearch.userAuthorizeToken!])
        AF.request(Api().baseUrl.absoluteString + "UsersAuthentication/GetConstantsLists" , method: .get,parameters: apiHelper.getGenralDataSearch(generalSearch: generalSearch),headers: header)
            .validate()
            .responseDecodable(of: ConstantListModel.self){ (response) in
                if response.response?.statusCode == 200{
                    guard let data = response.value else {
                        onCompletion(self.constant.STATUS_ERROR,NSLocalizedString("message_error_in_fetching_data", comment: "") , self.constantsList)
                        return
                    }
                   
                    onCompletion(data.status!,data.msg! ,data.constantsListsData ?? self.constantsList)
                   
                } else {
                    onCompletion(self.constant.STATUS_ERROR,NSLocalizedString("message_error_in_fetching_data", comment: "") , self.constantsList)
                }
            }
    }

    
    
}
