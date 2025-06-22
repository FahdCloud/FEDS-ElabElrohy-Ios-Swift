//
//  ConstantlistModel.swift
//  FEDS-Dev-1.1
//
//  Created by Mrwan on 25/08/2024.
//

import Foundation


// MARK: - ConstantListModel
struct ConstantListModel :Codable{
    var status: Int?
    var msg: String?
    var executionTimeMilliseconds: Int?
    var constantsListsData: ConstantsListsDataa?
}

// MARK: - ConstantsListsData
struct ConstantsListsDataa :Codable{
    var listDaysOfWeekData: [ListData]?
    var listActivationType: [ListData]?
    var listUserType: [ListData]?
    var listUserCompositeType: [ListData]?
    var listGender: [ListData]?
    var listReligionType: [ListData]?
    var listRelativeRelationType: [ListRelativeRelationType]?
    var listPlatFormType: [ListData]?
    var listMediaType: [ListData]?
    var listThemeType: [ListData]?
    var listLanguageType: [ListData]?
    var listDateFormatType: [ListData]?
    var listTimeFormatType: [ListData]?
    var listTimeZoneInfo: [ListData]?
    var listCodeInLoginType: [ListData]?
    var listAuthenticationLoginType: [ListData]?
    var listNumberOfPeriodType: [ListData]?
    var listGovernorateType: [ListData]?
    var listAccountType: [ListData]?
    var listPaymentMethod: [ListData]?
    var listNatureFinanceType: [ListData]?
    var listWalletTransactionType: [ListData]?
    var listAccountTransactionType: [ListData]?
    var listFullAccountTransactionType: [ListData]?
    var listRefundType: [ListData]?
    var listCancelType: [ListData]?
    var listDebtType: [ListData]?
    var listSchedulingStatusType: [ListData]?
    var listInterestStateType: [ListData]?
    var listServiceType: [ListData]?
    var listModuleNameType: [ListData]?
    var listServerStorageType: [ListData]?
    var listReviewType: [ListData]?
    var listEducationSystemType: [ListData]?
    var listUserTeacherType: [ListData]?
    var listApprovalType: [ListData]?
    var listApplicationItemStateType: [ListData]?
    var listRelatedWithGroupType: [ListData]?
    var listQuestionType: [ListData]?
    var listClosedType: [ListData]?
    var listFinishType: [ListData]?
    var listAppointmentType: [ListData]?
    var listMainSubscriptionType: [ListData]?
    var listAttendanceType: [ListData]?
    var listModuleExamType: [ListData]?
    var listUserCanAttendaceStateType: [ListData]?
    var listCourseNaturePurchaseType: [ListData]?
    var listEnquiryScheduleTimeType: [ListData]?
}


// MARK: - List
struct ListData :Codable{
    var itemToken: String?
    var itemFileUrl: String?
    var itemThumbnailImageUrl: String?
    var itemFullCode: String?
    var itemName: String?
    var itemNameAr: String?
    var itemNameEn: String?


}

