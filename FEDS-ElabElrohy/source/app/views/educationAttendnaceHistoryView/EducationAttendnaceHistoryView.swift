//
//  EducationAttendnaceHistoryView.swift
//  FPLS-Dev
//
//  Created by Omar Pakr on 17/04/2024.
//

import SwiftUI


@available(iOS 16.0, *)
struct EducationAttendnaceHistoryView: View {
    @StateObject var attendnaceHistoryVm : EducationAttendnaceHistoryVm = EducationAttendnaceHistoryVm()
    @StateObject var attendnaceHistoryVmm : EducationAttendnaceHistoryVmm = EducationAttendnaceHistoryVmm()
    @State var attendanceData : AttendanceStudentWarningData = AttendanceStudentWarningData()
    @StateObject var educationGroups : EducationalGroupsVm = EducationalGroupsVm()
    @StateObject var genralVm : GeneralVm = GeneralVm()

    @State private var backGeasture : Bool = false
    @State private var showWarnings : Bool = false
    @State private var showFilter : Bool = false
    @State private var showPassword : Bool = false
    @State private var selected : Int = 1
    @State private var monthly : String = ""
    @State private var fromDate : String = ""
    @State private var toDate : String = ""
    @State private var educationGroupSelected : String = ""
    @State private var educationGroupSelectedToken : String = ""
    @State private var selectedDateFrom = Date()
    @State private var selectedDateTo = Date()
    @State private var isDatePickerVisible = false
    @State private var showDatePicker = false
    @State private var educationGroup = false
    @State private var isMenuVisibleEducationalGroups = false
    @State private var dissapearView : Bool = false
    @FocusState var endEditingEducationGroups : Bool
    var dateFromFormmated :String?
    var dateToFormmated = ""
    @Environment(\.dismiss) private var dismiss
    @State private var expandedAttendenceHistory: Set<String> = []
    
    var dateFormatter: DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy/MM/dd"
         return dateFormatter
     }
    var body: some View {
        ZStack {
            
            NavigationView {
            
            if self.attendnaceHistoryVmm.noData {
                NoContent(message:attendnaceHistoryVmm.msg)
                    .gesture(
                        DragGesture()
                            .onChanged { gesture in
                                if gesture.translation.width < 0 {
                                    clearStatesWithAction(valueState: &backGeasture)
                                }
                            }
                    )
                    .ipad()
                    .navigationTitle(NSLocalizedString("attendnaceHistory", comment: ""))
                    .fullScreenCover(isPresented: $backGeasture, content: StudentMainTabView.init)
                    .navigationBarItems(trailing:
                                            Button(action: {
                        showFilter.toggle()
                    }, label: {
                        Image("filter")
                            .resizable()
                            .frame(width:30,height: 30)
                    })
                                                .sheet(isPresented: $showFilter) {
                                                    VStack (spacing : 50){
                                                        
                                                        HStack(spacing:50){
                                                            
                                                            Text(NSLocalizedString("selectSearchType",comment:""))
                                                            
                                                            Picker(selection: $selected, label: Text("")) {
                                                                Text(NSLocalizedString("monthly", comment: "")).tag(1)
                                                                Text(NSLocalizedString("monthly", comment: "")).tag(1)
                                                                Text(NSLocalizedString("interval", comment: "")).tag(2)
                                                            }
                                                            .pickerStyle(.automatic)
                                                        }
                                                        
                                                        VStack(spacing: -10){
                                                            VStack{
                                                                TextField("", text: $educationGroupSelected ,onEditingChanged: { isEditing in
                                                                    if isEditing {
                                                                        isMenuVisibleEducationalGroups = true
                                                                        self.endEditingEducationGroups = true
                                                                    }
                                                                })
                                                                .textFieldStyle(
                                                                    CustomTextFieldStyle(placeholder: NSLocalizedString("educationGroups", comment: ""), placeholderColor: .black, placeholderBgColor: .white,image: "groups", isPassword: false, isEditing: !self.educationGroupSelected.isEmpty, isTapped: $showPassword)
                                                                )
                                                                .focused($endEditingEducationGroups)
                                                            }
                                                            .popover(isPresented: $isMenuVisibleEducationalGroups, content: {
                                                                VStack {
                                                                    ZStack {
                                                                        if educationGroups.noData {
                                                                            NoContent(message: educationGroups.msg)
                                                                        } else {
                                                                            
                                                                            List {
                                                                                ForEach(educationGroups.educationalGroupData,id: \.educationalGroupToken) { group in
                                                                                    HStack (spacing: 10) {
                                                                                        CustomImageUrl(url: group.educationalGroupInfoData?.educationalGroupThumbnailImageUrl ?? "")
                                                                                        
                                                                                        Text(group.educationalGroupInfoData?.educationalGroupNameCurrent ?? "")
                                                                                        Spacer()
                                                                                    }
                                                                                    .onTapGesture {
                                                                                        self.educationGroupSelected = group.educationalGroupInfoData?.educationalGroupNameCurrent ?? ""
                                                                                        self.educationGroupSelectedToken = group.educationalGroupInfoData?.educationalGroupToken ?? ""
                                                                                        self.isMenuVisibleEducationalGroups.toggle()
                                                                                        self.endEditingEducationGroups = false
                                                                                    }
                                                                                    .padding()
                                                                                }
                                                                                .listStyle(.insetGrouped)
                                                                            }
                                                                        }
                                                                        
                                                                        if educationGroups.isLoading {
                                                                            LoadingView(placHolder: NSLocalizedString("loading", comment: ""))
                                                                        }
                                                                    }
                                                                }
                                                                .onAppear {
                                                                    educationGroups.getEducationGroups(finishedToken: genralVm.constants.GROUPS_UN_FINISHED)
                                                                }
                                                            })
                                                            .padding()
                                                                                                                        
                                                        }
                                                        
                                                        if self.selected == 1 {
                                                            
                                                            VStack {
                                                                TextField("", text: $monthly)
                                                                    .textFieldStyle (
                                                                        CustomTextFieldStyle(placeholder: NSLocalizedString("month", comment: ""), placeholderColor: .black, placeholderBgColor: .white,image: "calendar", isPassword: false, isEditing: !self.monthly.isEmpty, isTapped: $showPassword)
                                                                    )
                                                                    .keyboardType(.phonePad)
                                                            }
                                                            .padding()
                                                            
                                                        } else if self.selected == 2 {
                                                            
                                                            HStack {
                                                                VStack{
                                                                    TextField("", text: Binding(
                                                                        get: { self.dateFormatter.string(from: selectedDateFrom) },
                                                                        set: { text in
                                                                            fromDate = DateTime.formatApiDate(date: text)
                                                                        }
                                                                    ))
                                                                    .onTapGesture {
                                                                        self.showDatePicker = true
                                                                    }
                                                                    .popover(isPresented: $showDatePicker, arrowEdge: .bottom) {
                                                                        DatePicker("", selection: $selectedDateFrom, displayedComponents: .date)
                                                                            .datePickerStyle(GraphicalDatePickerStyle())
                                                                            .frame(maxHeight: 400)
                                                                    }
                                                                    
                                                                    .textFieldStyle(
                                                                        CustomTextFieldStyle(placeholder: NSLocalizedString("dateFrom", comment: ""), placeholderColor: .black, placeholderBgColor: .white,image: "calendar", isPassword: false, isEditing: !self.fromDate.isEmpty, isTapped: $showPassword)
                                                                    )
                                                                }
                                                                VStack{
                                                                    TextField("", text: Binding(
                                                                        get: { self.dateFormatter.string(from: selectedDateTo) },
                                                                        set: { text in
                                                                            toDate = DateTime.formatApiDate(date: text)
                                                                        }
                                                                    ))
                                                                    .onTapGesture {
                                                                        self.isDatePickerVisible = true
                                                                    }
                                                                    .popover(isPresented: $isDatePickerVisible, arrowEdge: .bottom) {
                                                                        DatePicker("Select Date", selection: $selectedDateTo, displayedComponents: .date)
                                                                            .datePickerStyle(GraphicalDatePickerStyle())
                                                                            .frame(maxHeight: 400)
                                                                    }
                                                                    
                                                                    .textFieldStyle(
                                                                        CustomTextFieldStyle(placeholder: NSLocalizedString("month", comment: ""), placeholderColor: .black, placeholderBgColor: .white,image: "calendar", isPassword: false, isEditing: !self.monthly.isEmpty, isTapped: $showPassword)
                                                                    )
                                                                }
                                                                .padding()
                                                            }
                                                            .padding()
                                                        }
                                                        
                                                        HStack(alignment: .center, spacing: 5) {
                                                            
                                                            Button {
                                                                if self.selected == 1 {
                                                                    attendnaceHistoryVmm.month = DateTime.replaceCharcaterToEnglish(value: self.monthly)
                                                                    do {
                                                                        try attendnaceHistoryVmm.getData(calenderSearchType: genralVm.constants.CALENDER_SEARCH_TYPE_TOKEN_SIMPOL_MONTH,educationalGroupToken:self.educationGroupSelectedToken)
                                                                    } catch {
                                                                        
                                                                    }
                                                                    
                                                                } else if self.selected == 2 {
                                                                    let formattedDateFrom = dateFormatter.string(from: selectedDateFrom)
                                                                    let formattedDateTo = dateFormatter.string(from: selectedDateTo)
                                                                    do {
                                                                        try attendnaceHistoryVmm.getData(calenderSearchType: genralVm.constants.CALENDER_SEARCH_TYPE_TOKEN_SIMPOL_CUSTOIZE,dateTimeStartSearch: formattedDateFrom,dateTimeEndSearch:formattedDateTo,educationalGroupToken:self.educationGroupSelectedToken)
                                                                    } catch {
                                                                        
                                                                    }
                                                                }
                                                                
                                                            } label: {
                                                                Text(NSLocalizedString("search", comment: ""))
                                                                    .font(
                                                                        Font.custom(Fonts().getFontBold(), size: 15)
                                                                            .weight(.bold)
                                                                    )
                                                                    .foregroundColor(Color(red: 0.9, green: 0.88, blue: 0.91))
                                                            }
                                                        }
                                                        
                                                        .padding(.horizontal, 82)
                                                        .padding(.vertical, 16)
                                                        .frame(width: 234, height: 58, alignment: .center)
                                                        .background(Color(Colors().mainButtonColor.cgColor))
                                                        .cornerRadius(10)
                                                    }
                                                    
                                                    //                                                    .presentationDetents([.medium])
                                                }
                    )
                    .navigationBarItems(leading: CustomBackButton(){
                        clearStatesWithAction(valueState: &backGeasture)
                    })
                    .ipad()
            } else {
                
                    ZStack {
                        ZStack {
                            List {
                                ForEach(attendnaceHistoryVmm.educationalGroupScheduleTimes, id: \.educationalGroupScheduleTimeToken) { att in
                                    
                                    DisclosureGroup {
                                        
                                        VStack (spacing:10) {
                                            HStack (spacing:80){
                                                VStack(alignment: .leading) {
                                                    
                                                    Text(att.educationalGroupInfoData?.educationalGroupNameCurrent ?? "")
                                                    Text(att.userServiceProviderInfoData?.userNameCurrent ?? "")
                                                    
                                                }
                                                
                                                VStack(alignment: .trailing) {
                                                    
                                                    Text(att.educationalCategoryInfoData?.educationalCategoryNameCurrent ?? "")
                                                    if att.placeInfoData != nil  {
                                                        Text(att.placeInfoData?.placeNameCurrent ?? "")
                                                    }
                                                }
                                            }
                                            
                                            
                                            HStack (spacing : 180){
                                                
                                                HStack {
                                                    Image("rates")
                                                        .resizable()
                                                        .frame(width: 30, height: 30)
                                                    Text(NSLocalizedString("rate", comment: ""))
                                                    
                                                    
                                                    Text(Helper.formateDouble(rate: att.attendanceRate ?? 0.0))
                                                    
                                                }
                                                .frame(width:130)
                                                
                                                
                                                if att.attendanceStudentWarningData != nil {
                                                    Image("warning")
                                                        .resizable()
                                                        .frame(width: 30, height: 30)
                                                        .onTapGesture {
                                                            self.attendanceData = att.attendanceStudentWarningData!
                                                            withAnimation(.bouncy){
                                                                showWarnings.toggle()
                                                            }
                                                        }
                                                }
                                            }
                                        }
                                        .font(
                                            Font.custom(Fonts().getFontBold(), size: 12)
                                                .weight(.bold)
                                        )
                                        .foregroundColor(.white)
                                        .padding()
                                        .frame(width: 350, height: .infinity,alignment: .center)
                                        .background(Color(Colors().mainColor))
                                        .cornerRadius(30)
                                        .offset(x:-28)
                                        
                                    } label: {
                                        DisclosureLabel(image: att.attendanceTypeToken == genralVm.constants.ATTENDANCE_TYPE_ATTEND ? "right" : att.attendanceTypeToken == genralVm.constants.ATTENDANCE_TYPE_DEPARTURE ? "wrong" : "question-mark", day: att.dayNameCurrent ?? "", date: att.dateTimeFromDate ?? "",duration:att.durationCurrent ?? "")
                                        
                                    }
                                    
                                    
                                    .disclosureGroupStyle(CustomDisclosureGroupStyle(button: Image("info_icon")
                                        .resizable()
                                        .frame(width: 30,height: 30)
                                        .onTapGesture {
                                            withAnimation(.easeInOut){
                                                //           self.toggleAttendnaceExpansion(attendnace: att)
                                            }
                                        }))
                                }
                                if attendnaceHistoryVmm.currentPage < attendnaceHistoryVmm.tottalPages {
                                    Text(NSLocalizedString("fetchMoreData", comment: ""))
                                        .onAppear {
                                            attendnaceHistoryVmm.currentPage += 1
                                            do {
                                                try attendnaceHistoryVmm.getData()
                                            } catch {
                                                
                                            }
                                        }
                                }
                            }
                            
                            .refreshable {
                                do {
                                    try attendnaceHistoryVmm.getData(isRefresh:true)
                                } catch {
                                    
                                }
                            }
                            .listStyle(.plain)
                        }
                        .ipad()
                        .navigationTitle(NSLocalizedString("attendnaceHistory", comment: ""))
                        .onAppear(perform: {
                            do {
                                try attendnaceHistoryVmm.getData(isRefresh: true)
                            } catch {
                                
                            }
                        })
                        
                        .fullScreenCover(isPresented: $backGeasture, content: StudentMainTabView.init)
                        
                        if showWarnings {
                            WarningsView(attendanceData:self.attendanceData ,dismiss: $showWarnings)
                        }
                    }
               
                .navigationBarItems(trailing:
                                        Button(action: {
                    showFilter.toggle()
                }, label: {
                    Image("filter")
                        .resizable()
                        .frame(width:30,height: 30)
                })
                                            .sheet(isPresented: $showFilter) {
                                                VStack (spacing : 20){
                                                    HStack(spacing:50){
                                                        
                                                        Text(NSLocalizedString("selectSearchType",comment:""))
                                                        
                                                        Picker(selection: $selected, label: Text("")) {
                                                            Text(NSLocalizedString("monthly", comment: "")).tag(1)
                                                            Text(NSLocalizedString("interval", comment: "")).tag(2)
                                                        }
                                                        .pickerStyle(.automatic)
                                                    }
                                                    
                                                    VStack{
                                                        TextField("", text: $educationGroupSelected ,onEditingChanged: { isEditing in
                                                            if isEditing {
                                                                isMenuVisibleEducationalGroups = true
                                                            }
                                                        })
                                                        .textFieldStyle(
                                                            CustomTextFieldStyle(placeholder: NSLocalizedString("educationGroups", comment: ""), placeholderColor: .black, placeholderBgColor: .white,image: "groups", isPassword: false, isEditing: !self.educationGroupSelected.isEmpty, isTapped: $showPassword)
                                                        )
                                                        .focused($endEditingEducationGroups)
                                                    }
                                                    .popover(isPresented: $isMenuVisibleEducationalGroups, content: {
                                                        
                                                        VStack {
                                                            ZStack {
                                                                if educationGroups.noData {
                                                                    NoContent(message: educationGroups.msg)
                                                                } else {
                                                                    List {

                                                                        ForEach(educationGroups.educationalGroupData,id: \.educationalGroupStudentToken) { group in
                                                                            HStack (spacing: 10){
                                                                                CustomImageUrl(url: group.educationalGroupInfoData?.educationalGroupImageUrl ?? "")
                                                                                
                                                                                Text(group.educationalGroupInfoData?.educationalGroupNameCurrent ?? "")
                                                                                Spacer()
                                                                                
                                                                            }
                                                                            .onTapGesture {
                                                                                self.educationGroupSelected = group.educationalGroupInfoData?.educationalGroupNameCurrent ?? ""
                                                                                self.educationGroupSelectedToken = group.educationalGroupInfoData?.educationalGroupToken ?? ""
                                                                                self.isMenuVisibleEducationalGroups.toggle()
                                                                                self.endEditingEducationGroups = false
                                                                            }
                                                                            .padding()
                                                                        }
                                                                        .listStyle(.insetGrouped)
                                                                        if educationGroups.currentPage < educationGroups.totalPages {
                                                                            Text(NSLocalizedString("fetchMoreData", comment: ""))
                                                                                .onAppear {
                                                                                    educationGroups.currentPage += 1
                                                                                    educationGroups.getEducationGroups(finishedToken: genralVm.constants.GROUPS_UN_FINISHED,refresh:false)
                                                                                }
                                                                        }
                                                                    }
                                                                }
                                                                
                                                                if educationGroups.isLoading {
                                                                    LoadingView(placHolder: NSLocalizedString("loading", comment: ""))
                                                                }
                                                            }
                                                        }
                                                     
                                                        .onAppear {
                                                            educationGroups.getEducationGroups(finishedToken: genralVm.constants.GROUPS_UN_FINISHED)
                                                        }
                                                    })

                                                    .padding()
                                                    
                                                    if self.selected == 1 {
                                                        VStack {
                                                            TextField("", text: $monthly)
                                                                .textFieldStyle(
                                                                    CustomTextFieldStyle(placeholder: NSLocalizedString("month", comment: ""), placeholderColor: .black, placeholderBgColor: .white,image: "calendar", isPassword: false, isEditing: !self.monthly.isEmpty, isTapped: $showPassword)
                                                                )
                                                                .keyboardType(.phonePad)
                                                        }
                                                        .padding()
                                                    } else if self.selected == 2 {
                                                        HStack {
                                                            VStack {
                                                                TextField("", text: Binding(
                                                                    get: { self.dateFormatter.string(from: selectedDateFrom)},
                                                                    set: { text in
                                                                        fromDate = DateTime.formateDate(date: text)
                                                                    }
                                                                ))
                                                                .onTapGesture {
                                                                    self.showDatePicker = true
                                                                }
                                                                .popover(isPresented: $showDatePicker, arrowEdge: .bottom) {
                                                                    DatePicker("Select Date", selection: $selectedDateFrom, displayedComponents: .date)
                                                                        .datePickerStyle(GraphicalDatePickerStyle())
                                                                        .frame(maxHeight: 400)
                                                                }
                                                                .textFieldStyle(
                                                                    CustomTextFieldStyle(placeholder: NSLocalizedString("dateFrom", comment: ""), placeholderColor: .black, placeholderBgColor: .white,image: "calendar", isPassword: false, isEditing: !self.dateFormatter.string(from: selectedDateFrom).isEmpty, isTapped: $showPassword)
                                                                )
                                                            }
                                                            VStack {
                                                                TextField("", text: Binding(
                                                                    get: { self.dateFormatter.string(from: selectedDateTo)},
                                                                    set: { text in
                                                                        toDate = DateTime.formateDate(date: text)
                                                                    }
                                                                ))
                                                                .onTapGesture {
                                                                    self.isDatePickerVisible = true
                                                                }
                                                                .popover(isPresented: $isDatePickerVisible, arrowEdge: .bottom) {
                                                                    DatePicker("Select Date", selection: $selectedDateTo, displayedComponents: .date)
                                                                        .datePickerStyle(GraphicalDatePickerStyle())
                                                                        .frame(maxHeight: 400)
                                                                }
                                                                .textFieldStyle(
                                                                    CustomTextFieldStyle(placeholder: NSLocalizedString("dateTo", comment: ""), placeholderColor: .black, placeholderBgColor: .white,image: "calendar", isPassword: false, isEditing: !self.dateFormatter.string(from: selectedDateTo).isEmpty, isTapped: $showPassword)
                                                                )
                                                            }
                                                        }
                                                        .padding()
                                                    }
                                                    
                                                    HStack(alignment: .center, spacing: 5) {
                                                        
                                                        Button {
                                                            if self.selected == 1 {
                                                                attendnaceHistoryVmm.month = DateTime.replaceCharcaterToEnglish(value: self.monthly)
                                                                do {
                                                                    try attendnaceHistoryVmm.getData(calenderSearchType: genralVm.constants.CALENDER_SEARCH_TYPE_TOKEN_SIMPOL_MONTH,educationalGroupToken:self.educationGroupSelectedToken)
                                                                } catch {
                                                                    
                                                                }
                                                                
                                                            } else if self.selected == 2 {
                                                                let formattedDateFrom = dateFormatter.string(from: selectedDateFrom)
                                                                let formattedDateTo = dateFormatter.string(from: selectedDateTo)
                                                                do {
                                                                    try attendnaceHistoryVmm.getData(calenderSearchType: genralVm.constants.CALENDER_SEARCH_TYPE_TOKEN_SIMPOL_CUSTOIZE,dateTimeStartSearch: formattedDateFrom,dateTimeEndSearch:formattedDateTo,educationalGroupToken:self.educationGroupSelectedToken)
                                                                } catch {
                                                                    
                                                                }
                                                            }
                                                            
                                                        } label: {
                                                            Text(NSLocalizedString("search", comment: ""))
                                                                .font(
                                                                    Font.custom(Fonts().getFontBold(), size: 15)
                                                                        .weight(.bold)
                                                                )
                                                                .foregroundColor(Color(red: 0.9, green: 0.88, blue: 0.91))
                                                        }
                                                    }
                                                    .padding(.horizontal, 82)
                                                    .padding(.vertical, 16)
                                                    .frame(width: 234, height: 58, alignment: .center)
                                                    .background(Color(Colors().mainButtonColor.cgColor))
                                                    .cornerRadius(10)
                                                }
                                            }
                )
                .navigationBarItems(leading: CustomBackButton(){
                    clearStatesWithAction(valueState: &backGeasture)
                })
                .ipad()
              
                .overlay(
                    attendnaceHistoryVmm.isLoading ?
                    GeometryReader { geometry in
                        ZStack {
                            LoadingView(placHolder: NSLocalizedString("loading", comment: ""))
                                .frame(width: geometry.size.width, height: geometry.size.height)
                                .transition(.scale)
                        } } : nil
                )
                .refreshable {
                    educationGroups.getEducationGroups(finishedToken: genralVm.constants.GROUPS_UN_FINISHED)
                
                }
                .onDisappear(perform: {
                    clearStatesWithAction(valueState: &dissapearView)
                    
                })
                .fullScreenCover(isPresented: $attendnaceHistoryVmm.showLogOut, content: {
                    RegistrationView()
                })
            }
            
        }
        }
    }
    private func toggleAttendnaceExpansion(attendnace: EducationalGroupAttendancesDatum) {
          if expandedAttendenceHistory.contains(attendnace.educationalGroupAttendanceToken ?? "") {
              expandedAttendenceHistory.remove(attendnace.educationalGroupAttendanceToken ?? "")
          } else {
//              self.expandedAttendenceHistory.removeAll()
              expandedAttendenceHistory.insert(attendnace.educationalGroupAttendanceToken ?? "")
          }
      }
    
    private func clearStatesWithAction(valueState: inout Bool) {
        valueState.toggle()
        backGeasture = false
    }
}
