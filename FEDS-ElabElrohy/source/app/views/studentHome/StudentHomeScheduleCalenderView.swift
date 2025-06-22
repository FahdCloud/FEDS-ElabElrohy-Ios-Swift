//
//  Calender.swift
//  FPLS-Dev
//
//  Created by Omar pakr on 04/09/2023.
//

import SwiftUI
import FSCalendar

class StudentHomeScheduleCalenderView: ObservableObject {
    @Published var selectedDate: Date = Date()
}

struct Calender: View {
    @State var selectedDate : Date = Date()
    var body: some View {
        VStack{
        
            
        }
    }
}

struct Calender_Previews: PreviewProvider {
    static var previews: some View {
        Calender()
    }
}


struct CalenderRepresentable : UIViewRepresentable {
    var lang = Locale.current.language.languageCode!.identifier
    var constants = Constants()
    typealias UIViewType = FSCalendar
    var calendar = FSCalendar()
    @Binding var selectedDate : Date?
    @ObservedObject var viewModel: EducationGroupTimeVm

    let isDark = UserDefaultss().restoreBool(key: "isDark")

    
    func updateUIView(_ uiView: FSCalendar, context: Context) {
        uiView.select(viewModel.selectedDate)
    }
    
    
    func makeUIView(context: Context) -> FSCalendar {
        
        calendar.delegate = context.coordinator
        calendar.dataSource = context.coordinator
        calendar.scope = .week
        calendar.appearance.todayColor = Colors().buttonGreenColorLight
        calendar.appearance.selectionColor = Colors().mainColor
        calendar.appearance.titleTodayColor = .white
        calendar.appearance.titleDefaultColor = isDark ? .white : .black
        calendar.appearance.headerTitleColor = isDark ? .white : .black
    
        if self.lang == self.constants.APP_IOS_LANGUAGE_AR {
            self.calendar.appearance.weekdayFont = UIFont(name: Fonts().getFontBold(), size: 16)
            self.calendar.appearance.titleFont = UIFont(name: Fonts().getFontBold(), size: 16)
            self.calendar.appearance.subtitleFont = UIFont(name: Fonts().getFontBold(), size: 16)
            self.calendar.appearance.headerTitleFont = UIFont(name: Fonts().getFontBold(), size: 16)
        } else {
            self.calendar.appearance.weekdayFont = UIFont(name: Fonts().english_cairo_variable, size: 16)
            self.calendar.appearance.titleFont = UIFont(name: Fonts().english_cairo_variable, size: 16)
            self.calendar.appearance.subtitleFont = UIFont(name: Fonts().english_cairo_variable, size: 16)
            self.calendar.appearance.headerTitleFont = UIFont(name: Fonts().english_cairo_variable, size: 16)
        }


        return calendar
    }
    
  
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    class Coordinator: NSObject , FSCalendarDelegate,FSCalendarDataSource {
        var parent : CalenderRepresentable

        
        init(_ parent : CalenderRepresentable) {
            self.parent = parent
        
        }
        
         func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
             
             
             parent.selectedDate = date
             parent.viewModel.selectedDate = date
             
             let calendarr = Calendar.current
             let components = calendarr.dateComponents([.day,.month,.year], from: date)
             if let day = components.day, let month = components.month, let year = components.year {
                 let dayString = String(day)
                 let monthString = String(month)
                 let yearString = String(year)

                 self.parent.viewModel.day = dayString
                 self.parent.viewModel.month = monthString
                 self.parent.viewModel.year = yearString
                 UserDefaultss().saveStrings(value: dayString, key: "day")
                 UserDefaultss().saveStrings(value: monthString, key: "month")
                 UserDefaultss().saveStrings(value: yearString, key: "year")
                 self.parent.viewModel.token = ""
                 do {
                    try self.parent.viewModel.getData(year: yearString, month: monthString, day: dayString)
                 } catch {
                     
                 }
             }
             
             if monthPosition == .next || monthPosition == .previous {
                 calendar.setCurrentPage(date, animated: true)
             }
         }
    }
}

struct CaalenderRepresentable : UIViewRepresentable {
    var lang = Locale.current.language.languageCode!.identifier
    var constants = Constants()
    typealias UIViewType = FSCalendar
    var calendar = FSCalendar()
    @Binding var selectedDate : Date?
    @ObservedObject var viewModel: SchudleTimeVm

    let isDark = UserDefaultss().restoreBool(key: "isDark")

    
    func updateUIView(_ uiView: FSCalendar, context: Context) {
        uiView.select(viewModel.selectedDate)
    }
    
    
    func makeUIView(context: Context) -> FSCalendar {
        
        calendar.delegate = context.coordinator
        calendar.dataSource = context.coordinator
        calendar.scope = .week
        calendar.appearance.todayColor = Colors().buttonGreenColorLight
        calendar.appearance.selectionColor = Colors().mainColor
        calendar.appearance.titleTodayColor = .white
        calendar.appearance.titleDefaultColor = isDark ? .white : .black
        calendar.appearance.headerTitleColor = isDark ? .white : .black
    
        if self.lang == self.constants.APP_IOS_LANGUAGE_AR {
            self.calendar.appearance.weekdayFont = UIFont(name: Fonts().getFontBold(), size: 16)
            self.calendar.appearance.titleFont = UIFont(name: Fonts().getFontBold(), size: 16)
            self.calendar.appearance.subtitleFont = UIFont(name: Fonts().getFontBold(), size: 16)
            self.calendar.appearance.headerTitleFont = UIFont(name: Fonts().getFontBold(), size: 16)
        } else {
            self.calendar.appearance.weekdayFont = UIFont(name: Fonts().english_cairo_variable, size: 16)
            self.calendar.appearance.titleFont = UIFont(name: Fonts().english_cairo_variable, size: 16)
            self.calendar.appearance.subtitleFont = UIFont(name: Fonts().english_cairo_variable, size: 16)
            self.calendar.appearance.headerTitleFont = UIFont(name: Fonts().english_cairo_variable, size: 16)
        }


        return calendar
    }
    
  
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject , FSCalendarDelegate,FSCalendarDataSource {
        var parent : CaalenderRepresentable

        
        init(_ parent : CaalenderRepresentable) {
            self.parent = parent
        }
        
         func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
             
             
             parent.selectedDate = date
             parent.viewModel.selectedDate = date
             
             let calendarr = Calendar.current
             let components = calendarr.dateComponents([.day,.month,.year], from: date)
             if let day = components.day, let month = components.month, let year = components.year {
                 let dayString = String(day)
                 let monthString = String(month)
                 let yearString = String(year)

                 self.parent.viewModel.day = dayString
                 self.parent.viewModel.month = monthString
                 self.parent.viewModel.year = yearString
                 UserDefaultss().saveStrings(value: dayString, key: "day")
                 UserDefaultss().saveStrings(value: monthString, key: "month")
                 UserDefaultss().saveStrings(value: yearString, key: "year")
                 self.parent.viewModel.token = ""
                 self.parent.viewModel.educationalGroupScheduleTimes = []
                
                 do {
                     try self.parent.viewModel.getData(year: yearString, month: monthString, day: dayString,calenderSearchType: "CST-1" ,groupToken: UserDefaultss().restoreString(key: "groupToken"))
                 } catch {
                     
                 }
             }
             
             if monthPosition == .next || monthPosition == .previous {
                 calendar.setCurrentPage(date, animated: true)
             }
         }
    }
}
