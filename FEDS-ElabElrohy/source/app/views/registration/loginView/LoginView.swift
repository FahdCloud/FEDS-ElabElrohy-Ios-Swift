//
//  LoginView.swift
//  FPLS-Dev
//
//  Created by Mrwan on 27/08/2023.
//

import SwiftUI
import AZDialogView

@available(iOS 16.0, *)
struct LoginView: View {
    @StateObject var genralVm : GeneralVm = GeneralVm()
    
    var deviceProcessor = UIDevice.current.getCPUName()
    let deviceModelName = UIDevice.modelName
    let deviceRam = ProcessInfo.processInfo.physicalMemory/1073741824
    let deviceOS = ProcessInfo.processInfo.operatingSystemVersionString
    let deviceOsVersion = UIDevice.current.systemVersion
    let deviceName = UIDevice.current.name
    let deviceDescrption = UIDevice.current.description
    var systemVersion = UIDevice.current.systemVersion
    let deviceUniqeId = UIDevice.current.identifierForVendor
    let userPlatformTokn = "PFT-1"
    let havePermissionToView  = UserDefaultss().restoreBool(key: "havePermissionToView")
    let appVersion =  Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
    
    @State var user = ""
    @State var password = ""
    @State private var msgVersion = ""
    @State private var urlVersion = ""
    
    @State private var showDecFromLogin :Bool = false
    @State private var showForgetPasswordFromLogin :Bool = false
    @State private var showAZDialogVersion :Bool = false
    @State private var showAZDialog :Bool = false
    @State private var showPassword : Bool = false
    @State private var showSignUp : Bool = false
    @State private var showLoading : Bool = false
    @State private var showForgetPassword : Bool = false
    @State private var toast: Toast? = nil
    @State private var backFromLogin : Bool = false
    @FocusState private var isUserInputActive: Bool
    
    var body: some View {
        
        ZStack{
            background
            if showSignUp {
                SignUp()
                
            } else {
                VStack {
                    Spacer()
                    
                    ZStack {
                        ScrollView(showsIndicators: false) {
                            contentStack
                        }
                    }
                    .onTapGesture {
                        self.hideKeyboard()
                    }
                    .background(Color.white)
                    .cornerRadius(40)
                    .edgesIgnoringSafeArea(.bottom)
                    .toastView(toast: $toast)
                }
            }
            
            if showLoading {
                LoadingView(placHolder: NSLocalizedString("loading", comment: ""))
            }
        }
        
        .gesture(
            DragGesture()
                .onEnded { value in
                    // Check if the drag was mainly horizontal (left or right)
                    if abs(value.translation.width) > abs(value.translation.height) {
                        // Check if the drag was towards the left
                        if value.translation.width < 0 {
                            // Perform your action here
                            clearStatesWithAction(valueState: &backFromLogin)
                        } else if value.translation.width > 0 {
                            clearStatesWithAction(valueState: &backFromLogin)
                        }
                    }
                }
        )
        .fullScreenCover(isPresented: $backFromLogin, content: {
            RegistrationView()
        })
        .fullScreenCover(isPresented: $showForgetPasswordFromLogin, content: {
            ForgetPassView()
        })
        
        .onDisappear {
            clearStatesWithAction(valueState: &genralVm.dissapearView)
        }
    }
    
    var background: some View {
        VStack {
            Image("backgroun-Splash")
                .resizable()
                .edgesIgnoringSafeArea(.all)
        }
    }
    
    var contentStack: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 20) {
                Image("vector")
                    .resizable()
                    .frame(width: 250, height: 250)
                
                welcomeBackText
                VStack(spacing:-10) {
                    usernameField
                    passwordField
                    forgetPassword
                }
                loginButton
                signUpLink
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color.white)
            .cornerRadius(40)
            .padding()
        }
    }
    
    var topImage : some View {
        VStack {
            Image("vector")
                .resizable()
                .frame(width: 250, height: 250)
            
        }
    }
    
    var welcomeBackText: some View {
        Text(NSLocalizedString("welcomeBackLogin", comment: ""))
            .font(Font.custom(Fonts().getFontBold(), size: 30).weight(.bold))
            .foregroundStyle(Color(Colors().mainButtonColor.cgColor))
    }
    
    var forgetPassword: some View {
        HStack{
            Spacer()
            Button(NSLocalizedString("forgetPassword", comment: "")) {
                showForgetPasswordFromLogin.toggle()
            }
            .font(Font.custom(Fonts().getFontBold(), size: 20).weight(.bold))
            .foregroundStyle(Color(Colors().mainButtonColor.cgColor))
            .padding()
            
        }
    }
    
    var usernameField: some View {
        VStack{
            TextField("", text: $user)
                .textFieldStyle(
                    CustomTextFieldStyle(placeholder: NSLocalizedString("userNameFiled", comment: ""),
                                         placeholderColor: .black,
                                         placeholderBgColor: .white,
                                         image: "person",
                                         isPassword: false,
                                         isEditing: !self.user.isEmpty,
                                         isTapped: $showPassword)
                )
                .autocorrectionDisabled()
                .textInputAutocapitalization(.never)
        }
        .padding()
    }
    var passwordField: some View {
        
        VStack{
            if showPassword{
                TextField("", text: $password)
                    .textFieldStyle(
                        CustomTextFieldStyle(placeholder: NSLocalizedString("userPasswordFiled", comment: ""),
                                             placeholderColor: .black,
                                             placeholderBgColor: .white,
                                             image: "lock-fill",
                                             isPassword: true,
                                             isEditing: !self.password.isEmpty,
                                             isTapped: $showPassword)
                    )
            } else {
                SecureField("", text: $password)
                    .textFieldStyle(
                        CustomTextFieldStyle(placeholder: NSLocalizedString("userPasswordFiled", comment: ""),
                                             placeholderColor: .black,
                                             placeholderBgColor: .white,
                                             image: "lock-fill",
                                             isPassword: true,
                                             isEditing: !self.password.isEmpty,
                                             isTapped: $showPassword)
                    )
            }
        }
        .padding()
    }
    
    var loginButton: some View {
        HStack(alignment: .center, spacing: 5) {
            
            Button {
                getFiledsData()
            } label: {
                Text(NSLocalizedString("loginBtn", comment: ""))
                    .frame(width: 234, height: 58)
                    .font(
                        Font.custom(Fonts().getFontBold(), size: 24)
                            .weight(.bold)
                    )
                    .foregroundStyle(Color.white)
            }
            .fullScreenCover(isPresented: $showDecFromLogin, content: {
                DeclarationView()
            })
            
        }
        .padding(.horizontal, 82)
        .padding(.vertical, 16)
        .frame(width: 234, height: 58, alignment: .center)
        .background(Color(Colors().mainButtonColor.cgColor))
        .background(AzDialogVersionAlert(isPresented: $showAZDialogVersion,
                                         dismissAzDialogActions:false,
                                         dismissAzDialogDirection: .none,
                                         title: NSLocalizedString("alert", comment: ""),
                                         message: msgVersion,
                                         imageTop: "download_icon",
                                         buttonClick: NSLocalizedString("download", comment: ""),
                                         onClick: {
            let validDownloadLink = Validation.IsValidContent(text: urlVersion)
            if validDownloadLink {
                UIApplication.tryURL(urlString: urlVersion)
            }else{
                toast = Helper.showToast(style: .error, message: NSLocalizedString("meesage_error_there_is_no_link", comment: ""))
            }
            
            
        }))
        .cornerRadius(10)
    }
    
    var signUpLink: some View {
        HStack(spacing: 6){
            Text(NSLocalizedString("doYouHaveAnAccount", comment: ""))
                .font(
                    Font.custom(Fonts().getFontLight(), size: 20)
                        .weight(.light)
                )
                .foregroundStyle(genralVm.isDark ? Color(Colors().darkBodyText): Color(Colors().lightBodyText))
            
            Button {
                withAnimation(Animation
                    .default
                ) {
                    showSignUp.toggle()
                }
            } label: {
                Text(NSLocalizedString("createAccount", comment: ""))
                    .font(Font.custom(Fonts().getFontBold(), size: 20).weight(.bold))
                    .foregroundStyle(Color(Colors().mainButtonColor.cgColor))
            }
        }
        .padding(.bottom,20)
    }
    
    
}

@available(iOS 16.0, *)
extension LoginView {
    // functions
  
    private func getFiledsData(){
        if Helper.isConnectedToNetwork() {
         
            let userEmailOrPhonenumber : String = user
            let userPassword : String = password
            
            checkValidation(userEmailOrPhone: userEmailOrPhonenumber, userPassword: userPassword)
        } else {
            toast = Helper.showToast(style: .error, message: NSLocalizedString("error_connected_to_network", comment: ""))
            return
        }
    }
    
    private func clearStatesWithAction(valueState: inout Bool) {
        valueState.toggle()
        showDecFromLogin = false
        showSignUp = false
      }
    
    private func checkValidation(userEmailOrPhone : String , userPassword:String){
      
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
    
    
    private func callApi(userEmail:String , userPassword:String) {
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
                userDeviceData.userDeviceName = self.deviceName
                userDeviceData.userPlatFormToken = self.userPlatformTokn
                userDeviceData.userVersionNumber = self.appVersion
                userDeviceData.userFirebaseToken = !genralVm.userFirebaseToken.isEmpty || genralVm.userFirebaseToken.count > 0 ? genralVm.userFirebaseToken : "Firbase"
                userDeviceData.userDeviceCompany = "Apple"
                userDeviceData.userDeviceUniqueCode = "\(deviceUniqeId ?? UUID())"
                userDeviceData.userDeviceOS = "IOS"
                userDeviceData.userDeviceVersionOS = self.deviceOsVersion
                userDeviceData.userDeviceEMUI = "Unknown"
                userDeviceData.userDeviceRam = String(self.deviceRam)
                userDeviceData.userDeviceProcessor = self.deviceProcessor
                userDeviceData.userDeviceDisplay = "Unknown"
                userDeviceData.userDeviceModel = self.deviceModelName
                userDeviceData.userDeviceSerial = "Unknown"
                userDeviceData.userDeviceDescription = self.deviceDescrption
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
                                    genralVm.isDark = true
                                    UserDefaultss().saveBool(value: true, key: "isDark")
                                } else {
                                    genralVm.isDark = false
                                    UserDefaultss().saveBool(value: false, key: "isDark")
                                }
                                          let userAppSettingData = try JSONEncoder().encode(APIAppData.userAppSettingData)
                                          UserDefaults.standard.set(userAppSettingData, forKey: self.genralVm.constants.USER_APP_SETTINGS_DATA)
                                            let constantListData = try JSONEncoder().encode(APIAppData.constantsListsData)
                                          UserDefaults.standard.set(constantListData, forKey: self.genralVm.constants.CONSTANT_LIST_DATA)
                                        
                        
                                if APIAppData.userData?.userTypeToken == genralVm.constants.USER_TYPE_TOKEN_FAMILY {
                                    let children = try JSONEncoder().encode(APIAppData.userData?.myChildren)
                                    UserDefaults.standard.set(children, forKey: "childrenData")
                              

                                }
                                
                                self.showDecFromLogin = true
                                      } catch {
                                          self.showLoading = false
                                        Helper.traceCrach(error: error, userToken: "USE-0")
                                          toast = Helper.showToast(style: .error, message: NSLocalizedString("error_email", comment: ""))
                                      }

                          } else if status == self.genralVm.constants.STATUS_ERROR {
                              self.showLoading = false
                           
                              toast = Helper.showToast(style: .error, message: msg)

                          } else if status == self.genralVm.constants.STATUS_VERSION{
                              self.showLoading = false
                              self.showAZDialogVersion.toggle()
                              self.msgVersion = msg
                               urlVersion = UsersVersion.versionLinkDownload ?? ""
                              
                          } else if status == self.genralVm.constants.STATUS_CATCH {
                              self.showLoading = false
                           
                              toast = Helper.showToast(style: .error, message: msg)

                          }else if status == self.genralVm.constants.STATUS_NO_CONTENT {
                              self.showLoading = false
                            toast = Helper.showToast(style: .error, message: msg)

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

                            toast = Helper.showToast(style: .error, message: msg)

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
}

@available(iOS 16.0, *)
struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}


extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
