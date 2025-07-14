//
//  SignUpViewModel.swift
//  FEDS-Center-Dev-IOS
//
//  Created by Mrwan on 27/05/2024.
//

import Foundation
import UIKit
import CountryPicker

class SignUpViewModel : ObservableObject {
    
    @Published var genralVm : GeneralVm = GeneralVm()
    @Published var signupRequestModel : SignUpRequestModel = SignUpRequestModel()
    @Published var user = ""
    @Published var email = ""
    @Published var studentPhoneNum = ""
    @Published var fatherPhoneNum = ""
    @Published var motherPhoneNum = ""
    @Published var password = ""
    @Published var city = ""
    @Published var school = ""
    @Published var confrimPassword = ""
    @Published var selectedAcadmicYearToken: String = ""
    @Published var selectedAcadmicYearName: String = ""
    @Published var selectedPlaceName: String = ""
    @Published var selectedPlaceToken: String = ""
    @Published var selectedUserEducationSystemType: String = ""
    @Published var selectedGovenmentToken: String = ""
    @Published var selectedGovenmentName: String = ""
    
    @Published var selectedGender = 1
    @Published var image = UIImage()
    @Published var countryClient: Country = CountryManager.shared.currentCountry ?? Country.init(countryCode: "IN")
    @Published var countryFather: Country = CountryManager.shared.currentCountry ?? Country.init(countryCode: "IN")
    @Published var countryMother: Country = CountryManager.shared.currentCountry ?? Country.init(countryCode: "IN")
    @Published var toast: Toast? = nil
    @Published var constantListData : ConstantsListsDataa = ConstantsListsDataa()
    @Published var selectedEduSystemTypeOption: String = Constants().EDUCATION_SYSTEM_TYPE_ONLINE

   
    @Published var academicYearsDataList : [ItemsDatum] = []
    @Published var centerPlacesDataList : [ItemsDatum] = []
    @Published var governmentsDataList = [ListData]()

    
    
    @Published var showMenuGovrnorate: Bool = false
    @Published var showMenuCenters: Bool = false
    @Published var showMenuAcadmicYears: Bool = false
    @Published var showLoading: Bool = false
    @Published var showSignIn : Bool = false
    @Published var showDecFromSignup :Bool = false
    @Published var backFromSignup : Bool = false
    @Published var noData : Bool = false
    @Published var isDark : Bool = false
    @Published var showPassword : Bool = false
    @Published var showImagePicker: Bool = false
    @Published var isShowingCountryPicker = false
    @Published var isShowingCountryPickerMother = false
    @Published var isShowingCountryPickerFather = false

    func getFiledsData(){
        if Helper.isConnectedToNetwork() {
            signupRequestModel.clientName = user
            signupRequestModel.userEmail = email
            signupRequestModel.userPassword = password
            signupRequestModel.userPhone = studentPhoneNum
            signupRequestModel.academicYearToken = selectedAcadmicYearToken
            signupRequestModel.governmentToken = selectedGovenmentToken
            signupRequestModel.placeToken = selectedPlaceToken
            signupRequestModel.cityName = city
            signupRequestModel.schoolName = school
            signupRequestModel.fatherPhone = fatherPhoneNum
            signupRequestModel.motherPhone = motherPhoneNum
            signupRequestModel.educationSystemTypeToken = selectedUserEducationSystemType
            
            checkValidation(signUpModel: signupRequestModel)
            
        } else {
            toast = Helper.showToast(style: .error, message: NSLocalizedString("error_connected_to_network", comment: ""))
            return
        }
    }
    
    func checkValidation(signUpModel: SignUpRequestModel){
        
        let isValidClientName : Bool = Validation.IsValidContent(text: signupRequestModel.clientName ?? "")
        let isValidNameAr : Bool = Validation.IsValidNameAr(text: signupRequestModel.clientName ?? "")
        let isValidNameEn : Bool = Validation.IsValidNameEn(text: signupRequestModel.clientName ?? "")
        
        let isValidEmptyEducationSystemTypeToken : Bool = Validation.IsValidContent(text: signupRequestModel.educationSystemTypeToken ?? "")
        let isValidEmptyUserEmail : Bool = Validation.IsValidContent(text: signupRequestModel.userEmail ?? "")
        let isValidEmail = Validation.isValidEmail(email: signupRequestModel.userEmail ?? "")
        
        let isValidEmptyUserPhone : Bool = Validation.IsValidContent(text: signupRequestModel.userPhone ?? "")
        let isValidPhonenumber = Validation.isValidPhone(phone: signupRequestModel.userPhone ?? "", contryCodeName: self.countryClient.countryCode)
        let isValidEmptyAcademicYearToken : Bool = Validation.IsValidContent(text: signupRequestModel.academicYearToken ?? "")
        let isValidEmptyGovermentToken : Bool = Validation.IsValidContent(text: signupRequestModel.governmentToken ?? "")
        let isValidEmptyPlaceToken : Bool = Validation.IsValidContent(text: signupRequestModel.placeToken ?? "")
        let isValidEmptyCityName : Bool = Validation.IsValidContent(text: signupRequestModel.cityName ?? "")
        let isValidEmptySchoolName : Bool = Validation.IsValidContent(text: signupRequestModel.schoolName ?? "")
        
        let isValidEmptyFatherPhone : Bool = Validation.IsValidContent(text: signupRequestModel.fatherPhone ?? "")
        let isValidFatherPhonenumber = Validation.isValidPhone(phone: signupRequestModel.fatherPhone ?? "", contryCodeName: self.countryFather.countryCode)
        
        let isValidEmptyMotherPhone : Bool = Validation.IsValidContent(text: signupRequestModel.motherPhone ?? "")
        let isValidMotherPhonenumber = Validation.isValidPhone(phone: signupRequestModel.motherPhone ?? "", contryCodeName: self.countryMother.countryCode)
        
        
        let isValidEmptyPassword = Validation.IsValidContent(text: signupRequestModel.userPassword ?? "")
        
        
        // valid name
        if !isValidClientName {
            toast = Helper.showToast(style: .error, message: NSLocalizedString("error_name_empty", comment: ""))
            return
        }else{
            if isValidNameAr == false && isValidNameEn == false {
                toast = Helper.showToast(style: .error, message: NSLocalizedString("error_name", comment: ""))
                
                return
            }
            
        }
        
        if isValidNameEn {
            signupRequestModel.clientNameEn = signupRequestModel.clientName ?? ""
        }else {
            signupRequestModel.clientNameAr = signupRequestModel.clientName ?? ""
        }
        
        if AppConstantStatus.isPhoneRequired {
            if !isValidEmptyUserEmail && !isValidEmptyUserPhone {
                toast = Helper.showToast(style: .error, message: NSLocalizedString("error_email_and_phone", comment: ""))
                return
            }
            
            if isValidEmptyUserPhone {
                if !isValidPhonenumber {
                    toast = Helper.showToast(style: .error, message: NSLocalizedString("error_student_phone", comment: ""))
                    return
                }
            }
        }
      
        
        if isValidEmptyUserEmail {
            if !isValidEmail {
                toast = Helper.showToast(style: .error, message: NSLocalizedString("error_email", comment: ""))
                return
            }
        }

        if AppConstantStatus.isParentsRequired {
            if !isValidEmptyFatherPhone && !isValidEmptyMotherPhone {
                toast = Helper.showToast(style: .error, message: NSLocalizedString("empty_mother_or_father_phone", comment: ""))
                return
            }
        
            if isValidEmptyFatherPhone{
                if !isValidFatherPhonenumber {
                    toast = Helper.showToast(style: .error, message: NSLocalizedString("error_father_phone", comment: ""))
                    return
                }
            }
            
            if isValidEmptyMotherPhone{
                if !isValidMotherPhonenumber  {
                    toast = Helper.showToast(style: .error, message: NSLocalizedString("error_mother_phone", comment: ""))
                    return
                }
            }
            
        }
        
        if AppConstantStatus.isEducationSystem {
            
            if !isValidEmptyEducationSystemTypeToken  {
                toast = Helper.showToast(style: .error, message: NSLocalizedString("empty_educationSystem", comment: ""))
                return
            }
            
            
            if selectedEduSystemTypeOption == genralVm.constants.EDUCATION_SYSTEM_TYPE_CENTER {
                if !isValidEmptyPlaceToken{
                    toast = Helper.showToast(style: .error, message: NSLocalizedString("empty_center", comment: ""))
                    return
                }
            }
            
        }
        
        
        if AppConstantStatus.isAcademicYeartRequired {

            if !isValidEmptyAcademicYearToken {
                toast = Helper.showToast(style: .error, message: NSLocalizedString("empty_academicYear", comment: ""))
                return
            }
        }
        
        if AppConstantStatus.isGovernmentRequired {
            
            if !isValidEmptyGovermentToken {
                toast = Helper.showToast(style: .error, message: NSLocalizedString("empty_government", comment: ""))
                return
            }
            
        }
        
        if AppConstantStatus.isCityRequired {
            
            if !isValidEmptyCityName{
                toast = Helper.showToast(style: .error, message: NSLocalizedString("empty_city", comment: ""))
                return
            }
        }
        if AppConstantStatus.isSchoolRequired {
            
            if !isValidEmptySchoolName  {
                toast = Helper.showToast(style: .error, message: NSLocalizedString("empty_school", comment: ""))
                return
            }
        }
    
        
        if !isValidEmptyPassword {
            toast = Helper.showToast(style: .error, message: NSLocalizedString("error_password", comment: ""))
            return
        }
        
        callApi(signUpModel: signupRequestModel)
        
    }
    
    func callApi(signUpModel: SignUpRequestModel){
        showLoading = true
        var json = ""
        do {
            
            var signup = SignUpModel()
            var userData = UserDataSignUp()
            var userDeviceData  = UserDeviceDataSignUp()
            var userContactInfoData =  UserContactInfoData()
            
            signup.languageToken = Language.getLanguageISO()
            
            userData.userPassword = signupRequestModel.userPassword
            userData.userEmail = signupRequestModel.userEmail
            
            userData.userPhone = signupRequestModel.userPhone
            userData.userPhoneCountryCode = self.countryClient.dialingCode
            userData.userPhoneCountryCodeName = self.countryClient.countryCode
            
            
            userData.userTypeToken = self.genralVm.constants.USER_TYPE_TOKEN_STUDENT
            userData.userNameAr = signupRequestModel.clientNameAr
            userData.userNameEn = signupRequestModel.clientNameEn
            
            userContactInfoData.userPlaceToken = signupRequestModel.placeToken
            
            userContactInfoData.userGuardianFatherPhone = signupRequestModel.fatherPhone
            userContactInfoData.userGuardianFatherPhoneCC = self.countryFather.countryCode
            
            userContactInfoData.userGuardianMotherPhone = signupRequestModel.motherPhone
            userContactInfoData.userGuardianMotherPhoneCC = self.countryMother.countryCode
            
            userContactInfoData.userSchool = signupRequestModel.schoolName
            userContactInfoData.userAcademicYearToken = signupRequestModel.academicYearToken
            userContactInfoData.userGovernorateToken = signupRequestModel.governmentToken
            userContactInfoData.userGovernorateCityName = signupRequestModel.cityName
            userContactInfoData.userEducationSystemTypeToken = signupRequestModel.educationSystemTypeToken
            
            
            userDeviceData.userDeviceName = self.genralVm.deviceName
            userDeviceData.userPlatFormToken = self.genralVm.userPlatformTokn
            userDeviceData.userVersionNumber = self.genralVm.appVersion
            userDeviceData.userFirebaseToken = !genralVm.userFirebaseToken.isEmpty || genralVm.userFirebaseToken.count > 0 ? genralVm.userFirebaseToken : "Firbase"
            userDeviceData.userDeviceCompany = "Apple"
            userDeviceData.userDeviceUniqueCode = "\(genralVm.deviceUniqeId ?? UUID())"
            userDeviceData.userDeviceOS = "IOS"
            userDeviceData.userDeviceVersionOS = self.genralVm.deviceOsVersion
            userDeviceData.userDeviceEMUI = "Unknown"
            userDeviceData.userDeviceRam = String(self.genralVm.deviceRam)
            userDeviceData.userDeviceProcessor = self.genralVm.deviceProcessor
            userDeviceData.userDeviceDisplay = "Unknown"
            userDeviceData.userDeviceModel = self.genralVm.deviceModelName
            userDeviceData.userDeviceSerial = "Unknown"
            userDeviceData.userDeviceDescription = self.genralVm.deviceDescrption
            userDeviceData.userDeviceNotes = "Unknown"
            
            signup.userDeviceData = userDeviceData
            userData.userContactInfoData = userContactInfoData
            signup.userData = userData
            
            let jsonEncoder = JSONEncoder()
            let jsonData = try jsonEncoder.encode(signup)
            json = String(data: jsonData, encoding: String.Encoding.utf8)!
            
            do {
                
                try Api().signUp(registrationModule: json) { [self] (status, msg, UsersVersion, APIAppData )in
                    
                    if status == self.genralVm.constants.STATUS_SUCCESS {
                        self.showLoading = false
                        do {
                            let data = try JSONEncoder().encode(APIAppData)
                            UserDefaults.standard.set(data, forKey: "userData")
                            UserDefaults.standard.set(APIAppData.userData?.userTypeToken!, forKey: "userTypeToken")
                            UserDefaults.standard.set(APIAppData.userAuthorizeToken, forKey: "userAuth")
                            UserDefaults.standard.set(APIAppData.userData?.userToken, forKey: "userToken")
                            UserDefaults.standard.set(APIAppData.userLoginSessionToken, forKey: "userLoginSessionToken")
                            UserDefaults.standard.set(APIAppData.userData?.userNameCurrent, forKey: "userNameCurrent")
                            UserDefaults.standard.set(APIAppData.userData?.userImageUrl, forKey: "userImageUrl")
                            UserDefaults.standard.set(APIAppData.userData?.fullCode, forKey: "userFullCode")
                            UserDefaults.standard.set(APIAppData.userData?.userPhoneWithCC, forKey: "phoneNumber")
                            UserDefaultss().saveBool(value: true, key: "rememberMe")
                            UserDefaultss().saveBool(value: APIAppData.userData?.userCanBuyCourseFromWebview ?? false, key:"havePermissionToView")
                            UserDefaultss().saveStrings(value: self.genralVm.constants.ROUTE_FROM_MAIN_PAGE,
                                                        key: self.genralVm.constants.KEY_ROUTE_COURSES)
                            
                            let userAppSettingData = try JSONEncoder().encode(APIAppData.userAppSettingData)
                            UserDefaults.standard.set(userAppSettingData, forKey: self.genralVm.constants.USER_APP_SETTINGS_DATA)
                            
                            if APIAppData.userAppSettingData?.themeToken == self.genralVm.constants.APP_THEME_TOKEN_DARK {
                                self.isDark = true
                                UserDefaultss().saveBool(value: true, key: "isDark")
                            } else {
                                self.isDark = false
                                UserDefaultss().saveBool(value: false, key: "isDark")
                            }
                            
                            
                            let constantListData = try JSONEncoder().encode(APIAppData.constantsListsData)
                            UserDefaults.standard.set(constantListData, forKey: self.genralVm.constants.CONSTANT_LIST_DATA)
                            
                            self.showDecFromSignup = true
                            
                            
                            
                        } catch {
                            self.showLoading = false
                            Helper.traceCrach(error: error, userToken: "USE-0")
                            self.toast = Helper.showToast(style: .error, message: NSLocalizedString("message_error_catch", comment: ""))
                            
                        }
                        
                    } else if status == self.genralVm.constants.STATUS_ERROR {
                        self.showLoading = false
                        
                        self.toast = Helper.showToast(style: .error, message: msg)
                        
                    } else if status == self.genralVm.constants.STATUS_CATCH {
                        self.showLoading = false
                        self.toast = Helper.showToast(style: .error, message: msg)
                        
                        
                    } else if status == self.genralVm.constants.STATUS_VERSION {
                        self.showLoading = false
                        
                        
                        self.toast = Helper.showToast(style: .error, message: msg)
                        
                        //                              self.dispalyUpdateAlert(titile: NSLocalizedString("alert", comment: ""), message: msg, actionTitle: NSLocalizedString("Update", comment: ""), linkDownload: UsersVersion.versionLinkDownload ?? "https://apps.apple.com/app/save-card/id1609418366")
                        
                    } else {
                        self.showLoading = false
                        self.toast = Helper.showToast(style: .error, message: msg)
                        
                        
                    }
                    
                }
            } catch {
                self.showLoading = false
                Helper.traceCrach(error: error, userToken: "USE-0")
                self.toast = Helper.showToast(style: .error, message: NSLocalizedString("message_error_catch", comment: ""))
            }
            
        }
        catch {
            self.showLoading = false
            Helper.traceCrach(error: error, userToken: "USE-0")
            
            self.toast = Helper.showToast(style: .error, message: NSLocalizedString("message_error_catch", comment: ""))
    
            
        }
    }
    
    func clearStatesWithAction(valueState: inout Bool) {
        valueState.toggle()
        showDecFromSignup = false
        showSignIn = false
    }
    
    func getAcademicYears(){
        self.showLoading = true
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
                data.isAcademicYear = "true"
                
                
                do {
                    try Api().getAcademicYears(generalSearch:data ,onCompletion: { status, msg, data in
                        
                        if status == self.genralVm.constants.STATUS_SUCCESS {
                            self.showLoading = false
                            self.noData = false
                            self.academicYearsDataList = []
                            DispatchQueue.main.asyncAfter(deadline: .now()){
                                self.academicYearsDataList.append(contentsOf: data)
                                self.showMenuAcadmicYears = true
                            }
                            
                        } else if status == self.genralVm.constants.STATUS_INVALID_TOKEN ||
                                    status == self.genralVm.constants.STATUS_VERSION{
                            self.showLoading = false
                            Helper.removeUserDefaultsAndCashes()
                            UserDefaults.standard.set(msg, forKey: "logoutMsg")
                        }else {
                            self.toast = Helper.showToast(style: .error, message: msg)
                            self.showLoading = false
                            self.noData = true
                        }
                    })
                } catch {
                    
                }
                
            } catch {
                
            }
            
            
        } catch {
        }
    }
    
    func getCenterPlacesData(){
        self.showLoading = true
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
                data.getOnlyParentPlaces = "true"
                
                do {
                    try Api().getCenterPlaces(generalSearch:data ,onCompletion: { status, msg, data in
                        
                        if status == self.genralVm.constants.STATUS_SUCCESS {
                            self.centerPlacesDataList = []
                            self.noData = false
                            self.showLoading = false
                            DispatchQueue.main.asyncAfter(deadline: .now()){
                                self.centerPlacesDataList.append(contentsOf: data)
                                self.showMenuCenters = true
                            }
                        } else if status == self.genralVm.constants.STATUS_INVALID_TOKEN ||
                                    status == self.genralVm.constants.STATUS_VERSION{
                            Helper.removeUserDefaultsAndCashes()
                            UserDefaults.standard.set(msg, forKey: "logoutMsg")
                        }else {
                            self.toast = Helper.showToast(style: .error, message: msg)
                            self.showLoading = false
                            self.noData = true
                        }
                    })
                } catch {
                    
                }
                
            } catch {
                
            }
            
            
        } catch {
        }
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
                            self.noData = false
                            self.showLoading = false
                            self.constantListData = dataa
                            
                            do {
                                
                                let data = try JSONEncoder().encode(dataa)
                                UserDefaults.standard.set(data, forKey: "constantListData")
                                    self.getGovernmentsData()
                            } catch {
                                
                            }
                            
                        } else if status == self.genralVm.constants.STATUS_INVALID_TOKEN ||
                                    status == self.genralVm.constants.STATUS_VERSION{
                            Helper.removeUserDefaultsAndCashes()
                            UserDefaults.standard.set(msg, forKey: "logoutMsg")
                        }else {
                            self.toast = Helper.showToast(style: .error, message: msg)
                            self.showLoading = false
                            self.noData = true
                        }
                    })
                } catch {
                    
                }
                
            } catch {
                
            }
            
            
        } catch {
        }
    }
    
    func getGovernmentsData() {
        DispatchQueue.main.asyncAfter(deadline: .now()){
            do {
                
                if let data = UserDefaults.standard.data(forKey: "constantListData") {
                    let decodedData = try JSONDecoder().decode(ConstantsListsDataa.self, from: data)
                    self.governmentsDataList.append(contentsOf: decodedData.listGovernorateType!)
                    self.showMenuGovrnorate = true
                } else {
                    print("No data found for key 'constantListData'")
                }
                
            } catch {
                print("Failed to decode data: \(error)")
            }
        }
    }
    
}
