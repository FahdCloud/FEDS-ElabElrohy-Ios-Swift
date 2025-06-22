//
//  FilterVieModel.swift
//  FPLS-Dev
//
//  Created by Omar pakr on 12/10/2023.
//

import Foundation


class FilterVieModel : ObservableObject{
    @Published var filterData : [FilterModel] = []
    @Published var isLoading : Bool = false
    @Published var isSelectedIndex : String?
    @Published var selectedItem :String?
    let joiningApplicationVm : JoiningApplicationVm = JoiningApplicationVm()
    
    
    init(){
        self.fetchTopListData()
        
    }
   
    
    func fetchTopListData(){
        let filterView1 = FilterModel(name: NSLocalizedString("inReview", comment: ""), image: "info_icon",token: Constants().APPROVAL_TYPE_TOKEN_IN_REVIEW,count: joiningApplicationVm.underReviewCount)
        let filterView2 = FilterModel(name: NSLocalizedString("accepted", comment: ""), image: "accepted_icon",token: Constants().APPROVAL_TYPE_TOKEN_APPROVED,count: joiningApplicationVm.approvedCount)
        let filterView3 = FilterModel(name: NSLocalizedString("rejected", comment: ""), image: "rejected_icon",token: Constants().APPROVAL_TYPE_TOKEN_REJECTED,count: joiningApplicationVm.rejectedCount)
        let filterView4 = FilterModel(name: NSLocalizedString("all", comment: ""), image: "all_icon",token: "",count: joiningApplicationVm.totalCount)
        
        isLoading = true
        DispatchQueue.main.asyncAfter(deadline: .now()){
//            self.filterData.append(filterView4)
            self.filterData.append(filterView1)
            self.filterData.append(filterView2)
            self.filterData.append(filterView3)
           
            self.isLoading = false
        }
    }
    
    
    func selectItem(token : String) {
        selectedItem = token
//        self.joiningApplicationVm.getEducationJoiningApplication(approvalToken: selectedItem)
    }

}
