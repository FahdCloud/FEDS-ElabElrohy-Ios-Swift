//
//  HomePageVm.swift
//  FEDS-Center-Dev
//
//  Created by Omar pakr on 19/12/2023.
//


import Foundation
class HomePageVm : ObservableObject{
    @Published var homePageList : [HomePageModel] = []
    @Published var isLoading : Bool = false
    @Published var showLogOut : Bool = false
    
    init(){
        fetchTopListData()
    }
    
    func fetchTopListData(){
        let subjects = HomePageModel(name: NSLocalizedString("lectures", comment: ""), image: "card_home_materials",route: "subjects")
        let teachers = HomePageModel(name: NSLocalizedString("teachers", comment: ""), image: "card_home_lectures",route: "teachersCodes")
        let groups = HomePageModel(name: NSLocalizedString("groupss", comment: ""), image: "card_home_groups",route: "groups")
        let schudelTime = HomePageModel(name: NSLocalizedString("schudelTime", comment: ""), image: "card_home_schedule",route: "schudelTime")
        let exams = HomePageModel(name: NSLocalizedString("exams", comment: ""), image: "attendance",route: "exams")
        let codes = HomePageModel(name: NSLocalizedString("codes", comment: ""), image: "attendance",route: "teachersCodes")
        
        isLoading = true
        DispatchQueue.main.asyncAfter(deadline: .now()){ [self] in

            self.homePageList.append(subjects)
            if AppConstantStatus.isAppNotForLecture {
                self.homePageList.append(teachers)
            }
            self.homePageList.append(groups)
            self.homePageList.append(schudelTime)
//            self.homePageList.append(exams)
//            self.homePageList.append(codes)

            self.isLoading = false
        }
    }
}
