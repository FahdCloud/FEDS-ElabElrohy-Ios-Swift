//
//  ApiHelper.swift
//  FPLS-Dev
//
//  Created by Omar pakr on 05/09/2023.
//

import Foundation


class apiHelper{
    
    static func getGenralDataSearch(generalSearch : GeneralSearch)  -> [String :Any] {
        let params : [String : Any ] = [
                                        "paginationStatus":  generalSearch.paginationStatus ?? "true",
                                        "page": generalSearch.page ?? 1,
                                        "pageSize": generalSearch.pageSize ?? Constants().PAGE_SIZE,
                                        "filterStatus": generalSearch.filterStatus ?? "",
                                        "activationTypeTokens": generalSearch.activationTypeTokens ?? "",
                                        "textSearch": generalSearch.textSearch ?? "",
                                        "archiveStatus": generalSearch.archiveStatus ?? "",
                                        "userTypeToken": generalSearch.userTypeToken ?? "",
                                        "userStudentToken": generalSearch.userStudentToken ?? "",
                                        "calendarYear": generalSearch.calendarYear ?? "",
                                        "calendarDay": generalSearch.calendarDay ?? "",
                                        "calendarMonth": generalSearch.calendarMonth ?? "",
                                        "calendarSearchType": generalSearch.calendarSearchType ?? "",
                                        "educationalCategoryToken": generalSearch.educationalCategoryToken ?? "",
                                        "userEducationalInterestToken" : generalSearch.userEducationalInterestToken ?? "",
                                        "approvalTypeToken" : generalSearch.approvalTypeToken ?? "",
                                        "educationalCategoryInfoDataInclude" : generalSearch.educationalCategoryInfoDataInclude ?? "",
                                        "userServiceProviderInfoDataInclude" : generalSearch.userServiceProviderInfoDataInclude ?? "",
                                        "educationalGroupScheduleTimeInfoDataInclude" : generalSearch.educationalGroupScheduleTimeInfoDataInclude ?? "",
                                        "userToken" : generalSearch.userToken ?? "",
                                        "debtToken" : generalSearch.debtToken ?? "",
                                        "ownedUserInfoDataInclude" : generalSearch.ownedUserInfoDataInclude ?? "",
                                        "educationalJoiningApplicationInfoDataInclude" : generalSearch.educationalJoiningApplicationInfoDataInclude ?? "",
                                        "educationalGroupFinishTypeToken" : generalSearch.educationalGroupFinishTypeToken ?? "",
                                        "educationalGroupStatisticsInfoDataInclude" : generalSearch.educationalGroupStatisticsInfoDataInclude ?? "",
                                        "educationalGroupScheduleTimeToken" : generalSearch.educationalGroupScheduleTimeToken ?? "",
                                        "educationalGroupInfoDataInclude" : generalSearch.educationalGroupInfoDataInclude ?? "",
                                        "dateTimeStartSearch" : generalSearch.dateTimeStartSearch ?? "",
                                        "dateTimeEndSearch" : generalSearch.dateTimeEndSearch ?? "",
                                        "schedulingStatusTypeToken" : generalSearch.schedulingStatusTypeToken ?? "",
                                        "userServiceProviderToken" : generalSearch.userServiceProviderToken ?? "",
                                        "priceListDataInclude" : generalSearch.priceListDataInclude ?? "",
                                        "userStudentInfoDataInclude" : generalSearch.userStudentInfoDataInclude ?? "",
                                        "educationalGroupToken" : generalSearch.educationalGroupToken ?? "",
                                        "educationalCourseStudentToken" : generalSearch.educationalCourseStudentToken ?? "",
                                        "cancelTypeToken" : generalSearch.cancelTypeToken ?? "",
                                        "getOnlyParentEducationalCategories" : generalSearch.getOnlyParentEducationalCategories ?? "",
                                        "parentEducationalCategoryToken" : generalSearch.parentEducationalCategoryToken ?? "",
                                        "getOnlyChildEducationalCategories" : generalSearch.getOnlyChildEducationalCategories ?? "",
                                        "ownedUserToken" : generalSearch.ownedUserToken ?? "",
                                        "saleStatusTypeToken" : generalSearch.saleStatusTypeToken ?? "",
                                        "moduleExamTypeToken" : generalSearch.moduleExamTypeToken ?? "",
                                        "examSearchStatusTypeToken" : generalSearch.examSearchStatusTypeToken ?? "",
                                        "isAcademicYear" : generalSearch.isAcademicYear ?? "",
                                        "getOnlyParentPlaces" : generalSearch.getOnlyParentPlaces ?? ""
                                        
                                     
                                        
        ]
        return params
    }
    
    static func getMediaDataSearch(generalSearch : GeneralSearch)  -> [String :Any] {
        let params : [String : Any ] = [
                                        "paginationStatus":  generalSearch.paginationStatus ?? "true",
                                        "page": generalSearch.page ?? 1,
                                        "pageSize": generalSearch.pageSize ?? Constants().PAGE_SIZE,
                                        "filterStatus": generalSearch.filterStatus ?? "",
                                        "activationTypeTokens": generalSearch.activationTypeTokens ?? "",
                                        "textSearch": generalSearch.textSearch ?? "",
                                        "userStudentToken": generalSearch.userStudentToken ?? "",
                                        "educationalGroupScheduleTimeToken" : generalSearch.educationalGroupScheduleTimeToken ?? ""
        ]
        return params
    }
    static func getMyCourses(generalSearch : GeneralSearch)  -> [String :Any] {
        let params : [String : Any ] = [
                                        "paginationStatus":  generalSearch.paginationStatus ?? "true",
                                        "page": generalSearch.page ?? 1,
                                        "pageSize": generalSearch.pageSize ?? Constants().PAGE_SIZE,
                                        "filterStatus": generalSearch.filterStatus ?? "",
                                        "activationTypeTokens": generalSearch.activationTypeTokens ?? "",
                                        "textSearch": generalSearch.textSearch ?? "",
                                        "userStudentToken": generalSearch.userStudentToken ?? "",
                                        "userServiceProviderToken": generalSearch.userServiceProviderToken ?? "" ,
                                        "educationalCategoryToken": generalSearch.educationalCategoryToken ?? ""
                                      
        ]
        return params
    }
}

