//
//  NotificationVm.swift
//  FPLS-Dev
//
//  Created by Omar pakr on 27/11/2023.
//

import Foundation


class NotificationVm : ObservableObject {
    @Published var notificationData : [NotificationsDatum] = []
    @Published var genralVm : GeneralVm = GeneralVm()

    @Published var isLoading : Bool = false
    @Published var noData : Bool = false
    @Published var showLogOut : Bool = false
    @Published var showPage : Bool = false
    @Published var isRead : Bool = false
    @Published var refresh : Bool = false
    @Published var msg : String = ""
    @Published var notificationCount : Int = 0
    
    
    var authToken = UserDefaultss().restoreString(key: "userAuth")
    var userToken = UserDefaultss().restoreString(key: "userToken")
    var totalPages = 1
    var currentPage = 1
    
    func getNotifications(){
       
        self.isLoading = true
        
        do {
            let data = try JSONEncoder().encode(GeneralSearch())
            UserDefaults.standard.set(data, forKey: "apiData")
            do {
                
                let decoder = JSONDecoder()
                let data = try decoder.decode(GeneralSearch.self, from: data)
                data.userAuthorizeToken = self.authToken
                data.paginationStatus = "true"
                data.pageSize = self.genralVm.constants.PAGE_SIZE
                data.page = currentPage
                data.activationTypeTokens = "AST-17400"
                data.filterStatus = "true"
              
                        
                do {
                    try Api().notification(generalSearch:data ,onCompletion: { status, msg, data,pagination in
              
                        if status == self.genralVm.constants.STATUS_SUCCESS {
                            self.isLoading = false
                            self.noData = false
                            self.totalPages = pagination.totalPages ?? 1
                            self.notificationData = []
                            self.notificationData.append(contentsOf: data)
                            
                        }else if status == self.genralVm.constants.STATUS_INVALID_TOKEN ||
                                        status == self.genralVm.constants.STATUS_VERSION {
                              
                            self.isLoading = false
                            self.showLogOut = true
                            self.msg = msg
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
                self.isLoading = false
                self.msg = error.localizedDescription
            }
        } catch {
            self.isLoading = false
            self.msg = error.localizedDescription
        }
    }
    
    func getCountNotification (){
        do {
            try Api().getCountNotification(authToken: self.authToken) { (status, msg, count) in
       
              if status == self.genralVm.constants.STATUS_SUCCESS {
                  self.notificationCount = count
              } else {
                  self.notificationCount = 0
                }
              }
          } catch {
              self.notificationCount = 0
              Helper.traceCrach(error: error, userToken: "USE-0")
           }
    }
    
    func readNotification(notificationToken : String) {
        isLoading = true
        do {

            let data = try JSONEncoder().encode(ReadNotification())
            UserDefaults.standard.set(data, forKey: "readotification")
            do {
               
                let decoder = JSONDecoder()
                var readNotifi = try decoder.decode(ReadNotification.self, from: data)
                readNotifi.language = Language.getLanguageISO()
                readNotifi.statusRead = "true"
                readNotifi.token = notificationToken
                readNotifi.userAuthorizeToken = self.genralVm.authToken

                  do {

                    try Api().readNotification(statusEncoding: true, data: readNotifi) { (status, msg ) in

                        if status == self.genralVm.constants.STATUS_SUCCESS {
                            self.isLoading = false
                            self.showPage = true
                          }
                        }
                    } catch {
                        self.isLoading = false

                        Helper.traceCrach(error: error, userToken: "USE-0")
                     }

            }
                catch {
                    self.isLoading = false
                    Helper.traceCrach(error: error, userToken: "USE-0")

                }
        } catch {
            self.isLoading = false

        }

    }
    
    func markAllAsRead(){
        isLoading = true
        do {

            let data = try JSONEncoder().encode(ReadNotification())
            UserDefaults.standard.set(data, forKey: "readotification")
            do {
               
                let decoder = JSONDecoder()
                var readNotifi = try decoder.decode(ReadNotification.self, from: data)
                readNotifi.language = Language.getLanguageISO()
                readNotifi.statusRead = "true"
                readNotifi.userAuthorizeToken = self.genralVm.authToken

                  do {

                    try Api().readAllNotification(statusEncoding: true, data: readNotifi) { (status, msg ) in

                        if status == self.genralVm.constants.STATUS_SUCCESS {
                            self.isLoading = false
                            self.msg = msg
                            self.getNotifications()
                      
                        } else {
                            self.isLoading = false
                            self.refresh = false
                            self.msg = msg
                            
                        }
                        }
                    } catch {
                        self.isLoading = false
                        self.refresh = true
                        Helper.traceCrach(error: error, userToken: "USE-0")
                     }

            }
                catch {
                    self.isLoading = false
                    Helper.traceCrach(error: error, userToken: "USE-0")

                }
        } catch {
            self.isLoading = false

        }
    }
}
