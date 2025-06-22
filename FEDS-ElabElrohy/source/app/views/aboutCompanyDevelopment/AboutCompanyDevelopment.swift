//
//  AboutCompanyDevelopment.swift
//  FEDS-Center-Dev-IOS
//
//  Created by Omar Pakr on 27/03/2024.
//


import SwiftUI

@available(iOS 16.0, *)
struct AboutCompanyDevelopment: View {
    @StateObject var genralVm : GeneralVm = GeneralVm()

    @State private var toast: Toast? = nil
    @State private var backFromAboutCompanyDev : Bool = false
    
    var body: some View {
        
        VStack {
            
            ZStack(alignment: .top) {
                Rectangle()
                    .fill(genralVm.isDark ? Color(Colors().darkCardBg): Color(Colors().lightCardBg))
                    .frame(height: 200) // Adjust height as needed
                    .edgesIgnoringSafeArea(.top)
                    .cornerRadius(40, corners: [.allCorners])
                
                
                Text(NSLocalizedString("contactWithUs", comment: ""))
                    .font(
                        Font.custom(Fonts().getFontBold(), size: 30).weight(.bold))
                    .foregroundColor(genralVm.isDark ? Color(Colors().darkBodyText): Color(Colors().lightBodyText))
                    .padding(.top, 70)
                
                VStack {
                    CircleImage(logo: Constants().COMPANY_DEV_LOGO
                                , width: 100
                                , height: 100
                                , bgColor: genralVm.isDark ? Color(Colors().darkBodyBg): Color(Colors().lightBodyBg)
                                , offestY: 60)
                }
                .frame(height: 250) // Adjust this height so the image is half in and out of the purple area
            }
            
            ScrollView{
                VStack (spacing:20){
                    Spacer()
                    
                    Text(NSLocalizedString("companyDevName", comment: ""))
                        .font(
                            Font.custom(Fonts().getFontBold(), size: 28).weight(.bold))
                    
                  
                    
                    Text(NSLocalizedString("companyDevDescription", comment: ""))
                        .multilineTextAlignment(.leading)
                        .padding(.horizontal) // Only horizontal padding, vertical spacing is managed by Spacers
                        .font(
                            Font.custom(Fonts().getFontLight(), size: 22).weight(.bold))
                        .lineSpacing(4)
                    
                    VStack (spacing : 20){
                        
                        HStack (spacing:30){
                            
                            
                            Image("phone-call")
                                .resizable()
                                .frame(width: 50,height: 50)
                                .onTapGesture {
                                    let validPhoneCall = Validation.IsValidContent(text: CompanyDevConstants().CLIENT_PHONE_1, length: 6)
                             
                                    if validPhoneCall {
                                        Helper.makePhoneCall(phoneNumber: CompanyDevConstants().CLIENT_PHONE_1)
                                    }else{
                                        toast = Helper.showToast(style: .error, message: NSLocalizedString("meesage_error_there_is_no_link", comment: ""))
                                    }
                                  }
                            
                            Image("whatsapp")
                                .resizable()
                                .frame(width: 50,height: 50)
                                .onTapGesture {
                                    let validWhatsapp = Validation.IsValidContent(text: CompanyDevConstants().CLIENT_WHATSAPP_1)
                                
                                    if validWhatsapp {
                                        UIApplication.tryURL(urlString: CompanyDevConstants().CLIENT_WHATSAPP_1)
                                    }else{
                                        toast = Helper.showToast(style: .error, message: NSLocalizedString("meesage_error_there_is_no_link", comment: ""))
                                    }
                                    
                                    
                                }
                            
                            Image("email")
                                .resizable()
                                .frame(width: 50,height: 50)
                                .onTapGesture {
                                    let validWhatsapp = Validation.IsValidContent(text: CompanyDevConstants().CLIENT_EMAIL_1)
                                
                                    if validWhatsapp {
                                        UIApplication.tryURL(urlString: CompanyDevConstants().CLIENT_EMAIL_1)
                                    }else{
                                        toast = Helper.showToast(style: .error, message: NSLocalizedString("meesage_error_there_is_no_link", comment: ""))
                                    }
                                }
                            
                            Image("telegram")
                                .resizable()
                                .frame(width: 50,height: 50)
                                .onTapGesture {
                                    let validWhatsapp = Validation.IsValidContent(text: CompanyDevConstants().CLIENT_TELEGRAM_1)
                                
                                    if validWhatsapp {
                                        UIApplication.tryURL(urlString: CompanyDevConstants().CLIENT_TELEGRAM_1)
                                    }else{
                                        toast = Helper.showToast(style: .error, message: NSLocalizedString("meesage_error_there_is_no_link", comment: ""))
                                    }
                                }
                            
                            
                           
                        }
                        
                        HStack (spacing:30){
                          
                            
                            Image("snapchat")
                                .resizable()
                                .frame(width: 50,height: 50)
                                .onTapGesture {
                                    let validWhatsapp = Validation.IsValidContent(text: CompanyDevConstants().CLIENT_SNAP_CHAT_1)
                                
                                    if validWhatsapp {
                                        UIApplication.tryURL(urlString: CompanyDevConstants().CLIENT_SNAP_CHAT_1)
                                    }else{
                                        toast = Helper.showToast(style: .error, message: NSLocalizedString("meesage_error_there_is_no_link", comment: ""))
                                    }
                                }
                            
                            Image("twitter")
                                .resizable()
                                .frame(width: 50,height: 50)
                                .onTapGesture {
                                    let validWhatsapp = Validation.IsValidContent(text: CompanyDevConstants().CLIENT_TWITTER_1)
                                
                                    if validWhatsapp {
                                        UIApplication.tryURL(urlString: CompanyDevConstants().CLIENT_TWITTER_1)
                                    }else{
                                        toast = Helper.showToast(style: .error, message: NSLocalizedString("meesage_error_there_is_no_link", comment: ""))
                                    }
                                }
                            
                            Image("facebook")
                                .resizable()
                                .frame(width: 50,height: 50)
                                .onTapGesture {
                                    let validWhatsapp = Validation.IsValidContent(text: CompanyDevConstants().CLIENT_FACEBOOK_1)
                                
                                    if validWhatsapp {
                                        UIApplication.tryURL(urlString: CompanyDevConstants().CLIENT_FACEBOOK_1)
                                    }else{
                                        toast = Helper.showToast(style: .error, message: NSLocalizedString("meesage_error_there_is_no_link", comment: ""))
                                    }
                                }
                            
                            Image("instagram")
                                .resizable()
                                .frame(width: 50,height: 50)
                                .onTapGesture {
                                    let validWhatsapp = Validation.IsValidContent(text: CompanyDevConstants().CLIENT_INSTAGRAM_1)
                                
                                    if validWhatsapp {
                                        UIApplication.tryURL(urlString: CompanyDevConstants().CLIENT_INSTAGRAM_1)
                                    }else{
                                        toast = Helper.showToast(style: .error, message: NSLocalizedString("meesage_error_there_is_no_link", comment: ""))
                                    }
                                }
                        }
                        
                        HStack (spacing:30){
                            Image("google-maps")
                                .resizable()
                                .frame(width: 50,height: 50)
                                .onTapGesture {
                                    let validWhatsapp = Validation.IsValidContent(text: CompanyDevConstants().CLIENT_MAP_LINK)
                                
                                    if validWhatsapp {
                                        UIApplication.tryURL(urlString: CompanyDevConstants().CLIENT_MAP_LINK)
                                    }else{
                                        toast = Helper.showToast(style: .error, message: NSLocalizedString("meesage_error_there_is_no_link", comment: ""))
                                    }
                                }
                            
                            Image("youtube")
                                .resizable()
                                .frame(width: 50,height: 50)
                                .onTapGesture {
                                    let validWhatsapp = Validation.IsValidContent(text: CompanyDevConstants().CLIENT_YOUTUBE_1)
                                
                                    if validWhatsapp {
                                        UIApplication.tryURL(urlString: CompanyDevConstants().CLIENT_YOUTUBE_1)
                                    }else{
                                        toast = Helper.showToast(style: .error, message: NSLocalizedString("meesage_error_there_is_no_link", comment: ""))
                                    }
                                }
                            
                            Image("tiktok")
                                .resizable()
                                .frame(width: 50,height: 50)
                                .onTapGesture {
                                    let validWhatsapp = Validation.IsValidContent(text: CompanyDevConstants().CLIENT_TIKTOK_1)
                                
                                    if validWhatsapp {
                                        UIApplication.tryURL(urlString: CompanyDevConstants().CLIENT_TIKTOK_1)
                                    }else{
                                        toast = Helper.showToast(style: .error, message: NSLocalizedString("meesage_error_there_is_no_link", comment: ""))
                                    }
                                }
                        }
                    }
                }
                .padding(.top,-30)
                
                Spacer()
            }
            
        }
        .background(genralVm.isDark ? Color(Colors().darkBodyBg): Color(Colors().lightBodyBg))
        .ipad()
        .edgesIgnoringSafeArea(.all)
        .gesture(
            DragGesture()
                .onEnded { value in
                    // Check if the drag was towards the left
                    if value.translation.width < 0 {
                        clearStatesWithAction(valueState: &backFromAboutCompanyDev)
                    }else if value.translation.width > 0 {
                        clearStatesWithAction(valueState: &backFromAboutCompanyDev)
                    }
                }
        )
        .toastView(toast: $toast)
        .fullScreenCover(isPresented: $backFromAboutCompanyDev, content: {
            StudentMainTabView()
        })
        .onDisappear {
            clearStatesWithAction(valueState: &genralVm.dissapearView)
        }
    }
    private func clearStatesWithAction(valueState: inout Bool) {
        valueState.toggle()
        backFromAboutCompanyDev = false
    }
}




