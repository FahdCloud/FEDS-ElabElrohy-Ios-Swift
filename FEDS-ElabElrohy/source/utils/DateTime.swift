//
//  DateTime.swift
//  VCD-DEV
//
//  Created by Omar pakr Hany on 08/02/2022.
//


import Foundation
import UIKit

class DateTime {
    
    static func getDiffrenceDateTime(dateTimeFormat :String , date :String ) throws -> Date{
        var dateOutput = Date()
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en")
        formatter.dateFormat = dateTimeFormat
        formatter.timeZone = TimeZone.init(secondsFromGMT: 0)
        dateOutput = formatter.date(from: date)!

        
        return dateOutput
       
    }
    
    static func formateDate(date : String) -> String {
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss Z"

        // Convert the original date string to a Date object
        if let date = inputFormatter.date(from: date) {
            let outputFormatter = DateFormatter()
             outputFormatter.dateFormat = "yyyy/MM/dd"

             let formattedDateString = outputFormatter.string(from: date)
            return formattedDateString
        }
     return ""
    }
    

    static func getDiffrenceDateTime(dateTimeFormat :String , startDate :String , endDate:String , diffrenceType:Int) throws -> Double{
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en")
        formatter.dateFormat = dateTimeFormat
        formatter.timeZone = TimeZone.init(secondsFromGMT: 0)
        
        let startDateForamt = formatter.date(from: startDate)
        let endDateForamt = formatter.date(from: endDate)
   

        let differenceSeconds = (endDateForamt! - startDateForamt!)
        
        if diffrenceType == Constants().DIFFERENCE_DATE_IN_MILISECONDS {
            return differenceSeconds.asMilisecond()
        } else if diffrenceType == Constants().DIFFERENCE_DATE_IN_SECONDS {
            return differenceSeconds
        } else if diffrenceType == Constants().DIFFERENCE_DATE_IN_MINUTES {
            return differenceSeconds.asMinutes()
        } else if diffrenceType == Constants().DIFFERENCE_DATE_IN_HOURS {
            return differenceSeconds.asHours()
        } else if diffrenceType == Constants().DIFFERENCE_DATE_IN_DAYS{
            return differenceSeconds.asDays()
        } else if diffrenceType == Constants().DIFFERENCE_DATE_IN_WEEKS{
            return differenceSeconds.asWeeks()
        } else if diffrenceType == Constants().DIFFERENCE_DATE_IN_MONTHES {
            return differenceSeconds.asMonths()
        } else if diffrenceType == Constants().DIFFERENCE_DATE_IN_YEARS {
            return differenceSeconds.asYears()
        } else {
            return differenceSeconds
        }
        
       
    }
    
    
    public static func formatTimeInSec(language :String, milliseconds : Int64)throws ->String {
        var output:String  = ""
        let days :Int64 = milliseconds / (24 * 60 * 60 * 1000)
        let hours :Int64 = milliseconds / (60 * 60 * 1000) % 24
        let minutes :Int64 = milliseconds / (60 * 1000) % 60
        var seconds :Int64 = milliseconds / 1000 % 60

        var s : String = String(format: "%02d", seconds)
        var m :  String = String(format: "%02d", minutes)
        var h : String = String(format: "%02d", hours)
        var d :  String = String(format: "%02d", days)
  
            if days < 10 {
                d = "0" + String(days)
            }
            if seconds < 10 {
                s = "0" + String(seconds)
            }
            if minutes < 10 {
                m = "0" + String(minutes)
            }
            if hours < 10 {
                h = "0" + String(hours)
            }
            output = d + " : " + h + " : " + m + " : " + s
        
//        if language == Constants().APP_LANGUAGE_EN {
//                output = hoursD + " : " + minutesD + " : " + secondsD
//            }else {
//                output = secondsD +  " : " + minutesD + " : " + hoursD
//
//            }
            return output
        }

    
    public static func formatTimeInMillis(language :String, millis : Int64)throws ->String {
        var output:String  = ""
        var seconds :Int64 = millis / 1000
        var minutes :Int64 = seconds / 60
        var hours :Int64 = minutes / 60


            seconds = seconds % 60
            minutes = minutes % 60
            hours = hours % 60


            var secondsD :  String = String(seconds)
            var minutesD :  String = String(minutes)
            var hoursD :  String = String(hours)


            if seconds < 10 {
                secondsD = "0" + String(seconds)
            }
            if minutes < 10 {
                minutesD = "0" + String(minutes)
            }
            if hours < 10 {
                hoursD = "0" + String(hours)
            }
            output = hoursD + " : " + minutesD + " : " + secondsD

//        if language == Constants().APP_LANGUAGE_EN {
//                output = hoursD + " : " + minutesD + " : " + secondsD
//            }else {
//                output = secondsD +  " : " + minutesD + " : " + hoursD
//
//            }
            return output
        }
    
    public static func startCounter(lang : String,timeInSec : Int64,decreasedTime :Int64 , timerLbl : UILabel ,regenerateBtn : UIButton){
        var timeLeft = timeInSec
        var counterFormat :String = ""
        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
   
         timeLeft -= decreasedTime
          
          do {
              counterFormat  = try  DateTime.formatTimeInSec(language: lang, milliseconds: timeLeft)
          } catch {
              
          }
          if timeLeft > 0 {
             timerLbl.isHidden = false
          }

          timerLbl.text = String(counterFormat)
      
        
       if(timeLeft==0){
            timerLbl.isHidden = true
           regenerateBtn.isHidden = false
              timer.invalidate()
             }
       }
    }
    
    public static func formattedTime(_ milliseconds: Int) -> String {
          let seconds = milliseconds / 1000
          let hours = seconds / 3600
          let minutes = (seconds % 3600) / 60
          let remainingSeconds = (seconds % 3600) % 60

          return String(format: "%02d:%02d:%02d", hours, minutes, remainingSeconds)
      }
    
    
    public static func formatApiDate(date :String) -> String {
        var day : String = ""
        var month  :String = ""
        var year  :String = ""
        var returnDate : String = ""
          
        if Validation.vaildPatternDate(date: date) {
                
                let dateSplite = date.split{$0 == "/"}.map(String.init)
                let start: String = dateSplite[0]
                let middle: String = dateSplite[1]
                let end: String = dateSplite[2]
             
            if start.count >= 4{
                    year = start;
                    month = middle;
                    day = end;
                } else if end.count >= 4 {
                    year = end;
                    month = middle;
                    day = start;

                } else {
                    year = "";
                    month = "";
                    day = "";
                }
            returnDate = Helper.arToEn(number: year + "/" + month + "/" + day)
           

        } else {
            return returnDate
        }
            return returnDate
      
    }
    

    public static func getDateTimeForNow(lang : String) -> String {
        
        let date = Date()
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US")
        formatter.dateFormat = "yyyy/MM/dd hh:mm:ss a"
        let dateTimeString = formatter.string(from: date)
    
        return dateTimeString

    }
    
    public static func getDateForNow() -> String {
        
        let date = Date()
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US")
        formatter.dateFormat = "yyyy/MM/dd"
        let dateTimeString = formatter.string(from: date)
    
        return DateTime.replaceCharcaterToEnglish(value: dateTimeString)

    }
    
    public static func formateDate(date:Date) -> String {
        
        let date = date
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US")
        formatter.dateFormat = "yyyy/MM/dd"
        let dateTimeString = formatter.string(from: date)
    
        return dateTimeString

    }
    
    public static func formatDuration(milliseconds: Int) -> String {
        // Convert milliseconds to seconds
        let seconds = Double(18000000000) / 1000.0
        
        // Create a DateComponentsFormatter
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.day,.hour, .minute, .second]
        formatter.unitsStyle = .positional
        formatter.zeroFormattingBehavior = .pad
        
        // Customize the formatting to include leading zeros and to use a custom separator ":"
        formatter.zeroFormattingBehavior = .pad
        formatter.allowsFractionalUnits = false
        
        // The format you asked for doesn't directly correspond to a single DateComponentsFormatter option,
        // so we need to manipulate the string a bit if it is less than an hour.
        if let formattedString = formatter.string(from: seconds) {
            // Check if the string contains an hour component
//            if formattedString.count <= 5 {
//                // If not, pad the string with "0:" to represent 0 hours
//                return "0:" + formattedString
//            }
            return formattedString
        } else {
            return "Formatting error"
        }
    }
    
    public static func formateTime(date:Date) -> String {
        
        let date = date
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US")
        formatter.dateFormat = "hh:MM:ss a"
        let dateTimeString = formatter.string(from: date)
    
        return dateTimeString

    }
  public static func formatTime(_ timeString: String) -> String {
     let time = replaceCharcaterToEnglish(value: timeString)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "hh:mm:ss a" // The input format
        if let date = dateFormatter.date(from: time) {
            dateFormatter.dateFormat = "hh:mm a" // The desired output format
            return dateFormatter.string(from: date)
        } else {
            return timeString // Return the original string if conversion fails
        }
    }
    
   public static func getDate(date : Date) -> (String,String,String){
        let calendarr = Calendar.current
        let components = calendarr.dateComponents([.day,.month,.year], from: date)
        if let day = components.day, let month = components.month, let year = components.year {
            let dayString = String(day)
            let monthString = String(month)
            let yearString = String(year)
            
            return (dayString,monthString,yearString)
        }
        return ("","","")
    }

    public static func fotmatDateInMultiLang(lang :String? ,date :String ) -> String {
        var day : String = ""
        var month  :String = ""
        var year  :String = ""
        var returnDate : String = ""
          
        if Validation.vaildPatternDate(date: date) {
                
                let dateSplite = date.split{$0 == "/"}.map(String.init)
                let start: String = dateSplite[0]
            let middle: String = dateSplite[1]
            let end: String = dateSplite[2]
             
            if start.count >= 4{
                    year = start;
                    month = middle;
                    day = end;
                } else if end.count >= 4 {
                    year = end;
                    month = middle;
                    day = start;

                } else {
                    year = "";
                    month = "";
                    day = "";
                }
            if lang != nil && lang == Constants().APP_LANGUAGE_AR {
                returnDate = Helper.enToAr(number: year + "/" + month + "/" + day)
                       } else {
                           returnDate = Helper.arToEn(number: day + "/" + month + "/" + year)
                       }
           

        } else {
            return returnDate
        }
            return returnDate
      
    }
    
    public static func replaceCharcaterInTime(language : String,value : String) -> String {
        var numberr : String = ""
        if language == Constants().APP_IOS_LANGUAGE_EN{
            numberr = ((((((((((((((value + "")
                                                    .replacingOccurrences(of: "٠", with: "0")).replacingOccurrences(of: "١", with: "1"))
                                                    .replacingOccurrences(of: "٢", with: "2")).replacingOccurrences(of: "٣", with: "3"))
                                                    .replacingOccurrences(of: "٤", with: "4")).replacingOccurrences(of: "٥", with: "5"))
                                                    .replacingOccurrences(of: "٦", with: "6")).replacingOccurrences(of: "٧", with: "7"))
                                                    .replacingOccurrences(of: "٨", with: "8")).replacingOccurrences(of: "٩", with: "9"))
                                                    .replacingOccurrences(of: "صباحاً", with: "AM")).replacingOccurrences(of: "مساءً", with: "PM"))
                                                    .replacingOccurrences(of: "ص", with: "AM")).replacingOccurrences(of: "م", with: "PM")
                                                    .replacingOccurrences(of: "ج.م", with: "EGP")
            
            return numberr
        } else {
            numberr = ((((((((((((value + "")
                                                    .replacingOccurrences(of: "0", with: "٠")).replacingOccurrences(of: "1", with: "١"))
                                                    .replacingOccurrences(of: "2", with: "٢")).replacingOccurrences(of: "3", with: "٣"))
                                                    .replacingOccurrences(of: "4", with: "٤")).replacingOccurrences(of: "5", with: "٥"))
                                                    .replacingOccurrences(of: "6", with: "٦")).replacingOccurrences(of: "7", with: "٧"))
                                                    .replacingOccurrences(of: "8", with: "٨")).replacingOccurrences(of: "9", with: "٩"))
                                                    .replacingOccurrences(of: "AM", with: "ص")).replacingOccurrences(of: "PM", with: "م")
                                                    .replacingOccurrences(of: "EGP", with: "ج.م")
            
            return numberr
        }

        }
    
    public static func replaceCharcaterInMoney(language : String , value : String ) -> String {
        var numberr : String = ""
        if language == Constants().APP_IOS_LANGUAGE_EN{
            numberr = (((((((((((value + "")
                                                    .replacingOccurrences(of: "٠", with: "0")).replacingOccurrences(of: "١", with: "1"))
                                                    .replacingOccurrences(of: "٢", with: "2")).replacingOccurrences(of: "٣", with: "3"))
                                                    .replacingOccurrences(of: "٤", with: "4")).replacingOccurrences(of: "٥", with: "5"))
                                                    .replacingOccurrences(of: "٦", with: "6")).replacingOccurrences(of: "٧", with: "7"))
                                                    .replacingOccurrences(of: "٨", with: "8")).replacingOccurrences(of: "٩", with: "9"))
                                                    .replacingOccurrences(of: "ج.م", with: "EGP")
            
            return numberr
        } else {
            numberr = (((((((((((value + "")
                                                    .replacingOccurrences(of: "0", with: "٠")).replacingOccurrences(of: "1", with: "١"))
                                                    .replacingOccurrences(of: "2", with: "٢")).replacingOccurrences(of: "3", with: "٣"))
                                                    .replacingOccurrences(of: "4", with: "٤")).replacingOccurrences(of: "5", with: "٥"))
                                                    .replacingOccurrences(of: "6", with: "٦")).replacingOccurrences(of: "7", with: "٧"))
                                                    .replacingOccurrences(of: "8", with: "٨")).replacingOccurrences(of: "9", with: "٩"))
                                                    .replacingOccurrences(of: "EGP", with: "ج.م")
            
            return numberr
        }
    }
    
    public static func replaceCharcaterToEnglish(value:String ) -> String {
        var numberr : String = ""
            numberr = (((((((((((value + "")
                                                    .replacingOccurrences(of: "٠", with: "0")).replacingOccurrences(of: "١", with: "1"))
                                                    .replacingOccurrences(of: "٢", with: "2")).replacingOccurrences(of: "٣", with: "3"))
                                                    .replacingOccurrences(of: "٤", with: "4")).replacingOccurrences(of: "٥", with: "5"))
                                                    .replacingOccurrences(of: "٦", with: "6")).replacingOccurrences(of: "٧", with: "7"))
                                                    .replacingOccurrences(of: "٨", with: "8")).replacingOccurrences(of: "٩", with: "9"))
                                                    .replacingOccurrences(of: "ج.م", with:  "EGP")
//                                                    .replacingOccurrences(of: "صباحاً", with: "AM")).replacingOccurrences(of: "مساءً", with: "PM"))
//                                                    .replacingOccurrences(of: "ص", with: "AM")).replacingOccurrences(of: "م", with: "PM")
            
            return numberr
     

        }

}


extension Date {
    static func - (lhs: Date, rhs: Date) -> TimeInterval {
        return lhs.timeIntervalSinceReferenceDate - rhs.timeIntervalSinceReferenceDate
    }
}

extension TimeInterval {
    func asMilisecond() -> Double { return self * (1000)}
    func asMinutes() -> Double { return self / (60.0) }
    func asHours()   -> Double { return self / (60.0 * 60.0) }
    func asDays()    -> Double { return self / (60.0 * 60.0 * 24.0) }
    func asWeeks()   -> Double { return self / (60.0 * 60.0 * 24.0 * 7.0) }
    func asMonths()  -> Double { return self / (60.0 * 60.0 * 24.0 * 30.4369) }
    func asYears()   -> Double { return self / (60.0 * 60.0 * 24.0 * 365.2422) }
}

