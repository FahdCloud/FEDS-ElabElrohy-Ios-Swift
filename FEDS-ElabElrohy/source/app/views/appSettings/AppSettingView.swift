//
//  Setting.swift
//  FEDS-Center-Dev-IOS
//
//  Created by Omar Pakr on 30/03/2024.
//

import SwiftUI
@available(iOS 16.0, *)

struct AppSettingView: View {
    @StateObject var userAppSettingVm : AppSettingVm = AppSettingVm()
    @StateObject var genralVm : GeneralVm = GeneralVm()
    
    @State private var receiveNotifications = true
    @State private var dateTime = Date()
    @State private var pageSize = 10
    @State private var selectedTheme: String = ""
    @State private var selectedThemeToken: String = ""
    @State private var selectedPage: String = ""
    @State private var selectedLanguage: String = ""
    @State private var selectedLanguageToken: String = ""
    @State private var selectedTimeZone: String = ""
    @State private var selectedDateFormate: String = ""
    @State private var selectedTimeFormate: String = ""
    @State private var selectedTimeZoneToken: String = ""
    @State private var selectedDateFormateToken: String = ""
    @State private var selectedTimeFormateToken: String = ""
    @State private var showingTimeZonePicker: Bool = false
    @State private var showingTimeFormatePicker: Bool = false
    @State private var showingDateFormatePicker: Bool = false
    @State private var toast: Toast? = nil
    @State private var showMoreFromSettings: Bool = false
    @State private var showRegFromSetting: Bool = false
    @State private var dissapearView : Bool = false

    @State var timeZoneData : [Lists] = []
    @State var dateFormate : [Lists] = []
    @State var timeFormate : [Lists] = []
    let options = [NSLocalizedString("light", comment: ""), NSLocalizedString("dark", comment: "")]
    let pages = ["30","50","100","500","1000"]
    let languages = ["English", "Arabic"]
    var itemInPages = UserDefaultss().restoreString(key: "selectedPage")
   
    
    var body: some View {
        NavigationView {
            VStack {
                ZStack(alignment: .top) {
                    Rectangle()
                        .fill(genralVm.isDark ? Color(Colors().darkCardBg): Color(Colors().lightCardBg))
                        .frame(height: 200) // Adjust height as needed
                        .edgesIgnoringSafeArea(.top)
                        .cornerRadius(40, corners: [.allCorners])
                    
                    
                    HStack (spacing:10){
                        Image("setting_more")
                            .resizable()
                            .frame(width: 80,height: 80)
                        
                        Text(NSLocalizedString("appSetting", comment: ""))
                            .font(
                                Font.custom(Fonts().getFontBold(), size: 30)
                                    .weight(.bold)
                            )
                            .foregroundColor(genralVm.isDark ? Color(Colors().darkBodyText): Color(Colors().lightBodyText))
                        
                    }
                    .padding(.top, 70)
                    
                    
                }
                
                // Main content
                VStack(spacing: 4){
                    ScrollView {
                        VStack(alignment: .leading, spacing: 15) {
                            
                            HStack (spacing:20){
                                Image("bell")
                                    .resizable()
                                    .frame(width: 30,height: 30)
                                
                                Toggle(isOn: $receiveNotifications) {
                                    Text(NSLocalizedString("reciveNotifi", comment: ""))
                                        .font(
                                            Font.custom(Fonts().getFontBold(), size: 20)
                                                .weight(.bold)
                                        )
                                        .foregroundColor(genralVm.isDark ? Color(Colors().darkBodyText): Color(Colors().lightBodyText))
                                }
                                
                            }
                            Divider()
                            
                            HStack (spacing:20){
                                Image("languages")
                                    .resizable()
                                    .frame(width: 30,height: 30)
                                
                                
                                Text(NSLocalizedString("lang", comment: ""))
                                    .font(
                                        Font.custom(Fonts().getFontBold(), size: 18)
                                            .weight(.bold)
                                    )
                                    .foregroundColor(genralVm.isDark ? Color(Colors().darkBodyText): Color(Colors().lightBodyText))
                                
                                
                                HStack {
                                    ForEach(languages, id: \.self) { option in
                                        CustomRadioButton(text: option, isSelected: option == selectedLanguage) {
                                            selectedLanguage = option
                                            if option == "Arabic" {
                                                self.selectedLanguageToken = Constants().APP_LANGUAGE_AR
                                            } else if option == "English" {
                                                self.selectedLanguageToken = Constants().API_LANGUAGE_EN
                                            }
                                        }
                                    }
                                }
                                .frame(maxWidth: .infinity, alignment: .trailing)
                            }
                            Divider()
                            
                            HStack (spacing:20){
                                Image("themes")
                                    .resizable()
                                    .frame(width: 30,height: 30)
                                
                                
                                Text(NSLocalizedString("theme", comment: ""))
                                    .font(
                                        Font.custom(Fonts().getFontBold(), size: 18)
                                            .weight(.bold)
                                    )
                                    .foregroundColor(genralVm.isDark ? Color(Colors().darkBodyText): Color(Colors().lightBodyText))
                                
                                
                                HStack {
                                    ForEach(options, id: \.self) { option in
                                        CustomRadioButton(text: option, isSelected: option == selectedTheme) {
                                            selectedTheme = option
                                            if option == NSLocalizedString("dark", comment: "") {
                                                self.selectedThemeToken = Constants().APP_THEME_TOKEN_DARK
                                            } else {
                                                self.selectedThemeToken = Constants().APP_THEME_TOKEN_LIGHT
                                            }
                                        }
                                    }
                                }
                                .frame(maxWidth: .infinity, alignment: .trailing)
                                
                            }
                            Divider()
                            
                            
                            HStack {
                                Image("appSetting_time_zone")
                                    .resizable()
                                    .frame(width:25,height:25)
                                Text(selectedTimeZone.isEmpty ? NSLocalizedString("selectTimeZone", comment: "") : selectedTimeZone)
                                    .font(
                                        Font.custom(Fonts().getFontBold(), size: 16)
                                            .weight(.bold)
                                    )
                                    .foregroundColor(genralVm.isDark ? Color(Colors().darkBodyText): Color(Colors().lightBodyText))
                                
                                Spacer()
                                Image(systemName: "xmark")
                                    .foregroundColor(.gray)
                                    .onTapGesture {
                                        selectedTimeZone = ""
                                        selectedTimeZoneToken = ""
                                    }
                                Image(systemName: "chevron.down")
                                    .foregroundColor(.gray)
                            }
                            .padding(.all, 10)
                            .overlay(
                                RoundedRectangle(cornerRadius: 5)
                                    .stroke(Color.gray, lineWidth: 1)
                            )
                            .onTapGesture {
                                showingTimeZonePicker = true
                            }
                            .popover(isPresented: $showingTimeZonePicker, content: {
                                VStack {
                                    ZStack {
                                        if userAppSettingVm.tomeZoneData.isEmpty {
                                            NoContent(message: "no data")
                                        } else {
                                            List {
                                                ForEach(userAppSettingVm.tomeZoneData,id: \.itemToken) { user in
                                                    HStack (spacing: 10){
                                                        CustomImageUrl(url: user.itemThumbnailImageUrl ?? "")
                                                        if self.genralVm.lang == Constants().APP_IOS_LANGUAGE_AR{
                                                            Text(user.itemNameAr ?? "")
                                                        }else {
                                                            Text(user.itemNameEn ?? "")
                                                        }
                                                        Spacer()
                                                    }
                                                    .onTapGesture {
                                                        if self.genralVm.lang == Constants().APP_IOS_LANGUAGE_AR{
                                                            self.selectedTimeZone = user.itemNameAr ?? ""
                                                        }else {
                                                            self.selectedTimeZone = user.itemNameEn ?? ""
                                                        }
                                                        self.selectedTimeZoneToken = user.itemToken ?? ""
                                                        showingTimeZonePicker = false
                                                    }
                                                    .padding()
                                                }
                                                .listStyle(.insetGrouped)
                                            }
                                        }
                                    }
                                }
                                .onAppear {
                                    userAppSettingVm.getTimeZoneData()
                                }
                            })
                            
                            Divider()
                            HStack {
                                Image("appSetting_calender")
                                    .resizable()
                                    .frame(width:25,height:25)
                                Text(selectedDateFormate.isEmpty ? NSLocalizedString("selectDateFormate", comment: "") : selectedDateFormate)
                                    .font(
                                        Font.custom(Fonts().getFontBold(), size: 16)
                                            .weight(.bold)
                                    )
                                    .foregroundColor(genralVm.isDark ? Color(Colors().darkBodyText): Color(Colors().lightBodyText))
                                Spacer()
                                Image(systemName: "xmark")
                                    .foregroundColor(.gray)
                                    .onTapGesture {
                                        selectedDateFormate = ""
                                        selectedDateFormateToken = ""
                                    }
                                Image(systemName: "chevron.down")
                                    .foregroundColor(.gray)
                            }
                            .padding(.all, 10)
                            .overlay(
                                RoundedRectangle(cornerRadius: 5)
                                    .stroke(Color.gray, lineWidth: 1)
                            )
                            .onTapGesture {
                                showingDateFormatePicker = true
                            }
                            .popover(isPresented: $showingDateFormatePicker, content: {
                                VStack {
                                    ZStack {
                                        if self.userAppSettingVm.dateFormateData.isEmpty {
                                            NoContent(message: "no data")
                                        } else {
                                            List {
                                                ForEach(self.userAppSettingVm.dateFormateData,id: \.itemToken) { user in
                                                    HStack (spacing: 10){
                                                        CustomImageUrl(url: user.itemThumbnailImageUrl ?? "")
                                                        if self.genralVm.lang == Constants().APP_IOS_LANGUAGE_AR{
                                                            Text(user.itemNameAr ?? "")
                                                        }else {
                                                            Text(user.itemNameEn ?? "")
                                                        }
                                                        Spacer()
                                                    }
                                                    .onTapGesture {
                                                        if self.genralVm.lang == Constants().APP_IOS_LANGUAGE_AR{
                                                            self.selectedDateFormate = user.itemNameAr ?? ""
                                                        }else {
                                                            self.selectedDateFormate = user.itemNameEn ?? ""
                                                        }
                                                        self.selectedDateFormateToken = user.itemToken ?? ""
                                                        showingDateFormatePicker = false
                                                    }
                                                    .padding()
                                                }
                                                .listStyle(.insetGrouped)
                                            }
                                        }
                                    }
                                }
                                .onAppear {
                                    self.userAppSettingVm.getDateFormateData()
                                }
                            })
                            
                            
                            Divider()
                            HStack {
                                Image("appSetting_clock")
                                    .resizable()
                                    .frame(width:25,height:25)
                                Text(selectedTimeFormate.isEmpty ? NSLocalizedString("selectTimeFormate", comment: "") : selectedTimeFormate)
                                    .font(
                                        Font.custom(Fonts().getFontBold(), size: 16)
                                            .weight(.bold)
                                    )
                                    .foregroundColor(genralVm.isDark ? Color(Colors().darkBodyText): Color(Colors().lightBodyText))
                                
                                Spacer()
                                Image(systemName: "xmark")
                                    .foregroundColor(.gray)
                                    .onTapGesture {
                                        selectedTimeFormate = ""
                                        selectedTimeFormateToken = ""
                                    }
                                Image(systemName: "chevron.down")
                                    .foregroundColor(.gray)
                            }
                            .padding(.all, 10)
                            .overlay(
                                RoundedRectangle(cornerRadius: 5)
                                    .stroke(Color.gray, lineWidth: 1)
                            )
                            .onTapGesture {
                                showingTimeFormatePicker = true
                            }
                            .popover(isPresented: $showingTimeFormatePicker, content: {
                                VStack {
                                    ZStack {
                                        if userAppSettingVm.timeFormateData.isEmpty {
                                            NoContent(message: "no data")
                                        } else {
                                            List {
                                                ForEach(userAppSettingVm.dateFormateData,id: \.itemToken) { user in
                                                    HStack (spacing: 10){
                                                        CustomImageUrl(url: user.itemThumbnailImageUrl ?? "")
                                                        if self.genralVm.lang == Constants().APP_IOS_LANGUAGE_AR{
                                                            Text(user.itemNameAr ?? "")
                                                        }else {
                                                            Text(user.itemNameEn ?? "")
                                                        }
                                                        Spacer()
                                                    }
                                                    .onTapGesture {
                                                        if self.genralVm.lang == Constants().APP_IOS_LANGUAGE_AR{
                                                            self.selectedTimeFormate = user.itemNameAr ?? ""
                                                        } else {
                                                            self.selectedTimeFormate = user.itemNameEn ?? ""
                                                        }
                                                        self.selectedTimeFormateToken = user.itemToken ?? ""
                                                        showingTimeFormatePicker = false
                                                        
                                                    }
                                                    .padding()
                                                }
                                                .listStyle(.insetGrouped)
                                            }
                                        }
                                    }
                                }
                                .onAppear {
                                    userAppSettingVm.getTimeFormateData()
                                }
                            })
                            
                            Divider()
                            
                            VStack(spacing:20) {
                                HStack (spacing:20){
                                    Image("item_of_pages")
                                        .resizable()
                                        .frame(width: 30,height: 30)
                                    
                                    Text(NSLocalizedString("itemOfPage", comment: ""))
                                        .font(
                                            Font.custom(Fonts().getFontBold(), size: 16)
                                                .weight(.bold)
                                        )
                                        .foregroundColor(genralVm.isDark ? Color(Colors().darkBodyText): Color(Colors().lightBodyText))
                                    
                                }
                                .frame(maxWidth: .infinity, alignment: .leading)
                                
                                HStack (spacing:8){
                                    ForEach(pages, id: \.self) { option in
                                        CustomRadioButton(text: option, isSelected: option == selectedPage) {
                                            selectedPage = option
                                            UserDefaultss().saveStrings(value: selectedPage, key: "selectedPage")
                                        }
                                    }
                                }
                                .frame(maxWidth: .infinity, alignment: .center)
                                
                            }
                            
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding()
                        
                        
                        
                    }
                }
                .background(genralVm.isDark ? Color(Colors().darkBodyBg): Color(Colors().lightBodyBg))
                .cornerRadius(10) // Set the corner radius here
                .shadow(color: genralVm.isDark ? .white: .black, radius: 5, x: 0, y: 2) // Adds shadow around the
                .padding(.top, -45)
                .padding(.horizontal, 10)
                .padding(.bottom, 15)
                
                Spacer()
                
                ButtonAction(text:NSLocalizedString("save", comment: ""), color: .green) {
                    
                    saveSettings()
                    
                    showMoreFromSettings = false
                    
                }
                
                .background(AzDialogActions(isPresented: $userAppSettingVm.closeApp, dismissAzDialogActions:false,
                                            dismissAzDialogDirection: .none,
                                            showDismissButton: false, title: NSLocalizedString("alert", comment: ""), message: NSLocalizedString("message_restart_app", comment: ""), imageTop: "close_button", buttonClick: NSLocalizedString("close", comment: ""), onClick: {
                    close()
                }))
                .padding(.bottom, 25)
                .padding(.horizontal, 10)
                .shadow(color: genralVm.isDark ? .white: .black, radius: 5, x: 0, y: 2)
                
            }
            .background(genralVm.isDark ? Color(Colors().darkBodyBg): Color(Colors().lightBodyBg))
            .ipad()
            .edgesIgnoringSafeArea(.all)
            .overlay(
                userAppSettingVm.isLoading ?
                GeometryReader { geometry in
                    ZStack {
                        LoadingView(placHolder: NSLocalizedString("loading", comment: ""))
                            .background(Color(Colors().lightCardBgWhite))
                            .frame(width: geometry.size.width, height: geometry.size.height)
                            .transition(.scale)
                    } } : nil
            )
           
            .gesture(
                DragGesture()
                    .onEnded { value in
                        // Check if the drag was towards the left
                        
                        if value.translation.width < 0 {
                            clearStatesWithAction(valueState: &showMoreFromSettings)
                        }else if value.translation.width > 0 {
                           clearStatesWithAction(valueState: &showMoreFromSettings)
                        }
                    }
            )
            .refreshable {
                userAppSettingVm.getAppSettings()
            }
            .fullScreenCover(isPresented: $showMoreFromSettings, content: {
                StudentMainTabView()
                   
            })
            
            .onAppear(perform: {
                
                if let savedData = UserDefaults.standard.data(forKey: "userData") {
                    do {
                        let decoder = JSONDecoder()
                        let userDataSaved = try decoder.decode(APIAppData.self, from: savedData)
                        let userAppSettingData = userDataSaved.userAppSettingData
                        
            
                        
                        if (userAppSettingData?.receiveNotificationStatus ?? false){
                            self.receiveNotifications = true
                        } else {
                            self.receiveNotifications = false
                        }
                        
                        if userAppSettingData?.themeToken == Constants().APP_THEME_TOKEN_DARK {
                            self.selectedTheme = self.options[1]
                            self.selectedThemeToken = Constants().APP_THEME_TOKEN_DARK
                        } else {
                            self.selectedTheme = self.options[0]
                            self.selectedThemeToken = Constants().APP_THEME_TOKEN_LIGHT
                        }
                        
                        if userAppSettingData?.languageToken == Constants().APP_LANGUAGE_AR {
                            self.selectedLanguage = self.languages[1]
                            self.selectedLanguageToken = Constants().APP_LANGUAGE_AR
                        } else {
                            self.selectedLanguage = self.languages[0]
                            self.selectedLanguageToken =  Constants().API_LANGUAGE_EN
                        }
                        
                        
                        self.selectedTimeZone = userAppSettingData?.timeZoneNameCurrent ?? ""
                        self.selectedDateFormate = userAppSettingData?.dateFormatNameCurrent ?? ""
                        self.selectedTimeFormate = userAppSettingData?.timeFormatNameCurrent ?? ""
                        self.selectedTimeZoneToken = userAppSettingData?.timeZoneToken ?? ""
                        self.selectedDateFormateToken = userAppSettingData?.dateFormatToken ?? ""
                        self.selectedTimeFormateToken = userAppSettingData?.timeFormatToken ?? ""
                        self.selectedPage = self.itemInPages
                        
                        
                        
                    } catch {
                        print("Error decoding userAppSettingData:", error)
                    }
                } else {
                    print("No data found for key 'userAppSettingData' in UserDefaults")
                }
                
            })
            .toastView(toast: $toast)
            .onDisappear {
                clearStatesWithAction(valueState: &dissapearView)
            }
        }
    }
    
    
    
    private func close(){
        if selectedThemeToken == Constants().APP_THEME_TOKEN_DARK {
            UserDefaultss().saveBool(value: true, key: "isDark")
        } else if selectedThemeToken == Constants().APP_THEME_TOKEN_LIGHT {
            UserDefaultss().saveBool(value: false, key: "isDark")
        }
        exit(0)
    }
    
    private func saveSettings(){
        
        let lang = self.selectedLanguageToken
        let theme = self.selectedThemeToken
        
        let timeZone = self.selectedTimeZoneToken
        let dateFormate = self.selectedDateFormateToken
        let timeFormate = self.selectedTimeFormateToken
        
        var notificationChecked = "false"
        
        if (self.receiveNotifications){
         notificationChecked = "true"
        }
    
        
        userAppSettingVm.updateUserAppSetting(languageToken: lang, themeToken: theme, timeZoneToken: timeZone, dateFormateToken: dateFormate, timeFormate: timeFormate, customSettings: "", receiveNotificationStatus: notificationChecked)
        
    }
    
    
    func getTimeZoneData(){
        if let data = UserDefaults.standard.data(forKey: Constants().CONSTANT_LIST_DATA) {
            do {
                let decoder = JSONDecoder()
                let constantListData = try decoder.decode(ConstantsListsData.self, from: data)
                
                self.timeZoneData.append(contentsOf:constantListData.listTimeZoneInfo!)
                
            }catch {
                Helper.traceCrach(error: error, userToken: "")
            }
        }
    }
    
    func getDateFormateData(){
        if let data = UserDefaults.standard.data(forKey: Constants().CONSTANT_LIST_DATA) {
            do {
                let decoder = JSONDecoder()
                let constantListData = try decoder.decode(ConstantsListsData.self, from: data)
                
                self.dateFormate.append(contentsOf:constantListData.listDateFormatType!)
                
            }catch {
                Helper.traceCrach(error: error, userToken: "")
            }
        }
    }
    func getTimeFormateData(){
        if let data = UserDefaults.standard.data(forKey: Constants().CONSTANT_LIST_DATA) {
            do {
                let decoder = JSONDecoder()
                let constantListData = try decoder.decode(ConstantsListsData.self, from: data)
                
                self.timeFormate.append(contentsOf:constantListData.listTimeFormatType!)
                
            }catch {
                Helper.traceCrach(error: error, userToken: "")
            }
        }
    }
    
    private func clearStatesWithAction(valueState: inout Bool) {
        valueState.toggle()
        showRegFromSetting = false
        showMoreFromSettings = false
    }
}
