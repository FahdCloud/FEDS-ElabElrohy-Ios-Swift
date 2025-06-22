//
//  Home.swift
//  FPLS-Dev
//
//  Created by Omar pakr on 03/09/2023.
//

import SwiftUI
import AxisTabView
import AxisTooltip

@available(iOS 16.0, *)
struct StudentHome: View {
    @StateObject var eductaionGroupTimeVm : EducationGroupTimeVm = EducationGroupTimeVm()
    @StateObject var userAppSettingVm : AppSettingVm = AppSettingVm()
    @StateObject var genralVm : GeneralVm = GeneralVm()
    
    @State private var educationalGroupScheduleTimesDetails : EducationalSchuldeTimes = EducationalSchuldeTimes()

    @State private var selectedDate : Date = Date()
    @State private var onlyOneCategory : Bool = true
    @State private var showTimes : Bool = false
    @State private var showHome : Bool = false
    @State private var showMedia : Bool = false
    @State private var showExams : Bool = false
    
    @State private var isPresentedWarningStatus1 : Bool = false
    @State private var isPresentedWarningStatus2 : Bool = false
    @State private var isPresentedWarningStatus3 : Bool = false
    @State private var isPresentedWarningStatus4 : Bool = false
    @State private var isPresentedWarningStatus5 : Bool = false
    @State private var isPresentRateNotes : Bool = false
    
    @State private var expandedGroups: Set<String> = []
    @State private var expandedTime: Set<String> = []

    
    let row = GridItem(.fixed(50), spacing: 5, alignment: .center)
    let columns = [GridItem(.fixed(10))]
    var educationalGroupScheduleTimes = [UserEducationalGroupScheduleTimesDatum]()
    var userName = UserDefaultss().restoreString(key: "userNameCurrent")
    var imageUrl = UserDefaultss().restoreString(key: "userImageUrl")
    var day = UserDefaultss().restoreString(key: "day")
    var month = UserDefaultss().restoreString(key: "month")
    var year = UserDefaultss().restoreString(key: "year")
    @State var educationalGroupScheduleTimeToken : String = ""
    
    
    let alignments: [Alignment] = [.center, .leading, .trailing, .top, .bottom, .topLeading, .topTrailing, .bottomLeading, .bottomTrailing]
        
    var body: some View {
           ZStack{
                if eductaionGroupTimeVm.isLoading {
                    LoadingView(placHolder: NSLocalizedString("loading", comment: ""))
                } else {
                    VStack(spacing:1){
                        StudentHomeHeaderView(name: self.userName , imageUrl: self.imageUrl)
                            
                        Divider()
                        StudentHomeShortcutList()
                            .frame(height: 100)
                        
                        CalenderRepresentable(selectedDate: $eductaionGroupTimeVm.selectedDate,viewModel:eductaionGroupTimeVm)
                        
                        GeometryReader { geometry in
                            
                            ZStack {
                                if eductaionGroupTimeVm.noData {
                                    NoContent(message: self.eductaionGroupTimeVm.msg)
                                } else {
                                    ScrollView {
                                        VStack{
                                            VStack(spacing: -30){
                                                Text(NSLocalizedString("category", comment: ""))
                                                    .font(
                                                        Font.custom(Fonts().getFontBold(), size: 20)
                                                            .weight(.bold)
                                                    )
                                                    .minimumScaleFactor(0.5)
                                                    .multilineTextAlignment(.trailing)
                                                    .foregroundColor(Color(red: 0.26, green: 0.25, blue: 0.69))
                                                    .frame(width: .infinity, alignment: .center)
                                                
                                                educationCategorySection
                                                
                                            }
                                            
                                            educationGroup
                                                .offset(y:-50)
                                                .frame(height: 300)
                                        }
                                        
                                    }
                                }
                            }
                            .padding()
                            .frame(width: geometry.size.width, height: geometry.size.width) // Use the geometry for sizing
                            .offset(y:-100)
                        }
                    }
                }
            }
            .background(genralVm.isDark ? Color(Colors().darkBodyBg): Color(Colors().lightBodyBg))
            .ipad()
            .onAppear(perform: {
                UserDefaultss().removeObject(forKey: "userProviderToken")
                UserDefaultss().removeObject(forKey: "calendarSearchType")
                userAppSettingVm.getAppSettings()
            })
            .refreshable {
                UserDefaultss().removeObject(forKey: "userProviderToken")
                UserDefaultss().removeObject(forKey: "calendarSearchType")
                userAppSettingVm.getAppSettings()
            }
            .overlay(
                eductaionGroupTimeVm.isLoading ?
                GeometryReader { geometry in
                    ZStack {
                        LoadingView(placHolder: NSLocalizedString("loading", comment: ""))
                            .frame(width: geometry.size.width, height: geometry.size.height)
                            .transition(.scale)
                    } } : nil
            )
            .fullScreenCover(isPresented: $eductaionGroupTimeVm.showLogOut, content: {
                RegistrationView()
            })
           
            .fullScreenCover(isPresented: $showMedia) {
                let token = UserDefaultss().restoreString(key: "educationalGroupScheduleTimeToken")
                AttatchmentsView(groupTimeToken:token)
                    .environmentObject(ScreenshotDetector())
                    .environmentObject(ScreenRecordingDetector())
            }
            .fullScreenCover(isPresented: $showExams) {
                let token = UserDefaultss().restoreString(key: "educationalGroupScheduleTimeToken")
                myScheduleHomework()
            }
            .onDisappear {
                clearStatesWithAction(valueState: &genralVm.dissapearView)
            }
        
    }
    
    var educationCategorySection : some View {
        
        ScrollView(.horizontal,showsIndicators: false) {
            LazyHGrid(rows: [row]) {
                ForEach(eductaionGroupTimeVm.educationalGroupScheduleTimes ,id: \.educationalGroupScheduleTimeToken){ catrgory in
                    HStack (spacing: 50){
                        VStack(alignment: .center, spacing: 10) {
                            
                            AsyncImage(url: URL(string: catrgory.educationalCategoryInfoData?.educationalCategoryImageUrl ?? "")) { phase in
                                if let image = phase.image {
                                    
                                    image
                                        .resizable()
                                        .frame(width: 52,height: 52)
                                        .padding(10)
                                        .frame(width: 52, height: 52, alignment: .center)
                                        .background( self.eductaionGroupTimeVm.onlyOneCategory ? Color(Colors().mainColor) : .white)
                                        .cornerRadius(12)
                                        .shadow(color: .black.opacity(0.25), radius: 2, x: 0, y: 1)
                                    
                                } else if phase.error != nil {
                                    Image("picture")
                                        .resizable()
                                        .frame(width: 52,height: 52)
                                        .padding(10)
                                        .frame(width: 52, height: 52, alignment: .center)
                                        .background( self.eductaionGroupTimeVm.onlyOneCategory ? Color(Colors().mainColor) : .white)
                                        .cornerRadius(12)
                                        .shadow(color: .black.opacity(0.25), radius: 2, x: 0, y: 1)
                                } else {
                                    ProgressView()
                                        .frame(width: 52,height: 52)
                                        .padding(10)
                                        .frame(width: 52, height: 52, alignment: .center)
                                        .background(.white)
                                        .cornerRadius(12)
                                        .shadow(color: .black.opacity(0.25), radius: 2, x: 0, y: 1)
                                    
                                }
                            }
                            
                            
                            //                            .offset(x:8)
                            
                            
                            Text(catrgory.educationalCategoryInfoData?.educationalCategoryNameCurrent ?? "")
                                .font(
                                    Font.custom(Fonts().getFontBold(), size: 14)
                                        .weight(.bold)
                                )
                                .multilineTextAlignment(.trailing)
                                .foregroundColor(Color(red: 0.99, green: 0.58, blue: 0.01))
                                .frame(width: .infinity, alignment: .center)
                        }
                        .padding()
                        //                        .onTapGesture {
                        //                            self.eductaionGroupTimeVm.token = catrgory.educationalCategoryToken ?? ""
                        //                            do {
                        //                                try self.eductaionGroupTimeVm.getData(year: self.year, month: self.month, day:self.day)
                        //
                        //                            } catch {
                        //                             print("error")
                        //                            }
                        //                        }
                    }
                    .padding()
                }
            }
            .padding()
            .padding(.leading,90)
        }
        .padding()
    }
    
    var educationGroup : some View  {
        ZStack{
            
            List {
                ForEach(eductaionGroupTimeVm.educationalGroupScheduleTimes,id: \.educationalGroupScheduleTimeToken) { scheduleTime in
                    
                    DisclosureGroup(
                        isExpanded: .constant(expandedTime.contains(scheduleTime.educationalGroupScheduleTimeToken ?? "")), // You can manage expansion state here
                        content: {
                            VStack (spacing:45){
                                HStack (spacing:10){
                                    if genralVm.havePermissionToView {
                                        VStack {
                                            Image("homework")
                                                .resizable()
                                                .frame(width: 30,height: 30)
                                            
                                            
                                            Text(NSLocalizedString("homework", comment: ""))
                                                .font(
                                                    Font.custom(Fonts().getFontBold(), size: 14)
                                                        .weight(.bold)
                                                )
                                        }
                                        .onTapGesture(perform: {
                                            UserDefaultss().saveStrings(value: scheduleTime.educationalGroupScheduleTimeToken ?? "", key: "educationalGroupScheduleTimeToken")
                                            clearStatesWithAction(valueState: &showExams)
                                        })
                                        .frame(width: 80,height: 40)
                                        .padding()
                                        .background(genralVm.isDark ? Color(Colors().darkCardWalletBg): Color(Colors().lightCardWalletBg))
                                        .cornerRadius(10)
                                    }
                                    
                                    VStack {
                                        Image("folder 1")
                                            .resizable()
                                            .frame(width: 30,height: 30)
                                        
                                        Text(NSLocalizedString("mediaa", comment: ""))
                                            .font(
                                                Font.custom(Fonts().getFontBold(), size: 14)
                                                    .weight(.bold)
                                            )
                                    }
                                    .onTapGesture(perform: {
                                        UserDefaultss().saveStrings(value: scheduleTime.educationalGroupScheduleTimeToken ?? "", key: "educationalGroupScheduleTimeToken")
                                        clearStatesWithAction(valueState: &showMedia)
                                    })
                                    .frame(width: 80,height: 40)
                                    .padding()
                                    .background(genralVm.isDark ? Color(Colors().darkCardWalletBg): Color(Colors().lightCardWalletBg))
                                    .cornerRadius(10)
                                    
                                    if scheduleTime.zoomMeetingToken != nil {
                                        VStack {
                                            Image("zoom_icon")
                                                .resizable()
                                                .frame(width: 30,height: 30)
                                            
                                            Text(NSLocalizedString("zoom", comment: ""))
                                                .font(
                                                    Font.custom(Fonts().getFontBold(), size: 14)
                                                        .weight(.bold)
                                                )
                                        }
                                        .onTapGesture(perform: {
                                            //                                                UIApplication.tryURL(url:(scheduleTime.zoomMeetingData.joinUrl ?? ""))
                                        })
                                        .frame(width: 80,height: 40)
                                        .padding()
                                        .background(Color.gray)
                                        .cornerRadius(10)
                                    }
                                }
                                .offset(x:-15)
                                
                                RateView(rating: .constant(Int(scheduleTime.attendanceRate ?? 0.0)))
                                
                                    .onTapGesture {
                                        if scheduleTime.attendanceRateNotes != "" {

                                            isPresentRateNotes.toggle()
                                        }
                                    }
                                    .axisToolTip(isPresented: $isPresentRateNotes, alignment: alignments[3], constant:.init(axisMode:ATAxisMode.top), foreground: {
                                        Text(scheduleTime.attendanceRateNotes ?? "")
                                            .padding()
                                            .lineLimit(5)
                                            .multilineTextAlignment(.center)
                                            .frame(width: 130,height:.infinity,alignment:.center)
                                    })
                                
                                HStack(spacing:30) {
                                    Rectangle()
                                        .fill((scheduleTime.attendanceStudentWarningData?.warningStatus1 ?? false) ? .red : .gray)
                                        .frame(width: 30, height: 30, alignment: .center)
                                        .onTapGesture {
                                            if scheduleTime.attendanceStudentWarningData?.warningStatus1 == true {
                                                isPresentedWarningStatus1.toggle()
                                            }
                                        }
                                        .axisToolTip(isPresented: $isPresentedWarningStatus1, alignment: alignments[3], constant:.init(axisMode:ATAxisMode.top), foreground: {
                                            Text(scheduleTime.attendanceStudentWarningData?.warningNotes1 ?? "")
                                                .padding()
                                                .lineLimit(5)
                                                .multilineTextAlignment(.center)
                                                .frame(width: 130,height:.infinity,alignment:.center)
                                        })
                                    
                                    
                                    Rectangle()
                                        .fill((scheduleTime.attendanceStudentWarningData?.warningStatus2 ?? false) ? .red : .gray)
                                        .frame(width: 30, height: 30, alignment: .center)
                                        .onTapGesture {
                                            if scheduleTime.attendanceStudentWarningData?.warningStatus2 == true {
                                                isPresentedWarningStatus2.toggle()
                                            }
                                        }
                                        .axisToolTip(isPresented: $isPresentedWarningStatus2, alignment: alignments[3], constant:.init(axisMode:ATAxisMode.top), foreground: {
                                            Text(scheduleTime.attendanceStudentWarningData?.warningNotes2 ?? "")
                                                .padding()
                                                .lineLimit(5)
                                                .multilineTextAlignment(.center)
                                                .frame(width: 130,height:.infinity,alignment:.center)
                                        })
                                    
                                    
                                    Rectangle()
                                        .fill((scheduleTime.attendanceStudentWarningData?.warningStatus3 ?? false) ? .red : .gray)
                                        .frame(width: 30, height: 30, alignment: .center)
                                        .onTapGesture {
                                            if scheduleTime.attendanceStudentWarningData?.warningStatus3 == true {
                                                isPresentedWarningStatus3.toggle()
                                            }
                                        }
                                        .axisToolTip(isPresented: $isPresentedWarningStatus3, alignment: alignments[3], constant:.init(axisMode:ATAxisMode.top), foreground: {
                                            Text(scheduleTime.attendanceStudentWarningData?.warningNotes3 ?? "")
                                                .padding()
                                                .lineLimit(5)
                                                .multilineTextAlignment(.center)
                                                .frame(width: 130,height:.infinity,alignment:.center)
                                        })
                                    
                                    
                                    Rectangle()
                                        .fill((scheduleTime.attendanceStudentWarningData?.warningStatus4 ?? false) ? .red : .gray)
                                        .frame(width: 30, height: 30, alignment: .center)
                                        .onTapGesture {
                                            if scheduleTime.attendanceStudentWarningData?.warningStatus4 == true {
                                                isPresentedWarningStatus4.toggle()
                                            }
                                        }
                                        .axisToolTip(isPresented: $isPresentedWarningStatus4, alignment: alignments[3], constant:.init(axisMode:ATAxisMode.top), foreground: {
                                            Text(scheduleTime.attendanceStudentWarningData?.warningNotes4 ?? "")
                                                .padding()
                                                .lineLimit(5)
                                                .multilineTextAlignment(.center)
                                                .frame(width: 130,height:.infinity,alignment:.center)
                                        })
                                    
                                    
                                    Rectangle()
                                        .fill((scheduleTime.attendanceStudentWarningData?.warningStatus5 ?? false) ? .red : .gray)
                                        .frame(width: 30, height: 30, alignment: .center)
                                        .onTapGesture {
                                            if scheduleTime.attendanceStudentWarningData?.warningStatus5 == true {
                                                isPresentedWarningStatus5.toggle()
                                            }
                                        }
                                        .axisToolTip(isPresented: $isPresentedWarningStatus5, alignment: alignments[3], constant:.init(axisMode:ATAxisMode.top), foreground: {
                                            Text(scheduleTime.attendanceStudentWarningData?.warningNotes5 ?? "")
                                                .padding()
                                                .lineLimit(5)
                                                .multilineTextAlignment(.center)
                                                .frame(width: 130,height:.infinity,alignment:.center)
                                        })
                                    
                                }
                                
                            }
                            
                            .listRowBackground(Color(.clear))
                        },
                        label: {
                            ZStack{
                                
                                VStack {
                                    HStack(spacing : 130){
                                        HStack (spacing:10){
                                            Image("closed_book")
                                                .resizable()
                                                .frame(width: 24,height: 24)
                                            
                                            Text(scheduleTime.educationalCategoryInfoData?.educationalCategoryNameCurrent ?? "")
                                                .foregroundColor(genralVm.isDark ? Color(Colors().darkCardText): Color(Colors().lightCardText))
                                                .font(
                                                    Font.custom(Fonts().getFontBold(), size: 15)
                                                        .weight(.bold)
                                                )
                                        }
                                        
                                        
                                        HStack (spacing:10){
                                            Image("clocc")
                                                .resizable()
                                                .frame(width: 24,height: 24)
                                            
                                            Text(scheduleTime.dateTimeFromTime ?? "")
                                                .foregroundColor(genralVm.isDark ? Color(Colors().darkCardText): Color(Colors().lightCardText))
                                                .font(
                                                    Font.custom(Fonts().getFontBold(), size: 15)
                                                        .weight(.bold)
                                                )
                                        }
                                    }
                                    .frame(maxWidth: .infinity)
                                    
                                    HStack(spacing : 60){
                                        HStack (spacing:10){
                                            Image("lecture")
                                                .resizable()
                                                .frame(width: 24,height: 24)
                                            
                                            
                                            Text(scheduleTime.userServiceProviderInfoData?.userNameCurrent ?? "")
                                                .foregroundColor(genralVm.isDark ? Color(Colors().darkCardText): Color(Colors().lightCardText))
                                                .font(
                                                    Font.custom(Fonts().getFontBold(), size: 15)
                                                        .weight(.bold)
                                                )
                                                .lineLimit(1)
                                        }
                                        
                                        HStack (spacing:10){
                                            Image("duration")
                                                .resizable()
                                                .frame(width: 24,height: 24)
                                            
                                            
                                            Text(DateTime.formatTime(scheduleTime.durationCurrent ?? ""))
                                                .foregroundColor(genralVm.isDark ? Color(Colors().darkCardText): Color(Colors().lightCardText))
                                                .font(
                                                    Font.custom(Fonts().getFontBold(), size: 15)
                                                        .weight(.bold)
                                                )
                                            
                                        }
                                    }
                                }
                                .overlay(
                                    Image(scheduleTime.attendanceTypeToken == Constants().ATTENDANCE_TYPE_ATTEND ? "right" : "wrong")
                                        .resizable()
                                        .frame(width: 20, height: 20) // Set the size of your image as needed
                                        .padding(.top, -25)
                                        .padding(.trailing, -40),
                                    alignment: .topTrailing
                                )
                                .foregroundColor(.white)
                                .onTapGesture {
                                    withAnimation(.easeInOut){
                                        toggleScheduleTimeExpansion(time: scheduleTime)
                                    }
                                }
                            }
                        }
                    )
                    .listRowBackground(genralVm.isDark ? Color(Colors().darkCardBg): Color(Colors().lightCardBg))
                    
                }
                .padding()
            }
            .frame(width:430)
            .refreshable {
                do {
                    try self.eductaionGroupTimeVm.getData(year: self.year, month: self.month, day:self.day)
                } catch {
                    
                }
            }
        }
    }
    
    private func toggleScheduleTimeExpansion(time: UserEducationalGroupScheduleTimesDatum) {
        if expandedTime.contains(time.educationalGroupScheduleTimeToken ?? "") {
            expandedTime.remove(time.educationalGroupScheduleTimeToken ?? "")
        } else {
            self.expandedTime.removeAll()
            expandedTime.insert(time.educationalGroupScheduleTimeToken ?? "")
        }
    }
    
    
    private func clearStatesWithAction(valueState: inout Bool) {
        valueState.toggle()
        showHome = false
        showExams = false
        showMedia = false
    }
}

struct CellView: View {
    var item: EducationalGroup
    
    var body: some View {
        HStack {
            Text(item.educationalGroupNameCurrent ?? "")
            
            HStack{
                
                Image("time")
                
                
                Text("\(item.educationalSchuldeTimes?.count ?? 0)" + " م " )
                
            }
        }
    }
}
