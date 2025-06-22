//
//  MoreViewModel.swift
//  FEDS-Center-Dev-IOS
//
//  Created by Mrwan on 28/05/2024.
//

import Foundation

class MoreViewModel : ObservableObject {
    @Published var showAzDialogActions = false
    @Published var showRegFromMore = false
    @Published var showFamliyFromMore : Bool = false
    @Published var showMarketFromMore : Bool = false
    @Published var showEvaluationsFromMore : Bool = false
    @Published var showCertificatsFromMore : Bool = false
    @Published var showUserCodeFromMore : Bool = false
    @Published var showTeacherCodeFromMore : Bool = false
    @Published var showContactUsFromMore : Bool = false
    @Published var showAppSettingsFromMore : Bool = false
    @Published var showWalletFromMore : Bool = false
    @Published var showingAlertFromMore = false
    @Published var showingAlertLogoutFromMore = false
    @Published var showMyAccountInfoFromMore = false
    @Published var showStudentMainFromDec :Bool = false
    @Published var showFamilyFromDec :Bool = false
    @Published var showAboutCompanyDevFromMore :Bool = false
    @Published var showOnlineReservationFromMore :Bool = false
    @Published var showBetaEduFromMore :Bool = false
    @Published var toast: Toast? = nil
    @Published var versionNumber :String = ""
    @Published var constantListData : ConstantsListsDataa = ConstantsListsDataa()
    @Published var genralVm : GeneralVm = GeneralVm()

    init(){
        getConstantList()
    }
    
    func clearStatesWithAction(valueState: inout Bool) {
       valueState.toggle()
       showRegFromMore = false
       showUserCodeFromMore = false
       showContactUsFromMore = false
       showFamliyFromMore = false
       showAppSettingsFromMore = false
       showAboutCompanyDevFromMore = false
       showWalletFromMore = false
       showOnlineReservationFromMore = false
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
