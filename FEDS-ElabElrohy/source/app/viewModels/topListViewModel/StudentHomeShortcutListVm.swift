//
//  TopListViewModel.swift
//  FPLS-Dev
//
//  Created by Omar pakr on 04/09/2023.
//

import Foundation
class StudentHomeShortcutListVm : ObservableObject{
    @Published var shortcutList : [ShortcutModel] = []
    @Published var isLoading : Bool = false
    let havePermissionToView  = UserDefaultss().restoreBool(key: "havePermissionToView")
    let userTypeToken  = UserDefaultss().restoreString(key: "userTypeToken")
    var constants = Constants()
    
    init(){
        fetchShortcutList()
    }
    
    func fetchShortcutList(){
        let JoiningApps = ShortcutModel(name: NSLocalizedString("joiningApps", comment: ""), image: "request_tab_bar",route: "joiningApplication")
        let attendnace = ShortcutModel(name: NSLocalizedString("attendance", comment: ""), image: "attendance",route: "attendanceHistory")
        let debts = ShortcutModel(name: NSLocalizedString("payments", comment: ""), image: "subscription",route: "debtsHistory")
        let groups = ShortcutModel(name: NSLocalizedString("myGroups", comment: ""), image: "groups",route: "myGroups")
        let exams = ShortcutModel(name: NSLocalizedString("exams", comment: ""), image: "exams",route: "myExams")
        let myCourses = ShortcutModel(name: NSLocalizedString("myCourses", comment: ""), image: "courses",route: "myCourses")
        let myCodes = ShortcutModel(name: NSLocalizedString("myCode", comment: ""), image: "teacher_code",route: "codes")
        let myMedia = ShortcutModel(name: NSLocalizedString("myMedia", comment: ""), image: "allMedia",route: "myMedia")
        let myHw = ShortcutModel(name: NSLocalizedString("myHw", comment: ""), image: "exams",route: "myHw")
        
        isLoading = true
        DispatchQueue.main.asyncAfter(deadline: .now()){
            
            self.shortcutList.append(groups)
            self.shortcutList.append(myMedia)
            
            if ((self.havePermissionToView && self.userTypeToken == self.constants.USER_TYPE_TOKEN_STUDENT )
                || self.userTypeToken == self.constants.USER_TYPE_TOKEN_FAMILY) {
                self.shortcutList.append(myCourses)
                self.shortcutList.append(exams)
                self.shortcutList.append(myHw)
                self.shortcutList.append(myCodes)
            }
            self.shortcutList.append(attendnace)
            self.isLoading = false
        }
    }
    
}
