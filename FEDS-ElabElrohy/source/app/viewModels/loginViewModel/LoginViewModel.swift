//
//  LoginViewModel.swift
//  FEDS-Center-Dev-IOS
//
//  Created by Mrwan on 27/05/2024.
//

import Foundation


class LoginViewModel : ObservableObject {
    @Published var genralVm : GeneralVm = GeneralVm()

    @Published var user = ""
    @Published var password = ""
    @Published var toast: Toast? = nil
    @Published var showLoading : Bool = false
    
    @Published var msgVersion = ""
    @Published var urlVersion = ""
    
    @Published var showDecFromLogin :Bool = false
    @Published var showAZDialogVersion :Bool = false
    @Published var showAZDialog :Bool = false
    @Published var showPassword : Bool = false
    @Published var showSignUp : Bool = false
    @Published var showForgetPassword : Bool = false
    @Published var backFromLogin : Bool = false
    @Published var constantListData : ConstantsListsDataa = ConstantsListsDataa()

     func getFiledsData(){
        if Helper.isConnectedToNetwork() {
         
            let userEmailOrPhonenumber : String = user
            let userPassword : String = password
            
            checkValidation(userEmailOrPhone: userEmailOrPhonenumber, userPassword: userPassword)
        } else {
            toast = Helper.showToast(style: .error, message: NSLocalizedString("error_connected_to_network", comment: ""))
            return
        }
    }
        
     func checkValidation(userEmailOrPhone : String , userPassword:String){
      
        let isValidEmail = Validation.isValidEmail(email: userEmailOrPhone)
        let isValidPassword = Validation.isValidpassword(password: userPassword)
        
        if userEmailOrPhone.isEmpty || userPassword.isEmpty {
            toast = Helper.showToast(style: .error, message: NSLocalizedString("error_enter_data", comment: ""))
            return
        }
        
        if userEmailOrPhone.contains("@") {
            if isValidEmail == false {
              
                toast = Helper.showToast(style: .error, message: NSLocalizedString("error_email", comment: ""))
                return
            }
        }
        
        
//        if isValidPassword == false {
//
//            toast = Helper.showToast(style: .error, message: NSLocalizedString("error_password", comment: ""))
//            return
//        }
        
        callApi(userEmail: userEmailOrPhone, userPassword: userPassword)
    }
    
     func callApi(userEmail:String , userPassword:String) {
        showLoading = true
        do {

            let data = try JSONEncoder().encode(logData())
            UserDefaults.standard.set(data, forKey: "apiData")
            do {
               
                let decoder = JSONDecoder()
                var loginData = try decoder.decode(logData.self, from: data)
                loginData.user = userEmail
                loginData.userpassword = userPassword
                loginData.languageToken = Language.getLanguageISO()

                
                var userDeviceData = try decoder.decode(UserDeviceData.self, from: data)
                userDeviceData.userDeviceName = genralVm.deviceName
                userDeviceData.userPlatFormToken = genralVm.userPlatformTokn
                userDeviceData.userVersionNumber = genralVm.appVersion
                userDeviceData.userFirebaseToken = !genralVm.userFirebaseToken.isEmpty || genralVm.userFirebaseToken.count > 0 ? genralVm.userFirebaseToken : "Firbase"
                userDeviceData.userDeviceCompany = "Apple"
                userDeviceData.userDeviceUniqueCode = "\(genralVm.deviceUniqeId ?? UUID())"
                userDeviceData.userDeviceOS = "IOS"
                userDeviceData.userDeviceVersionOS = genralVm.deviceOsVersion
                userDeviceData.userDeviceEMUI = "Unknown"
                userDeviceData.userDeviceRam = String(genralVm.deviceRam)
                userDeviceData.userDeviceProcessor = genralVm.deviceProcessor
                userDeviceData.userDeviceDisplay = "Unknown"
                userDeviceData.userDeviceModel = genralVm.deviceModelName
                userDeviceData.userDeviceSerial = "Unknown"
                userDeviceData.userDeviceDescription = genralVm.deviceDescrption
                userDeviceData.userDeviceNotes = "Unknown"

                loginData.userDeviceData = userDeviceData
                                do {

                    try Api().login(statusEncoding: true, data: loginData) { (status, msg, UsersVersion, APIAppData ) in

                        if status == self.genralVm.constants.STATUS_SUCCESS {
                            self.showLoading = false
                            do {
                                
                                let data = try JSONEncoder().encode(APIAppData)
                                UserDefaults.standard.set(data, forKey: "userData")
                                UserDefaults.standard.set(APIAppData.userData?.userTypeToken!, forKey: "userTypeToken")
                                UserDefaults.standard.set(APIAppData.userAuthorizeToken, forKey: "userAuth")
                                UserDefaults.standard.set(APIAppData.userData?.fullCode, forKey: "userFullCode")
                                UserDefaults.standard.set(APIAppData.userData?.userToken, forKey: "userToken")
                                UserDefaults.standard.set(APIAppData.userLoginSessionToken, forKey: "userLoginSessionToken")
                                UserDefaults.standard.set(APIAppData.userData?.userNameCurrent, forKey: "userNameCurrent")
                                UserDefaults.standard.set(APIAppData.userData?.userImageUrl, forKey: "userImageUrl")
                                UserDefaults.standard.set(APIAppData.userData?.userPhoneWithCC, forKey: "phoneNumber")
                                UserDefaultss().saveBool(value: true, key: "rememberMe")
                                UserDefaultss().saveBool(value: APIAppData.userData?.userCanBuyCourseFromWebview ?? false, key: "havePermissionToView")
                                
                                UserDefaultss().saveStrings(value: self.genralVm.constants.ROUTE_FROM_MAIN_PAGE,
                                                            key: self.genralVm.constants.KEY_ROUTE_COURSES)
                
                                if APIAppData.userAppSettingData?.themeToken == self.genralVm.constants.APP_THEME_TOKEN_DARK {
                                    self.genralVm.isDark = true
                                    UserDefaultss().saveBool(value: true, key: "isDark")
                                } else {
                                    self.genralVm.isDark = false
                                    UserDefaultss().saveBool(value: false, key: "isDark")
                                }
                                          let userAppSettingData = try JSONEncoder().encode(APIAppData.userAppSettingData)
                                          UserDefaults.standard.set(userAppSettingData, forKey: self.genralVm.constants.USER_APP_SETTINGS_DATA)
                                            let constantListData = try JSONEncoder().encode(APIAppData.constantsListsData)
                                          UserDefaults.standard.set(constantListData, forKey: self.genralVm.constants.CONSTANT_LIST_DATA)
                                        
                        
                                if APIAppData.userData?.userTypeToken == self.genralVm.constants.USER_TYPE_TOKEN_FAMILY {
                                    let children = try JSONEncoder().encode(APIAppData.userData?.myChildren)
                                    UserDefaults.standard.set(children, forKey: "childrenData")
                              

                                }
                                self.getConstantList()
                                self.showDecFromLogin = true

                          

                                      } catch {
                                          self.showLoading = false
                                        Helper.traceCrach(error: error, userToken: "USE-0")
                                          self.toast = Helper.showToast(style: .error, message: NSLocalizedString("error_email", comment: ""))

                                      }

                          } else if status == self.genralVm.constants.STATUS_ERROR {
                              self.showLoading = false
                           
                              self.toast = Helper.showToast(style: .error, message: msg)

                          } else if status == self.genralVm.constants.STATUS_VERSION{
                              self.showLoading = false
                              self.showAZDialogVersion.toggle()
                              self.msgVersion = msg
                              self.urlVersion = UsersVersion.versionLinkDownload ?? ""
                              
                          } else if status == self.genralVm.constants.STATUS_CATCH {
                              self.showLoading = false
                           
                              self.toast = Helper.showToast(style: .error, message: msg)

                          }else if status == self.genralVm.constants.STATUS_NO_CONTENT {
                              self.showLoading = false
                              self.toast = Helper.showToast(style: .error, message: msg)

                              }
//                        else if status == self.genralVm.constants.STATUS_LOGIN_CODE {
//                                  self.stopAnimating(nil)
//                                  UserDefaultss().saveStrings(value: msg, key: "msg")
//                                  UserDefaultss().saveStrings(value: APIAppData.userAuthorizeToken!, key: "userAuth")
//                                  UserDefaultss().saveStrings(value: (APIAppData.userData?.userToken)!, key: "useerToken")
//                                  UserDefaults.standard.set(self.rememberMeCheck, forKey: "RememberMe")
//                                  let logined : Bool = true
//                                  self.userDefaults.saveBool(value: logined, key: "logind")
//                                  self.performSegue(withIdentifier: "loginCode", sender: self)
//
//                                  }
                        else {
                            self.showLoading = false
                            UserDefaultss().saveBool(value: false, key: "rememberMe")

                            self.toast = Helper.showToast(style: .error, message: msg)

                            }

                        }
                    } catch {
                                    self.showLoading = false
                        UserDefaultss().saveBool(value: false, key: "rememberMe")

                                  Helper.traceCrach(error: error, userToken: "USE-0")
                        toast = Helper.showToast(style: .error, message: NSLocalizedString("message_error_in_fetching_data", comment: ""))
                     }

            }
                catch {
                    self.showLoading = false
                  Helper.traceCrach(error: error, userToken: "USE-0")
                    UserDefaultss().saveBool(value: false, key: "rememberMe")


                    toast = Helper.showToast(style: .error, message: NSLocalizedString("message_error_in_fetching_data", comment: ""))


                }
        } catch {
            self.showLoading = false
          Helper.traceCrach(error: error, userToken: "USE-0")
            UserDefaultss().saveBool(value: false, key: "rememberMe")

            toast = Helper.showToast(style: .error, message: NSLocalizedString("message_error_in_fetching_data", comment: ""))


        }
        
    }
    
    func clearStatesWithAction(valueState: inout Bool) {
    valueState.toggle()
    showDecFromLogin = false
    showSignUp = false
    }
    func getConstantList(){
        do {
            let data = try JSONEncoder().encode(GeneralSearch())
            UserDefaults.standard.set(data, forKey: "apiData")
            do {
                let decoder = JSONDecoder()
                let data = try decoder.decode(GeneralSearch.self, from: data)
                if self.genralVm.lang == self.genralVm.constants.APP_LANGUAGE_AR {
                    data.userAuthorizeToken = self.genralVm.constants.GUEST_AUTH_AR
                } else {
                    data.userAuthorizeToken = self.genralVm.constants.GUEST_AUTH_EN
                }
                data.paginationStatus = "false"
                data.activationTypeTokens = "AST-17400"
                data.filterStatus = "true"
             
           
                do {
                    try Api().getConstantsList(generalSearch:data ,onCompletion: { status, msg, dataa in

                        if status == self.genralVm.constants.STATUS_SUCCESS {
                           
                            self.constantListData = dataa

                            do {
                              
                                let data = try JSONEncoder().encode(dataa)
                                UserDefaults.standard.set(data, forKey: "constantListData")
                                
                            } catch {
                                
                            }
          
                        } else if status == self.genralVm.constants.STATUS_INVALID_TOKEN ||
                                    status == self.genralVm.constants.STATUS_VERSION{
                            Helper.removeUserDefaultsAndCashes()
                            UserDefaults.standard.set(msg, forKey: "logoutMsg")
                        }else {
                          
                        }
                    })
                } catch {
                
                }
                
            } catch {
                
            }
            
            
        } catch {
        }
    }
}
