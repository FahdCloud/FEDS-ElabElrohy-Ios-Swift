//
//  Constants.swift
//  FPLS-Dev
//
//  Created by Omar pakr on 26/07/2023.
//

import Foundation

class Constants {
    let PROJECT_LOGO = "Logo-Company"
    let COMPANY_DEV_LOGO = "logoWhiteCircle"
    let COMPANY_DEV_LOGO_Black = "logo black"

 // let BASE_URL = "https://feds-dev-v11.fahd-cloud.com"
 // let BASE_URL = "https://mr-marwanhassan.com"
    let BASE_URL = "https://elabelrohy.com"
    
    let BASE_URL_API = "/api/"

    let STATUS_SUCCESS = 200 // success operation
    let STATUS_INVALID_TOKEN = 498 // invaltoken token
    let STATUS_CATCH = 500// catch
    let STATUS_NO_CONTENT = 204 // no data
    let STATUS_ERROR = 406 // valtokenation
    let STATUS_VERSION = 306 // error version
    let STATUS_LOGIN_CODE = 499
    
    let USER_TOKEN = "user_token"
    let EMPLOYEE_TOKEN = "employee_token"
    let USER_SELECTED_IMAGE = "user_selected_image"
    let CODE = "CODE"
    
//    Courses Routes
    let KEY_ROUTE_COURSES = "Key_Route_Courses"
    let ROUTE_FROM_MAIN_PAGE = "courses_300"
    let ROUTE_FROM_MY_COURSES = "courses_301"
    let ROUTE_FROM_LECTUERES_COURSES = "courses_302"
    let ROUTE_FROM_CATEGORIES_COURESE = "courses_303"
    let ROUTE_FROM_CATEGORIES_LECTUERES_COURESE = "courses_304"

    
    let ACTIVATION_TYPE_TOKEN = "AST-17400"
    let FILTER_STATUS_ON = "true"
    let FILTER_STATUS_OFF = "false"
    let PAGINATION_STATUS_OFF = "true"
    let PAGINATION_STATUS_ON = "false"
    
    let TREATMENTNAME = "WC treatment plan.pdf"
    let REQUIREMNETNAME = "WC requirment plan.pdf"
    
    let SALE_STATUS_TYPE_TOKEN_SALED = "SAL-1"
    let SALE_STATUS_TYPE_TOKEN_NOT_SALED = "SAL-2"
    let SALE_STATUS_TYPE_TOKEN_ERROR = "SAL-3"
    
    let GUEST_AUTH_AR = "I/zw63O/xeCoF27z4xLwknLjry+NYHsaYlbUQsg0jYVf7enIKYxEn5HUCaq3XiJHD/HqsC7OdHNVgyhrbt5cX4ap/awEfBTKup96MUdA99Ce70wciEHdZrUUETewWKjvZgPkzHDJXd19/eVe4eUzIRM7VLegvXlGfvziWjTDUytpgwJnkJaopuyzO/9WM3VXxYXUVBuqLGvV6sU9sBpgyOhiXClLqYNgyOcOQBOTCZMUilZQwjHjEg16QrW+AKRL0d5vxhd5xq0s+3voSuLk69iP6JJc9iiw9fEA8s9KvyUnaxCrPkiqj10NqGZl3AjU+dS5woyzZv/0F7OGg1XwW/bcUngYooXDzDjykktnQYt6xCmL1mO0OreCJf2QlUc1zwVRICdLqrV+5065Tg0XBE+AIzRn/ca7gm+jaOGhLJX9We1v5fICptm399z3hUaGfFnB7ajzfOaa1vorQO6RrhhxdxafJ/Rk6b1mICIkUd1j6VD9DkmdaMg4t/IqSZafdrkpZCCA0xeRLQNaH8CzcU31kJNzOUhuEGBuq2POpTTmtmL7sOlT9DR3UK2HNuwpSZV+I9k23Xaw+GLRWkV1AXBAYxrgv+ojWpz6IxWT7CMYmAW063MJKqDYUFNLt3q7ClpWhmxxcERfHn7VQcM2aQgLzBc1At7g3+h3HMXM3oQeKkN3QQHc1CYGPShmeGF2wY7mIRUwNmucjI0EPirtGo9LGWgDjHKY7/9XIKsUUvhgj5m3jxXIKijV+NEsmjTsEfMMYFuAdcLg/WszKAjdt6dwQYZcpK/ukOyBugdHI3wvBJ1YhvIzU6zKecIDvKv4Rq+OF0CTuxigB7fgRt4xyoPCdf+HWgd4K3A0FvrnwbWAYmpWdIC5ewHUw7AaPBPD9xCidZW4qLWuPB7HqIviqaUHll2bbZweM11AKgmZ4KRUAFmaYKHIt9Ef1FXV9C3wU6BVcDmy+sdWPXFhKlYH24hbp4GUiRLLaFSND+Oak50BAzSxNieLvvSp+CVckHElpW0XqnsNJnvbC2U/6Aka/JRK5HwkJUuop0k+jETos/IEkuloqErZerLl28HbeDLrbAWTnkB4m3ilGmxiyTFNuj/6NGyQERVWaZMlSGplB1lISExKT2O6zsfKJZlDdv9wjJvkuSyd2V980bgtt1WKm46CKpjaea5OHjRho88qys+KybJVtGGVaCC5BAMb48pNyIw4TICQADBmeLaw5Uotb5eIaCFVkbvH7FEkBNKGWIEoHxFd6tMnvawu57GtdVTpT/CoDIGI9otyRM3RgQMiDXng4PHhrKei1AyTfeRCC42FgIrolIhbzmIgi1mNMOP+35UMviQ8c9fd/F0WOBkxb8iNXbtNXKSFQso4zzjetkdNEM8r08on0U13qUOnQmT5dowHthY3ffOQkIACiyDf1wKY/94UzcXfQ+UVrJ79+kTh9Gjgz1GFHHsPulGqKUP7L4vHuCqaMC2D+NN54AF2bF1vi5WlBtDN6xNYSsdlUswOkk5QRAJpUXidtSvN4QA6K/Z5nK/5YINBYDV98XdmxgpUo4kN+II0hKKa5QjZJ0tmTPPUaG6fY0DRkCwDlRdqV47z9xpoRvlzQsEgnEIbCVph51BzxEASGKTkUMERiKcLwluTC2gZpYMMIFzPVkGOda9hh89/th8RSkWWYy8rDgxGS5ZdLFPuId5pRnyxkmVXXemeoBio+7XpHvZl+MnRTXtAXGel5aUblr6gy9uSazZpw5qXtm0IuG9V1mC/xOtzqJ48iPzmJQQ57sd+dCM9yFdB4fHpkY9tlMZVhfCGNzojgBFWVH5CyJxPmSElGYW7j2vZVxlkyZjl6ISymDigWUgI2mgciME48qFxu+xzv7T8Xjvw6/HX4OcqSV+U8SrvJKJxO61+Pe5o91rX7YOAwtEXxrVNOqw2/lLsE2GA8rwWyOiZzlIikiYQKWkq6NlbT06eJQW9nkx8fZcs1hciLyYAdNnhf1wpXAfQPdYqn/RtWUBUVcgndJ2pJTIYN8CF3V1d8x+AY8A2VuzA4AWHA4OSPdBxTqAgOEZjxze6MR6S9ZBgg9n00Ad4DUKtwsI="
    
    let GUEST_AUTH_EN = "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"
     

    let PAGE_SIZE = UserDefaultss().restoreString(key: "selectedPage")

    let REGION_AR = "EG"
    let REGION_EN = "US"

    let APP_IOS_LANGUAGE_AR = "ar"
    let APP_IOS_LANGUAGE_EN = "en"

    let USER_APP_SETTINGS_DATA = "userAppSettingData"
    let CONSTANT_LIST_DATA = "constantListDataa"
    let APP_LANGUAGE_AR = "ar-EG"
    let API_LANGUAGE_EN = "en-US"
    let APP_LANGUAGE_UND =  "und"

    let APP_THEME_TOKEN_LIGHT = "THEM-1"
    let APP_THEME_TOKEN_DARK = "THEM-2" 
    
    let USER_EDUCATION_SYSTEM_TYPE_TOKEN_CENTER = "EducationSystemType-3"
    let USER_EDUCATION_SYSTEM_TYPE_TOKEN_ONLINE = "TEducationSystemType-1"
    
    let EDUCATION_GROUP_CLOSED_STATE_CLOSED = "CLST-1"
    let EDUCATION_GROUP_CLOSED_STATE_OPEN = "CLST-2"
    
    
    let GROUPS_FINISHED = "FINISH-1"
    let GROUPS_UN_FINISHED = "FINISH-2" 
    
    let GROUPS_CLOESE = "CLST-1"
    let GROUPS_OPEN = "CLST-2"
    
    let EXAM_DELIVERY_STATUS_UNKNOWN = "ExamDeliveryStatusType-1"
    let EXAM_DELIVERY_STATUS_DELIVERD = "ExamDeliveryStatusType-2" 
    
    let MODULE_EXAM_TYPE_TOKEN_EXAMS = "ModuleExamType-2"
    let MODULE_EXAM_TYPE_TOKEN_HW = "ModuleExamType-3" 
    
    let EXAM_SEARCH_STATUS_TYPE_CURRENT = "ExamSearchStatusType-1"
    let EXAM_SEARCH_STATUS_TYPE_FINISHED = "ExamSearchStatusType-2" 
    
    let EXAM_DELIVERY_STATUS_TYPE_NOT_DELIVERD = "ExamSearchStatusType-1"
    let EXAM_DELIVERY_STATUS_TYPE_DELIVERD = "ExamDeliveryStatusType-2"
    

    let NOT_FOUND_EN = "Not found"
    let NOT_FOUND_AR = "لا يوجد"
    
    let MEDIA_TYPE_IMAGE = "MTT-1"
    let MEDIA_TYPE_VIDEO = "MTT-2"
    let MEDIA_TYPE_EXCEl = "MTT-5"
    let MEDIA_TYPE_WORD = "MTT-6"
    let MEDIA_TYPE_POWERPOINT = "MTT-7"
    let MEDIA_TYPE_PDF = "MTT-4"
    let MEDIA_TYPE_VOICE = "MTT-3"
    let MEDIA_TYPE_LINK = "MTT-8"
    let MEDIA_TYPE_OTHER = "MTT-9"
    
    let LESSONS_TYPE_TOKEN_FILE = "EducationalCourseLessonType-1"
    let LESSONS_TYPE_TOKEN_EXAM = "EducationalCourseLessonType-2"

    
    let PAYMENT_TYPE_BANK = "INT-1"
    let PAYMENT_TYPE_PHONE_WALLET = "INT-2"
//    let PAYMENT_TYPE_PHONE_WALLET_ETIS = "PMT-5"
//    let PAYMENT_TYPE_PHONE_WALLET_ORNG = "PMT-4"

    let STORAGE_TYPE_MASTER = "StorageSpace_UTT_12400"
    let STORAGE_TYPE_EMPLOYEE = "StorageSpace_UTT_12500"
    let STORAGE_TYPE_STUDENT = "StorageSpace_UTT_12800"
    let STORAGE_TYPE_PLACES = "StorageSpace_STTS-1"
    let STORAGE_TYPE_EDUCATIONAL_CATEGORY = "StorageSpace_STTS-2"
    let STORAGE_TYPE_GROUPS = "StorageSpace_EducationalGroup"

    let STORAGE_SPACE_MEDIA_TYPE_MASTER = "StorageSpaceMediaType_UTT_12400"
    let STORAGE_SPACE_MEDIA_TYPE_EMPLOYEE = "StorageSpaceMediaType_UTT_12500"
    let STORAGE_SPACE_MEDIA_TYPE_STUDENT = "StorageSpaceMediaType_UTT_12800"
    let STORAGE_SPACE_MEDIA_TYPE_PLACES = "StorageSpaceMediaType_STTS-1"
    let STORAGE_SPACE_MEDIA_TYPE_EDUCATIONAL_CATEGORY = "StorageSpaceMediaType_STTS-2"
    let STORAGE_SPACE_MEDIA_TYPE_GROUPS = "StorageSpaceMediaType_EducationalGroup"

    let ATTENDANCE_TYPE_ATTEND = "AttendanceType-1"
    let ATTENDANCE_TYPE_DEPARTURE = "AttendanceType-2"
    let ATTENDANCE_TYPE_UNKNOW = "AttendanceType-3"

    let SUBSCRIPTION_TYPE_PACKAGE = "SUBSCRIPTION-1"
    let SUBSCRIPTION_TYPE_SESSION = "SUBSCRIPTION-2"
    let SUBSCRIPTION_TYPE_HOUR = "SUBSCRIPTION-3"
    
    
    let SCHEDULING_TYPE_SCHEDUILED = "SCHEDULE-1"
    let SCHEDULING_TYPE_UN_SCHEDUILED = "SCHEDULE-2"
    
    
    

    let GROUP_RATE_TOKEN = "ERTT-2"

    let underReview = "APPO-1"
    let accepted = "APPO-2"
    let rejected = "APPO-3"

    let PREFERD_LANGUAGE = "preferdLanguage"
    
    let establishmentToken = "F92DFB74-9CB9-44AD-B5AD-A946C3D1018F"
    
    let timeZoneToken = ""
    
    let VIEW_SUCCESS = 100 // success operation
    let VIEW_CATCH = 200// catch
    let VIEW_NO_CONTENT = 300 // no data
    let VIEW_ERROR = 400 // valtokenation
    
    let DIFFERENCE_DATE_IN_MILISECONDS = 0
    let DIFFERENCE_DATE_IN_SECONDS = 1
    let DIFFERENCE_DATE_IN_MINUTES = 2
    let DIFFERENCE_DATE_IN_HOURS = 3
    let DIFFERENCE_DATE_IN_DAYS = 4
    let DIFFERENCE_DATE_IN_WEEKS = 5
    let DIFFERENCE_DATE_IN_MONTHES = 6
    let DIFFERENCE_DATE_IN_YEARS = 7
    
    let TOOL_BAR_BACKGROUNDIMAGE = "wave-2"
    
    let DATE_TIME_FORAMT_1 = "yyyy/MM/dd hh:mm:ss a" //    2018/09/12 04:11:54 pm / PM
    let DATE_TIME_FORAMT_2 = "yyyy/MM/dd HH:mm:ss" //    2018/09/12 22:11:54
    let DATE_TIME_FORAMT_3 = "E, d MMM yyyy HH:mm:ss Z" //    Wed, 12 Sep 2018 14:11:54 +0000
    let DATE_TIME_FORAMT_4 = "yyyy-MM-dd'T'HH:mm:ssZ" //    2018-09-12T14:11:54+0000
    let DATE_TIME_FORAMT_5 = "EEEE, MMM d, yyyy" //    Wednesday, Sep 12, 2018
    let DATE_TIME_FORAMT_6 = "MMM d, h:mm a" //    Sep 12, 2:11 PM
    let DATE_TIME_FORAMT_7 = "MMMM yyyy" //      September 2018
    let DATE_TIME_FORAMT_8 = "HH:mm:ss.SSS" //    10:41:02.112
    let DATE_TIME_FORAMT_9 = "yyyy/MM/dd"
    
    let APPROVAL_TYPE_TOKEN_APPROVED = "APPROVAL-2"
    let APPROVAL_TYPE_TOKEN_IN_REVIEW = "APPROVAL-1"
    let APPROVAL_TYPE_TOKEN_REJECTED = "APPROVAL-3"

    let EXAM_UNKNOWN_STATUS_TYPE_TOKEN = "EXAM_SUBMIT_STATUS-1"
    let EXAM_SUBMIT_STATUS_TYPE_TOKEN = "EXAM_SUBMIT_STATUS-2"
    
    let CALENDER_SEARCH_TYPE = "CST-5"

    
    let CALENDER_SEARCH_TYPE_TOKEN_SIMPOL_DAY = "CST-1"
    let CALENDER_SEARCH_TYPE_TOKEN_SIMPOL_WEEK = "CST-2"
    let CALENDER_SEARCH_TYPE_TOKEN_SIMPOL_MONTH = "CST-3"
    let CALENDER_SEARCH_TYPE_TOKEN_SIMPOL_YEAR = "CST-4"
    let CALENDER_SEARCH_TYPE_TOKEN_SIMPOL_CUSTOIZE = "CST-5"
    
    let ATTENDANCE_TYPE_TOKEN_ATTEND = "ATTS-1"
    let ATTENDANCE_TYPE_TOKEN_ABSCENC = "ATTS-2"
    
    let CANCELATION_TYPE_TOKEN_CANCELED = "CANCLE-1"
    let CANCELATION_TYPE_TOKEN_UN_CANCELED = "CANCLE-2"
    

    let Day = "CST-1"
    let Week = "CST-2"
    let Month = "CST-3"
    let Year = "CST-4"
    let Customize = "CST-5"
    
    let TOKEN_COMPLAINT_ANSWER_FROM_MANAGEMENT : String = "FUST-1"
    let TOKEN_COMPLAINT_ANSWER_FROM_ME : String = "FUST-2"
    
    
    let SCHEDULING_STATUS_TYPE_TOKEN_NON_SCHEDULED = "SCHEDULE-2"
    let SCHEDULING_STATUS_TYPE_TOKEN_SCHEDULED : String = "SCHEDULE-1"
    let CANCEL_TYPE_TOKEN_REJECTED = "CANCLE-1"
    let CANCEL_TYPE_TOKEN_PAID = "CANCLE-2"
  


  //BaseProjectsModule
     let Establishment = 100000
     let EstablishmentRole = 110000
     let UsersVersion = 120000
     let SystemComponent = 130000
     let SystemComponentsHierarchy = 140000
  //AdditionalSettings
     let Qualification = 150000
     let BloodType = 160000
     let MilitaryStatusType = 170000
     let SocialStatuse = 180000
     let Bank = 190000
     let Religion = 200000
     let InsuranceCompany = 210000
     let Country = 220000
     let Governorate = 230000
     let City = 240000
     let  District = 250000
     let PersonalCardType = 260000
     let GeneralJob = 270000
     let RelativeRelationType = 280000
     let  Sector = 290000
     let  Job = 300000
     let  ClassificationDegree = 310000
     let  ScientificDegree = 320000
     let  Certificate = 330000
//  //User
     let userTypeSymbol = "UTT-"
     let  USER_TYPE_TOKEN_STUDENT = "UTT_6"
    let  USER_TYPE_TOKEN_FAMILY = "UTT_7"
     let  USER_TYPE_TOKEN_ENPLOYEE = "UTT_12500"
     let  USER_TYPE_TOKEN_PROVIDER = "UTT_5"
     let  MasterAdmin = 12400
     let  AdminsEgypt = 12300

     let  UserValidSetting = 350000
     let  Notification = 360000
     let  UserQualification = 370000
     let  UserScientificDegree = 380000
     let  UserTrainingCourse = 390000
     let UserExperience = 400000
     let UserStorage = 410000
     let  UserStorageMedia = 420000
     let UserPersonalCard = 430000
    
 
  //Place
     let Place = 440000
     let  PlaceStorage = 450000
     let PlaceStorageMedia = 460000
    
    let CANRELATED_TYPE_YES = "CANRELATED-1"
    let CANRELATED_TYPE_NO = "CANRELATED-2"
    
    let PAGE_TOKEN_NEWS = "NewsArticles"
    let PAGE_TOKEN_SCHEDULE_TIMES = "EducationalGroupScheduleTimes"
    
//    WalletRouting
    
    let Wallet_View = "WA-1"
    let Wallet_Online_Levels_Content_View = "WA-2"
    let Wallet_My_Online_Levels_Content_View = "WA-3"
    
//    Course purchase type
    let CoursePurchaseType_WalletCode = "CourseNaturePurchaseType-1"
    let CoursePurchaseType_CourseCode = "CourseNaturePurchaseType-2"
    let CoursePurchaseType_AcademicYearCode = "CourseNaturePurchaseType-3"

//    Educational Course Subscription Type
    
    let duration = "EducationalCourseSubscriptionType-1"
    let countTimes = "EducationalCourseSubscriptionType-2"

//    user Education System Type
    
    let EDUCATION_SYSTEM_TYPE_ONLINE = "EducationSystemType-1"
    let EDUCATION_SYSTEM_TYPE_ALL_CENTERS = "EducationSystemType-2"
    let EDUCATION_SYSTEM_TYPE_CENTER = "EducationSystemType-3"

}

