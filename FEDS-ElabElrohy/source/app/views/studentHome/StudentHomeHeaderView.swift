//
//  HeaderView.swift
//  FPLS-Dev
//
//  Created by Omar pakr on 04/09/2023.
//

import SwiftUI

@available(iOS 16.0, *)
struct StudentHomeHeaderView: View {
    @StateObject var notificationVm : NotificationVm = NotificationVm()
    @StateObject var genralVm : GeneralVm = GeneralVm()

    var name : String
    var imageUrl : String
    @State private var showNews : Bool = false
    @State private var showProfileInfoFromHome : Bool = false
    @State private var notificationCount : Int = 0
    @State private var showNotifications : Bool = false
        
    var body: some View {
        VStack{
            HStack{
                
                CustomImageUrl(url: self.imageUrl, width: 40, height: 40) {
                    showProfileInfoFromHome.toggle()
                }
                VStack{
                    Text(name)
                      .font(
                        Font.custom(Fonts().getFontBold(), size: 16)
                          .weight(.light)
                      )
                      .foregroundColor(genralVm.isDark ? Color(Colors().darkBodyText): Color(Colors().lightBodyText))
                 

                }
                .onTapGesture {
                    clearStatesWithAction(valueState: &showProfileInfoFromHome)
                }
                Spacer()
                
                HStack(spacing: 20){
                    ZStack {
            
                         Image("news 1")
                             .resizable()
                             .foregroundColor(.white)
                             .aspectRatio(1.0, contentMode: .fit)
                             .frame(width: 40, height: 40)
                         
                 
                     }
                    .onTapGesture {
                        clearStatesWithAction(valueState: &showNews)
                    }
                    
                    
                           Image("notification")
                               .resizable()
                               .aspectRatio(1.0, contentMode: .fit)
                                  .overlay(
                                  Circle()
                                    .fill(notificationVm.notificationCount != 0 ? Color.red : Color.clear)
                                      .frame(width: 20,height: 20)
                                      .overlay(
                                        Text(notificationVm.notificationCount != 0 ? "\(notificationVm.notificationCount)" : "")
                                            .font(
                                              Font.custom(Fonts().getFontBold(), size: 10)
                                                .weight(.light)
                                            )
                                          .foregroundColor(.white)
                                      )
                                  ,alignment: .topTrailing
                                  )
                               
                               .frame(width: 40, height: 40)
                               
                               .onTapGesture {
                                   clearStatesWithAction(valueState: &showNotifications)
                               }
                }
                .onAppear {
                    notificationVm.getCountNotification()
                }
            }
            .padding()
        }
        .fullScreenCover(isPresented: $showProfileInfoFromHome, content: {
            ProfileView()
        })
        .fullScreenCover(isPresented: $showNews, content: {
            NewsView()
        })
        .fullScreenCover(isPresented: $showNotifications, content: {
            NotificationsView()
        })
        .onDisappear(perform: {
            clearStatesWithAction(valueState: &genralVm.dissapearView)
        })
    }
    
    private func clearStatesWithAction(valueState: inout Bool) {
        valueState.toggle()
       showNotifications = false
       showNews = false
       showProfileInfoFromHome = false
      }
}
