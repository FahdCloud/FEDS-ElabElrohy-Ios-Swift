//
//  GetNotificationModel.swift
//  FPLS-Dev
//
//  Created by Omar pakr on 27/11/2023.
//

import Foundation


// MARK: - GetNotification
struct GetNotification : Codable{
    var status: Int?
    var msg: String?
    var executionTimeMilliseconds: Int?
    var pagination: Pagination?
    var notificationsData: [NotificationsDatum]?
}

// NotificationsDatum.swift

import Foundation

// MARK: - NotificationsDatum
struct NotificationsDatum : Codable{
    var notificationToken: String?
    var dateTime: String?
    var dateTimeAgo: String?
    var titleCurrent: String?
    var titleAr: String?
    var titleEn: String?
    var titleUnd: String?
    var bodyCurrent: String?
    var bodyAr: String?
    var bodyEn: String?
    var bodyUnd: String?
    var usersList: String?
    var statusOpen: Bool?
    var statusRead: Bool?
    var userFireBaseId: String?
    var userPlatFormToken: String?
    var itemToken: String?
    var itemImagePath: String?
    var pageGoToToken: String?
    var pageGoToNameAr: String?
    var pageGoToNameEn: String?
    var pageGoToNameUnd: String?
    var notificationArchiveStatus: Bool?
    var userToken: String?
    var dailyCode: Int?
    var fullCode: String?
    var createdByUserToken: String?
    var userCreatedData: UserAtedData?
    var lastUpdatedByUserToken: String?
    var userLastUpdatedData: UserAtedData?
    var establishmentToken: String?
    var timeZoneName: String?
    var creationDateTime: String?
    var creationDate: String?
    var creationTime: String?
    var lastUpdateDateTime: String?
    var lastUpdateDate: String?
    var lastUpdateTime: String?
}

// MARK: - ReadNotification
struct ReadNotification :Codable{
    var language: String?
    var userAuthorizeToken: String?
    var token: String?
    var statusRead: String?
}

