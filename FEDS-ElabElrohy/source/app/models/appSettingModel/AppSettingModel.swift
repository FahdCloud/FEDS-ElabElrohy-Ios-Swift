
import Foundation

// MARK: - GetAppSettingModel
struct GetAppSettingModel:Codable {
    var status: Int?
    var msg: String?
    var executionTimeMilliseconds: Int?
    var userAuthorizeToken: String?
    var userAppSettingData: UserAppSetting?
//    var userAppSetting: UserAppSetting?
}

// MARK: - UserAppSetting
struct UserAppSetting :Codable{
    var userAppSettingToken: String?
    var userToken: String?
    var userPlatFormToken: String?
    var userPlatFormNameCurrent: String?
    var themeToken: String?
    var themeNameCurrent: String?
    var timeZoneToken: String?
    var timeZoneNameCurrent: String?
    var dateFormatToken: String?
    var dateFormatNameCurrent: String?
    var timeFormatToken: String?
    var timeFormatNameCurrent: String?
    var languageToken: String?
    var languageNameCurrent: String?
    var startDayOfWeekToken: String?
    var startDayOfWeekNameCurrent: String?
    var startMonthOfYear: Int?
    var startMonthOfYearNameCurrent: String?
    var startDayOfMonth: Int?
    var backAfterAddStatus: Bool?
    var backAfterEditStatus: Bool?
    var receiveNotificationStatus: Bool?
    var customSettings: String?
}


