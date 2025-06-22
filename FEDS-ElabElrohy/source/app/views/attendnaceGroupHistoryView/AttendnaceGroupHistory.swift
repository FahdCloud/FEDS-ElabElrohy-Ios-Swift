//
//  AttendnaceGroupHistory.swift
//  FEDS-Center-Dev
//
//  Created by Omar pakr on 30/12/2023.
//

import SwiftUI
import AxisTooltip

@available(iOS 16.0, *)
struct AttendnaceGroupHistory: View {
    @State var educationalGroupScheduleTime : UserEducationalGroupScheduleTimesDatum = UserEducationalGroupScheduleTimesDatum()
    @StateObject var shcudelTimesVm : SchudleTimeVm = SchudleTimeVm()
    @StateObject var genralVm : GeneralVm = GeneralVm()

    let groupName : String
    let groupToken : String
    @State private var selectedType: String = ""
    @State private var selectedTypeToken: String = ""
    @State private var backFromAttendnaceGroup: Bool = false
    @State private var showDetails: Bool = false
    @State private var showRegFromAttendnaceHistory: Bool = false
    let options = [NSLocalizedString("monthly", comment: ""), NSLocalizedString("daily", comment: "")]
  let alignments: [Alignment] = [.center, .leading, .trailing, .top, .bottom, .topLeading, .topTrailing, .bottomLeading, .bottomTrailing]
    @State private var isPresentedWarningStatus1 : Bool = false
    @State private var isPresentedWarningStatus2 : Bool = false
    @State private var isPresentedWarningStatus3 : Bool = false
    @State private var isPresentedWarningStatus4 : Bool = false
    @State private var isPresentedWarningStatus5 : Bool = false
    @State private var isPresentRateNotes : Bool = false
    @State private var showGroupDetails : Bool = false
    
    let educationCategoryInfoData : EducationalCategoryInfoDataa
    let userProviderInfoData : UserServiceProviderInfoData
    let educationalGroupInfoData : EducationalGroupInfoDataa

    var body: some View {
        ZStack(alignment:.top) {
        NavigationView {
            VStack {
                HStack {
                    Text(NSLocalizedString("wayToAppear", comment: ""))
                        .font(
                            Font.custom(Fonts().getFontBold(), size: 15)
                                .weight(.bold)
                        )
                        .multilineTextAlignment(.center)
                        .lineLimit(5)
                    
                    HStack {
                        ForEach(options, id: \.self) { option in
                            CustomRadioButton(text: option, isSelected: option == selectedType) {
                                selectedType = option
                                if option == "Daily" {
                                    self.selectedTypeToken = "daily"
                                    shcudelTimesVm.educationalGroupScheduleTimes = []
                                } else if option == "Monthly" {
                                    self.selectedTypeToken = "monthly"
                                    shcudelTimesVm.educationalGroupScheduleTimes = []
                                }
                                shcudelTimesVm.getDate(date: Date())

                                do {
                                    try shcudelTimesVm.getData(year: shcudelTimesVm.year, month: shcudelTimesVm.month, day: shcudelTimesVm.day,calenderSearchType:self.selectedType == NSLocalizedString("monthly", comment: "") ? "CST-3" : "CST-1" ,groupToken: UserDefaultss().restoreString(key: "groupToken"))
                                    } catch {
                                        
                                }
                            }
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .center)
                    
                    Image("info_icon")
                        .resizable()
                        .frame(width: 30,height: 30)
                        .onTapGesture {
                            showGroupDetails.toggle()
                        }
                }
                .padding()
                
                if self.selectedType == NSLocalizedString("monthly", comment: "") {
                                        
                    
                    Rectangle()
                        .fill(genralVm.isDark ? Color.black : Color.white)
                        .overlay(alignment: .bottom, content: {
                            HStack {
                                HStack {
                                    Text("month")
                                        .font(
                                            Font.custom(Fonts().getFontBold(), size: 15)
                                                .weight(.bold)
                                        )
                                        .multilineTextAlignment(.center)
                                        .lineLimit(5)
                                        .frame(maxWidth:.infinity,alignment:.leading)
                                    
                                    Text("12")
                                        .font(
                                            Font.custom(Fonts().getFontBold(), size: 15)
                                                .weight(.bold)
                                        )
                                        .multilineTextAlignment(.center)
                                        .lineLimit(5)
                                    
                                }
                                .onTapGesture {
                                    
                                }
                                
                                Rectangle()
                                    .fill(genralVm.isDark ? .white : .black)
                                    .frame(width:45,height: 3)
                                    .rotationEffect(.degrees(90))
                                
                                HStack {
                                    Text(NSLocalizedString("year", comment: ""))
                                        .font(
                                            Font.custom(Fonts().getFontBold(), size: 15)
                                                .weight(.bold)
                                        )
                                        .multilineTextAlignment(.center)
                                        .lineLimit(5)
                                        .frame(maxWidth:.infinity,alignment:.leading)
                                    
                                    Text("2023")
                                        .font(
                                            Font.custom(Fonts().getFontBold(), size: 15)
                                                .weight(.bold)
                                        )
                                        .multilineTextAlignment(.center)
                                        .lineLimit(5)
                                    
                                    Image(systemName: "arrow.down")
                                        .resizable()
                                        .renderingMode(.original)
                                        .foregroundColor(.gray)
                                        .frame(width: 25, height: 20)
                                    
                                }
                                .onTapGesture {
                                    
                                }
                            }
                        })
                        .padding()
                        .border(Color.gray)
                        .padding()
                        .frame(height: 80)
                    if shcudelTimesVm.noData {
                        Spacer()

                        NoContent(message: shcudelTimesVm.msg)
                    }else{
                        Rectangle()
                            .fill(genralVm.isDark ? Color.black : Color.white)
                            .overlay(alignment: .top, content: {
                                ScrollView {
                                    VStack {
                                        HStack(spacing:80) {
                                            Text(NSLocalizedString("day", comment: ""))
                                                .font(
                                                    Font.custom(Fonts().getFontBold(), size: 15)
                                                        .weight(.bold)
                                                )
                                                .multilineTextAlignment(.center)
                                                .lineLimit(5)
                                                .frame(maxWidth:.infinity,alignment:.leading)
                                            
                                            
                                            Text(NSLocalizedString("duration", comment: ""))
                                                .font(
                                                    Font.custom(Fonts().getFontBold(), size: 15)
                                                        .weight(.bold)
                                                )
                                                .multilineTextAlignment(.center)
                                                .lineLimit(5)
                                            
                                            
                                            Text(NSLocalizedString("state", comment: ""))
                                                .font(
                                                    Font.custom(Fonts().getFontBold(), size: 15)
                                                        .weight(.bold)
                                                )
                                                .multilineTextAlignment(.center)
                                                .lineLimit(5)
                                                .frame(maxWidth:.infinity,alignment:.leading)
                                            
                                        }
                                        
                                        Rectangle()
                                            .fill(genralVm.isDark ? .white : .black)
                                            .frame(width:.infinity,height: 1)
                                        
                                        
                                        
                                        ForEach(shcudelTimesVm.educationalGroupScheduleTimes, id: \.educationalGroupScheduleTimeToken) { shcudelTime in
                                            
                                            VStack {
                                                HStack(spacing:30) {
                                                    HStack {
                                                        Image("calendar")
                                                        Text(shcudelTime.dateTimeFromCustomized ?? "")
                                                            .font(
                                                                Font.custom(Fonts().getFontBold(), size: 15)
                                                                    .weight(.bold)
                                                            )
                                                            .multilineTextAlignment(.center)
                                                            .lineLimit(5)
                                                            .frame(width:.infinity)
                                                            .frame(maxWidth:.infinity,alignment:.leading)
                                                    }
                                                    HStack {
                                                        Image("clocc")
                                                        Text(shcudelTime.durationCurrent ?? "")
                                                            .font(
                                                                Font.custom(Fonts().getFontBold(), size: 15)
                                                                    .weight(.bold)
                                                            )
                                                            .multilineTextAlignment(.center)
                                                            .frame(width:.infinity)
                                                            .frame(maxWidth:.infinity,alignment:.leading)
                                                            .lineLimit(5)
                                                    }
                                                    HStack {
                                                        Image("attendance")
                                                        Text(shcudelTime.attendanceTypeNameCurrent ?? "")
                                                            .font(
                                                                Font.custom(Fonts().getFontBold(), size: 15)
                                                                    .weight(.bold)
                                                            )
                                                            .multilineTextAlignment(.center)
                                                            .lineLimit(5)
                                                            .frame(width:.infinity)
                                                            .frame(maxWidth:.infinity,alignment:.leading)
                                                    }
                                                }
                                                Rectangle()
                                                    .fill(genralVm.isDark ? .white : .black)
                                                    .frame(width:.infinity,height: 1)
                                            }
                                            .onTapGesture {
                                                self.educationalGroupScheduleTime = shcudelTime
                                                showDetails.toggle()
                                            }
                                        }
                                        
                                        
                                    }
                                }
                            })
                            .padding()
                            .border(Color.gray)
                            .padding()
                    }
                } else {
                    CaalenderRepresentable(selectedDate: $shcudelTimesVm.selectedDate,viewModel:shcudelTimesVm)
                    if shcudelTimesVm.noData {
                        NoContent(message: shcudelTimesVm.msg)
                    }else{
                        Rectangle()
                            .fill(genralVm.isDark ? Color.black : Color.white)
                            .overlay(alignment: .top, content: {
                                ScrollView {
                                    VStack {
                                        HStack(spacing:80) {
                                            Text(NSLocalizedString("day", comment: ""))
                                                .font(
                                                    Font.custom(Fonts().getFontBold(), size: 15)
                                                        .weight(.bold)
                                                )
                                                .multilineTextAlignment(.center)
                                                .lineLimit(5)
                                                .frame(maxWidth:.infinity,alignment:.leading)
                                            
                                            
                                            Text(NSLocalizedString("duration", comment: ""))
                                                .font(
                                                    Font.custom(Fonts().getFontBold(), size: 15)
                                                        .weight(.bold)
                                                )
                                                .multilineTextAlignment(.center)
                                                .lineLimit(5)
                                            
                                            
                                            
                                            Text(NSLocalizedString("state", comment: ""))
                                                .font(
                                                    Font.custom(Fonts().getFontBold(), size: 15)
                                                        .weight(.bold)
                                                )
                                                .multilineTextAlignment(.center)
                                                .lineLimit(5)
                                                .frame(maxWidth:.infinity,alignment:.leading)
                                            
                                        }
                                        
                                        Rectangle()
                                            .fill(genralVm.isDark ? .white : .black)
                                            .frame(width:.infinity,height: 1)
                                        
                                        ForEach(shcudelTimesVm.educationalGroupScheduleTimes, id: \.educationalGroupScheduleTimeToken) { shcudelTime in
                                            
                                            VStack {
                                                HStack(spacing:30) {
                                                    HStack {
                                                        Image("calendar")
                                                        Text(shcudelTime.dateTimeFromCustomized ?? "")
                                                            .font(
                                                                Font.custom(Fonts().getFontBold(), size: 15)
                                                                    .weight(.bold)
                                                            )
                                                            .multilineTextAlignment(.center)
                                                            .lineLimit(5)
                                                            .frame(width:.infinity)
                                                            .frame(maxWidth:.infinity,alignment:.leading)
                                                    }
                                                    HStack {
                                                        Image("clocc")
                                                        Text(shcudelTime.durationCurrent ?? "")
                                                            .font(
                                                                Font.custom(Fonts().getFontBold(), size: 15)
                                                                    .weight(.bold)
                                                            )
                                                            .multilineTextAlignment(.center)
                                                            .frame(width:.infinity)
                                                            .frame(maxWidth:.infinity,alignment:.leading)
                                                            .lineLimit(5)
                                                    }
                                                    HStack {
                                                        Image("attendance")
                                                        Text(shcudelTime.attendanceTypeNameCurrent ?? "")
                                                            .font(
                                                                Font.custom(Fonts().getFontBold(), size: 15)
                                                                    .weight(.bold)
                                                            )
                                                            .multilineTextAlignment(.center)
                                                            .lineLimit(5)
                                                            .frame(width:.infinity)
                                                            .frame(maxWidth:.infinity,alignment:.leading)
                                                    }
                                                }
                                                Rectangle()
                                                    .fill(genralVm.isDark ? .white : .black)
                                                    .frame(width:.infinity,height: 1)
                                            }
                                            .onTapGesture {
                                                self.educationalGroupScheduleTime = shcudelTime
                                                showDetails.toggle()
                                            }
                                        }
                                    }
                                }
                            })
                            .padding()
                            .border(Color.gray)
                            .padding()
                            .fullScreenCover(isPresented: $backFromAttendnaceGroup, content: StudentGroupsTabView.init)
                            .offset(y:-200)
                        
                    }
                }
            }
           
            .navigationBarItems(leading: CustomBackButton(){
                clearStatesWithAction(valueState: &backFromAttendnaceGroup)
            })
            
            .navigationTitle(self.groupName)
            }
            
            if showDetails {
                ZStack(alignment:.bottom){
                   
                    RoundedRectangle(cornerRadius: 0)
                        .fill(genralVm.isDark ? Color.black : Color.white)
                        .overlay(alignment: .top, content: {
                            VStack {
                                RoundedRectangle(cornerRadius: 0)
                                    .fill(Color.green)
                                    .frame(height: 150)
                                    .overlay(
                                        HStack(spacing:50){
                                            Text(NSLocalizedString("infoo", comment: ""))
                                                .font (
                                                    Font.custom(Fonts().getFontBold(), size: 15)
                                                        .weight(.bold)
                                                )
                                                .multilineTextAlignment(.center)
                                            
                                            Image("File searching-pana")
                                                .resizable()
                                                .frame(width: 100, height: 100, alignment: .center)
                                        }
                                    )
                                
                                VStack {
                                    HStack {
                                        Text(NSLocalizedString("rate", comment: ""))
                                    }
                                        .font(
                                            Font.custom(Fonts().getFontBold(), size: 15)
                                                .weight(.bold)
                                        )
                                        .lineLimit(4)
                                        .multilineTextAlignment(.center)
                                        .frame(width: .infinity, height: .infinity, alignment: .leading)
                                    
                                    RateView(rating: .constant(Int(self.educationalGroupScheduleTime.attendanceRate ?? 0.0)))
                                    
                                        .onTapGesture {
                                            if self.educationalGroupScheduleTime.attendanceRateNotes == "" {
                                                isPresentRateNotes.toggle()
                                            }
                                        }
                                        .axisToolTip(isPresented: $isPresentRateNotes, alignment: alignments[3], constant:.init(axisMode:ATAxisMode.top), foreground: {
                                            Text(self.educationalGroupScheduleTime.attendanceRateNotes ?? "")
                                                .padding()
                                                .lineLimit(5)
                                                .multilineTextAlignment(.center)
                                                .frame(width: 130,height:.infinity,alignment:.center)
                                        })
                                    
                                    
                                }
                                
                                VStack {
                                    
                                    Text(NSLocalizedString("warning", comment: ""))
                                        .font(
                                            Font.custom(Fonts().getFontBold(), size: 15)
                                                .weight(.bold)
                                        )
                                        .lineLimit(4)
                                        .multilineTextAlignment(.center)
                                        .frame(width: .infinity, height: .infinity, alignment: .leading)
                                    
                                    HStack (spacing:30) {
                                        Rectangle()
                                            .fill((self.educationalGroupScheduleTime.attendanceStudentWarningData?.warningStatus1 ?? false) ? .red : .gray)
                                            .frame(width: 30, height: 30, alignment: .center)
                                            .onTapGesture {
                                                if self.educationalGroupScheduleTime.attendanceStudentWarningData?.warningStatus1 == true {
                                                    isPresentedWarningStatus1.toggle()
                                                }
                                            }
                                            .axisToolTip(isPresented: $isPresentedWarningStatus1, alignment: alignments[3], constant:.init(axisMode:ATAxisMode.top), foreground: {
                                                Text(self.educationalGroupScheduleTime.attendanceStudentWarningData?.warningNotes1 ?? "")
                                                    .padding()
                                                    .lineLimit(5)
                                                    .multilineTextAlignment(.center)
                                                    .frame(width: 130,height:.infinity,alignment:.center)
                                            })
                                        
                                        
                                        Rectangle()
                                            .fill((self.educationalGroupScheduleTime.attendanceStudentWarningData?.warningStatus2 ?? false) ? .red : .gray)
                                            .frame(width: 30, height: 30, alignment: .center)
                                            .onTapGesture {
                                                if self.educationalGroupScheduleTime.attendanceStudentWarningData?.warningStatus2 == true {
                                                    isPresentedWarningStatus2.toggle()
                                                }
                                            }
                                            .axisToolTip(isPresented: $isPresentedWarningStatus2, alignment: alignments[3], constant:.init(axisMode:ATAxisMode.top), foreground: {
                                                Text(self.educationalGroupScheduleTime.attendanceStudentWarningData?.warningNotes2 ?? "")
                                                    .padding()
                                                    .lineLimit(5)
                                                    .multilineTextAlignment(.center)
                                                    .frame(width: 130,height:.infinity,alignment:.center)
                                            })
                                        
                                        
                                        Rectangle()
                                            .fill((self.educationalGroupScheduleTime.attendanceStudentWarningData?.warningStatus3 ?? false) ? .red : .gray)
                                            .frame(width: 30, height: 30, alignment: .center)
                                            .onTapGesture {
                                                if self.educationalGroupScheduleTime.attendanceStudentWarningData?.warningStatus3 == true {
                                                    isPresentedWarningStatus3.toggle()
                                                }
                                            }
                                            .axisToolTip(isPresented: $isPresentedWarningStatus3, alignment: alignments[3], constant:.init(axisMode:ATAxisMode.top), foreground: {
                                                Text(self.educationalGroupScheduleTime.attendanceStudentWarningData?.warningNotes3 ?? "")
                                                    .padding()
                                                    .lineLimit(5)
                                                    .multilineTextAlignment(.center)
                                                    .frame(width: 130,height:.infinity,alignment:.center)
                                            })
                                        
                                        
                                        Rectangle()
                                            .fill((self.educationalGroupScheduleTime.attendanceStudentWarningData?.warningStatus4 ?? false) ? .red : .gray)
                                            .frame(width: 30, height: 30, alignment: .center)
                                            .onTapGesture {
                                                if self.educationalGroupScheduleTime.attendanceStudentWarningData?.warningStatus4 == true {
                                                    isPresentedWarningStatus4.toggle()
                                                }
                                            }
                                            .axisToolTip(isPresented: $isPresentedWarningStatus4, alignment: alignments[3], constant:.init(axisMode:ATAxisMode.top), foreground: {
                                                Text(self.educationalGroupScheduleTime.attendanceStudentWarningData?.warningNotes4 ?? "")
                                                    .padding()
                                                    .lineLimit(5)
                                                    .multilineTextAlignment(.center)
                                                    .frame(width: 130,height:.infinity,alignment:.center)
                                            })
                                        
                                        
                                        Rectangle()
                                            .fill((self.educationalGroupScheduleTime.attendanceStudentWarningData?.warningStatus5 ?? false) ? .red : .gray)
                                            .frame(width: 30, height: 30, alignment: .center)
                                            .onTapGesture {
                                                if self.educationalGroupScheduleTime.attendanceStudentWarningData?.warningStatus5 == true {
                                                    isPresentedWarningStatus5.toggle()
                                                }
                                            }
                                            .axisToolTip(isPresented: $isPresentedWarningStatus5, alignment: alignments[3], constant:.init(axisMode:ATAxisMode.top), foreground: {
                                                Text(self.educationalGroupScheduleTime.attendanceStudentWarningData?.warningNotes5 ?? "")
                                                    .padding()
                                                    .lineLimit(5)
                                                    .multilineTextAlignment(.center)
                                                    .frame(width: 130,height:.infinity,alignment:.center)
                                        })
                                    }
                                }
                            }
                        })
                        .frame(height: UIScreen.main.bounds.height * 0.40)
                        .transition(.move(edge: .top))
                        .animation(.spring())
                                         
                }
                .edgesIgnoringSafeArea(.bottom)
                .frame(maxWidth: .infinity,maxHeight: .infinity,alignment:.top)
                .background(
                    Color.black.opacity(0.35)
                        .onTapGesture(perform: {
                            clearStatesWithAction(valueState: &showDetails)
                        })
                )
            }
            
            if showGroupDetails {
                ZStack(alignment:.bottom){
                   
                    RoundedRectangle(cornerRadius: 0)
                        .fill(genralVm.isDark ? Color.black : Color.white)
                        .overlay(alignment: .top, content: {
                            VStack {
                                RoundedRectangle(cornerRadius: 0)
                                    .fill(Color.green)
                                    .frame(height: 150)
                                    .overlay(
                                        HStack(spacing:50){
                                            Text(NSLocalizedString("infoo", comment: ""))
                                                .font (
                                                    Font.custom(Fonts().getFontBold(), size: 15)
                                                        .weight(.bold)
                                                )
                                                .multilineTextAlignment(.center)
                                            
                                            Image("File searching-pana")
                                                .resizable()
                                                .frame(width: 100, height: 100, alignment: .center)
                                        }
                                    )
                                
                                VStack (alignment:.leading){
                                    HStack {
                                        Image("item_of_pages")
                                            .resizable()
                                            .frame(width: 30, height: 30, alignment: .center)
                                        Text(self.educationCategoryInfoData.educationalCategoryFullNameCurrent ?? "")
                                            .font(
                                                Font.custom(Fonts().getFontBold(), size: 14)
                                                    .weight(.bold)
                                            )
                                            .multilineTextAlignment(.center)
                                            .lineLimit(5)
                                    }
                                    .padding(.leading,10)
                                    
                                    HStack {
                                        Image("teacher-icon")
                                            .resizable()
                                            .frame(width: 30, height: 30, alignment: .center)
                                        Text(self.userProviderInfoData.userNameCurrent ?? "")
                                            .font(
                                                Font.custom(Fonts().getFontBold(), size: 14)
                                                    .weight(.bold)
                                            )
                                            .multilineTextAlignment(.center)
                                            .lineLimit(5)
                                    }
                                    .padding(.leading,10)

                                    
                                    HStack {
                                        
                                        HStack {
                                            Image("calendar")
                                                .resizable()
                                                .frame(width: 30, height: 30, alignment: .center)
                                            Text(self.educationalGroupInfoData.educationalGroupStatisticsInfoData?.educationalGroupStartDate ?? "")
                                                .font(
                                                    Font.custom(Fonts().getFontBold(), size: 14)
                                                        .weight(.bold)
                                                )
                                                .multilineTextAlignment(.center)
                                                .lineLimit(5)
                                        }

                                        Spacer()
                                        
                                        HStack {
                                            Image("calendar")
                                                .resizable()
                                                .frame(width: 30, height: 30, alignment: .center)
                                            Text(self.educationalGroupInfoData.educationalGroupStatisticsInfoData?.educationalGroupEndDate ?? "")
                                                .font(
                                                    Font.custom(Fonts().getFontBold(), size: 14)
                                                        .weight(.bold)
                                                )
                                                .multilineTextAlignment(.center)
                                                .lineLimit(5)
                                        }
                                    }
                                    .padding()
                                    
                                    HStack {
                                        
                                        HStack {
                                            Image("finance_pocket")
                                                .resizable()
                                                .frame(width: 30, height: 30, alignment: .center)
                                            Text(self.educationalGroupInfoData.sessionPriceWithCurrencyFroClient ?? "")
                                                .font(
                                                    Font.custom(Fonts().getFontBold(), size: 14)
                                                        .weight(.bold)
                                                )
                                                .multilineTextAlignment(.center)
                                                .lineLimit(5)
                                        }

                                        Spacer()
                                        
                                        HStack {
                                            Image("finance_pocket")
                                                .resizable()
                                                .frame(width: 30, height: 30, alignment: .center)
                                            Text(self.educationalGroupInfoData.durationPriceWithCurrencyFroClient ?? "")
                                                .font(
                                                    Font.custom(Fonts().getFontBold(), size: 14)
                                                        .weight(.bold)
                                                )
                                                .multilineTextAlignment(.center)
                                                .lineLimit(5)
                                        }
                                        
                                    }
                                    .padding()
                                }
                                .frame(maxWidth:.infinity)
                            }
                        })
                        .frame(height: UIScreen.main.bounds.height * 0.50)
                        .transition(.move(edge: .top))
                        .animation(.spring())
                                         
                }
                .edgesIgnoringSafeArea(.bottom)
                .frame(maxWidth: .infinity,maxHeight: .infinity,alignment:.top)
                .background(
                    Color.black.opacity(0.35)
                        .onTapGesture(perform: {
                            showGroupDetails.toggle()
                        })
                )
            }
        }
        .fullScreenCover(isPresented: $backFromAttendnaceGroup, content: {
            StudentGroupsTabView()
        })
        .fullScreenCover(isPresented: $shcudelTimesVm.showLogOut, content: {
            RegistrationView()
        })
        .overlay(
            shcudelTimesVm.isLoading ?
            GeometryReader { geometry in
                ZStack {
                    LoadingView(placHolder: NSLocalizedString("loading", comment: ""))
                        .frame(width: geometry.size.width, height: geometry.size.height)
                        .transition(.scale)
                } } : nil
        )
        .refreshable {
            self.selectedType = NSLocalizedString("monthly", comment: "")
            shcudelTimesVm.getDate(date: Date())
            do {
                try shcudelTimesVm.getData(year: shcudelTimesVm.year, month: shcudelTimesVm.month, day: shcudelTimesVm.day,calenderSearchType:self.selectedType == NSLocalizedString("monthly", comment: "") ? "CST-3" : "CST-1" ,groupToken: self.selectedType == NSLocalizedString("monthly", comment: "") ?   UserDefaultss().restoreString(key: "groupToken") : "")
                } catch {
                    
                }
        }
        .onAppear(perform: {
            self.selectedType = NSLocalizedString("monthly", comment: "")
            shcudelTimesVm.getDate(date: Date())
            do {
                try shcudelTimesVm.getData(year: shcudelTimesVm.year, month: shcudelTimesVm.month, day: shcudelTimesVm.day,calenderSearchType:self.selectedType == NSLocalizedString("monthly", comment: "") ? "CST-3" : "CST-1" ,groupToken: self.selectedType == NSLocalizedString("monthly", comment: "") ?   UserDefaultss().restoreString(key: "groupToken") : "")
                } catch {
                    
                }
        })
        .onDisappear(perform: {
            clearStatesWithAction(valueState: &genralVm.dissapearView)
        })
    }
    private func clearStatesWithAction(valueState: inout Bool) {
        valueState.toggle()
        backFromAttendnaceGroup = false
        showDetails = false
    }
}

