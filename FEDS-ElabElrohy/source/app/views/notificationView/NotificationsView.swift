//
//  NotificationView.swift
//  FPLS-Dev
//
//  Created by Omar pakr on 27/11/2023.
//


import SwiftUI

@available(iOS 16.0, *)
struct NotificationsView: View {
    @StateObject var notificationVm : NotificationVm = NotificationVm()
    @StateObject var genralVm : GeneralVm = GeneralVm()

    @State private var showStudentMainFromNotification : Bool = false
    @State private var showNewsFromNotification : Bool = false
    @State private var showNotificationDetails : Bool = false
    
    
    var body: some View {
        NavigationView {
            VStack{
                if notificationVm.noData {
                    NoContent(message: notificationVm.msg)
                }
                else {
                    List {
                        ForEach(notificationVm.notificationData, id: \.notificationToken) { notification in
                            
                            VStack(spacing : 5){
                                HStack (spacing : 10){
                                CustomImageUrl(defaultImage : "notification" ,
                                                url: notification.userCreatedData?.userThumbnailImageUrl ?? "", width: 40,height: 40)
                                
                                
                                VStack {
                                    Text(notification.titleCurrent ?? "")
                                    
                                        .font(
                                            Font.custom(Fonts().getFontBold(), size: 22)
                                                .weight(.bold)
                                        )
                                        .foregroundColor( genralVm.isDark ? Color(Colors().darkCardText) : Color(Colors().lightCardText))
                                        .lineLimit(4)
                                        .multilineTextAlignment(.center)
                                    
                                    Text(notification.bodyCurrent ?? "")
                                    
                                        .font(
                                            Font.custom(Fonts().getFontLight(), size: 20)
                                                .weight(.bold)
                                        )
                                        .foregroundColor( genralVm.isDark ? Color(Colors().darkCardText) : Color(Colors().lightCardText))
                                        .lineLimit(20)
                                        .multilineTextAlignment(.center)
                                }
                                
                                
                                if showNotificationDetails {
                                    HtmlView(text: notification.bodyCurrent ?? "")
                                }
                            }
                         
                            .frame(maxWidth: .infinity, alignment: .leading)

                                
                            Text(notification.dateTimeAgo ?? "")
                                    .font(
                                        Font.custom(Fonts().getFontLight(), size: 18)
                                            .weight(.bold)
                                    )
                                    .foregroundColor((notification.statusRead ?? false) ? .gray : genralVm.isDark ? Color(Colors().darkCardText) : Color(Colors().lightCardText))
                                    .lineLimit(2)
                                    .multilineTextAlignment(.trailing)
                                    .frame(maxWidth: .infinity, alignment: .trailing)

                            }
                            .padding(.vertical, 5)
                            .padding(.horizontal, 10)
                           .background((notification.statusRead ?? false) ? .clear : genralVm.isDark ? Color(Colors().darkCardBg) : Color(Colors().lightCardBg))
                            .cornerRadius(3)
                            .onTapGesture {
                                notificationVm.readNotification(notificationToken: notification.notificationToken ?? "")
                                if notification.pageGoToToken == self.genralVm.constants.PAGE_TOKEN_NEWS {
                                    clearStatesWithAction(valueState: &showNewsFromNotification)
                                } else if notification.pageGoToToken == self.genralVm.constants.PAGE_TOKEN_SCHEDULE_TIMES {
                                    clearStatesWithAction(valueState: &showStudentMainFromNotification)
                                }
                            }
                        }
                        
                        if notificationVm.currentPage < notificationVm.totalPages {
                            Text(NSLocalizedString("fetchMoreData", comment: ""))
                                .onAppear {
                                    notificationVm.currentPage += 1
                                    notificationVm.getNotifications()
                                }
                            
                        }
                        
                    }
                    
                    .listStyle(.plain)
                    .background(genralVm.isDark ? Color(Colors().darkBodyBg): Color(Colors().lightBodyBg))
                    
                }
                
            }
            .background(genralVm.isDark ? Color(Colors().darkBodyBg): Color(Colors().lightBodyBg))
            .overlay(
                notificationVm.isLoading ?
                GeometryReader { geometry in
                    ZStack {
                        LoadingView(placHolder: NSLocalizedString("loading", comment: ""))
                            .frame(width: geometry.size.width, height: geometry.size.height)
                            .transition(.scale)
                    } } : nil
            )
            .fullScreenCover(isPresented: $notificationVm.showLogOut, content: {
                RegistrationView()
            })
            .fullScreenCover(isPresented: $showNewsFromNotification, content: {
                NewsView()
            })
            .fullScreenCover(isPresented: $showStudentMainFromNotification, content: {
                StudentMainTabView()
            })
            .navigationBarItems(leading: CustomBackButton(){
                self.showStudentMainFromNotification.toggle()
            }
            )
            
            .navigationBarItems(trailing:Button(NSLocalizedString("markALlRead", comment: "")) {
                notificationVm.markAllAsRead()
            }
            )
            .navigationTitle(NSLocalizedString("notifications", comment: ""))
            .onAppear {
                
                notificationVm.getNotifications()
            }
            .onDisappear {
                clearStatesWithAction(valueState: &genralVm.dissapearView)
               
            }
        }
        .background(genralVm.isDark ? Color(Colors().darkBodyBg): Color(Colors().lightBodyBg))
    }
    
    private func clearStatesWithAction(valueState: inout Bool) {
        valueState.toggle()
        showNewsFromNotification = false
        showStudentMainFromNotification = false
    }
}

