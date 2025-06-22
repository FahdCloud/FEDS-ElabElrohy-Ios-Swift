//
//  StudentExamView.swift
//  FEDS-Center-Dev-IOS
//
//  Created by Omar Pakr on 20/03/2024.
//

import SwiftUI
import WebKit

@available(iOS 16.0, *)
struct StudentExamView: View {
    @StateObject var genralVm : GeneralVm = GeneralVm()
    @StateObject var studentExamVm : StudentExamVm = StudentExamVm()
    @StateObject var paragraph : ParagraphViewVm = ParagraphViewVm()
    @StateObject private var detector = ScreenRecordingDetector()
    var finishedExam: String = ""
    private let constant = Constants()
    private let adaptiveColumns = [
        GridItem(.fixed(100))
    ]
    var body: some View {
        
        NavigationView {
            VStack {
                ZStack (alignment:.top){
                    if studentExamVm.noData {
                        NoContent(message: studentExamVm.msg)
                            .padding(.top, 200)
                    } else {
                        
                        // Main content
                        VStack(spacing: 4){
                            ScrollView {
                                VStack {
                                    LazyVGrid(columns: adaptiveColumns,spacing: 10) {
                                        ForEach(studentExamVm.studentExam, id: \.studentExamToken) { exam in
                                            VStack {
                                                VStack(alignment: .leading){
                                                    HStack(spacing:100){
                                                        HStack (spacing:10){
                                                            Image("item_of_pages")
                                                                .resizable()
                                                                .frame(width: 30, height: 30)
                                                            
                                                            Text(exam.educationalExamInfoData?.educationalExamTitle ?? "")
                                                                .font(
                                                                    Font.custom(Fonts().getFontBold(), size: 15).weight(.bold))
                                                                .foregroundColor(genralVm.isDark ? .white: .black)
                                                        }
                                                        
                                                        
                                                        
                                                        if exam.canStartExam! == false && exam.examDeliveryStatusTypeToken == self.constant.EXAM_DELIVERY_STATUS_UNKNOWN {
                                                            Image(systemName: "lock.fill")
                                                                .resizable()
                                                                .frame(width: 25, height: 25)
                                                                .foregroundColor(.red)
                                                        } else if exam.canStartExam! == true && exam.examDeliveryStatusTypeToken == self.constant.EXAM_DELIVERY_STATUS_UNKNOWN {
                                                            Image(systemName: "lock.open.fill")
                                                                .resizable()
                                                                .frame(width: 25, height: 25)
                                                                .foregroundColor(.green)
                                                            
                                                        }  else if exam.canStartExam! == false && exam.examDeliveryStatusTypeToken == self.constant.EXAM_DELIVERY_STATUS_UNKNOWN {
                                                            Image(systemName: "xmark")
                                                                .resizable()
                                                                .frame(width: 25, height: 25)
                                                                .foregroundColor(.red)
                                                            
                                                        } else if exam.canStartExam! == false && exam.examDeliveryStatusTypeToken == self.constant.EXAM_DELIVERY_STATUS_DELIVERD {
                                                            Image(systemName: "checkmark")
                                                                .resizable()
                                                                .frame(width: 25, height: 25)
                                                                .foregroundColor(.green)
                                                        }
                                                    }
                                                    
                                                    Divider()
                                                        .bold()
                                                    
                                                    HStack(spacing:50){
                                                        Image("educationSubject")
                                                            .resizable()
                                                            .frame(width: 30, height: 30)
                                                        
                                                        Text(exam.educationalExamInfoData?.educationalCategoryInfoData?.educationalCategoryFullNameCurrent ?? "")
                                                            .font(
                                                                Font.custom(Fonts().getFontBold(), size: 15).weight(.bold))
                                                            .foregroundColor(genralVm.isDark ? .white: .black)
                                                        
                                                    }
                                                    
                                                    Divider()
                                                        .bold()
                                                    HStack(spacing:50){
                                                        Image("group")
                                                            .resizable()
                                                            .frame(width: 30, height: 30)
                                                        
                                                        Text(exam.educationalExamInfoData?.educationalGroupInfoData?.educationalGroupNameCurrent ?? "")
                                                            .font(
                                                                Font.custom(Fonts().getFontBold(), size: 15).weight(.bold))
                                                            .foregroundColor(genralVm.isDark ? .white: .black)
                                                        
                                                    }
                                                    
                                                    Divider()
                                                        .bold()
                                                    HStack(spacing:50){
                                                        Text(NSLocalizedString("openFrom", comment: ""))
                                                            .font(
                                                                Font.custom(Fonts().getFontBold(), size: 14).weight(.bold))
                                                            .foregroundColor(genralVm.isDark ? .white: .black)
                                                        
                                                        Text(exam.educationalExamInfoData?.educationalExamStartCustomized ?? "")
                                                            .font(
                                                                Font.custom(Fonts().getFontBold(), size: 14).weight(.bold))
                                                            .foregroundColor(genralVm.isDark ? .white: .black)
                                                        
                                                    }
                                                    
                                                    Divider()
                                                        .bold()
                                                    HStack(spacing:50){
                                                        Text(NSLocalizedString("endedAt", comment: ""))
                                                            .font(
                                                                Font.custom(Fonts().getFontBold(), size: 14).weight(.bold))
                                                            .foregroundColor(genralVm.isDark ? .white: .black)
                                                        
                                                        Text(exam.educationalExamInfoData?.educationalExamEndCustomized ?? "")
                                                            .font(
                                                                Font.custom(Fonts().getFontBold(), size: 14).weight(.bold))
                                                            .foregroundColor(genralVm.isDark ? .white: .black)
                                                        
                                                        Image("")
                                                        
                                                    }
                                                    
                                                    Divider()
                                                        .bold()
                                                    
                                                    if exam.canStartExam! == false && exam.examDeliveryStatusTypeToken == self.constant.EXAM_DELIVERY_STATUS_DELIVERD {
                                                        ButtonAction(text:NSLocalizedString("review", comment: ""), color: Color(Colors().buttonGreenColorLight)) {
                                                            if genralVm.userTypeToken == genralVm.constants.USER_TYPE_TOKEN_STUDENT {
                                                                studentExamVm.reviewExam(studentExamToken: exam.studentExamToken ?? "")
                                                            } else {
                                                                studentExamVm.clearStatesWithAction(valueState: &studentExamVm.youAreNotstudenAlert)

                                                            }
                                                        }
                                                    } else if exam.canStartExam! == true && exam.examDeliveryStatusTypeToken == self.constant.EXAM_DELIVERY_STATUS_UNKNOWN {
                                                        ButtonAction(text:NSLocalizedString("startExamAlert", comment: ""), color: Color(Colors().buttonGreenColorLight)) {
                                                            self.studentExamVm.studentExamToken = exam.studentExamToken ?? ""
                                                            studentExamVm.showOpenAlert.toggle()
                                                        }
                                                    }
                                                }
                                                .padding(.horizontal, 15)
                                            }
                                            .frame(width: 300,height: 300)
                                            .background(genralVm.isDark ? Color(Colors().darkCardWalletBg): Color(Colors().lightCardWalletBg))
                                            .cornerRadius(10) // Set the corner radius here
                                            .shadow(color: genralVm.isDark ? .white : .black, radius: 5, x: 0, y: 3)
                                            .frame(maxHeight: .infinity,alignment: .top)
                                            .padding(.horizontal, 20)
                                            .padding(.vertical, 10)
                                        }
                                        
                                        if studentExamVm.currentPage < studentExamVm.totalPages {
                                            Text(NSLocalizedString("fetchMoreData", comment: ""))
                                                .onAppear {
                                                    studentExamVm.currentPage += 1
                                                    studentExamVm.paginated = true
                                                    studentExamVm.getStudentExams(schudelToken: "",moduleExamTypeToken: self.constant.MODULE_EXAM_TYPE_TOKEN_EXAMS,examSearchStatusTypeToken : finishedExam == self.constant.EXAM_SEARCH_STATUS_TYPE_FINISHED ? self.constant.EXAM_SEARCH_STATUS_TYPE_FINISHED : finishedExam == self.constant.EXAM_SEARCH_STATUS_TYPE_CURRENT ? self.constant.EXAM_SEARCH_STATUS_TYPE_CURRENT : "" )
                                                }
                                            
                                        }
                                    }
                                }
                                
                            }
                        }
                        .padding(.top, 200)
                    }
                    
                    ZStack(alignment: .top) {
                        Rectangle()
                            .fill(.clear)
                            .frame(height: 150) // Adjust height as needed
                            .edgesIgnoringSafeArea(.top)
                        
                        HStack{
                            VStack {
                                Text(NSLocalizedString("year", comment: ""))
                                    .font(
                                        Font.custom(Fonts().getFontBold(), size: 15).weight(.bold))
                                    .foregroundColor(genralVm.isDark ? .white: .black)
                                
                                DropDownView(show: $studentExamVm.yearsIsDropdownVisible) {
                                    // Custom stylized dropdown button.
                                    ZStack {
                                        // Rounded rectangle border.
                                        RoundedRectangle(cornerRadius: 5)
                                            .stroke(Color.gray.opacity(0.5), lineWidth: 0.5)
                                        HStack {
                                            // Display selected option text.
                                            Text(studentExamVm.selectedYear)
                                                .foregroundColor(.black)
                                                .font(.system(size: 18))
                                                .padding(.horizontal, 10)
                                            Spacer()
                                            // Chevron icon indicating dropdown state.
                                            Image(systemName: studentExamVm.yearsIsDropdownVisible ? "chevron.up" : "chevron.down")
                                                .resizable()
                                                .frame(width: 12, height: 7)
                                                .font(.headline)
                                                .aspectRatio(contentMode: .fill)
                                                .foregroundColor(.black)
                                                .padding(.trailing, 10)
                                        }
                                    }
                                    .background(Color.white)
                                    .frame(height: 40)
                                    .padding(.leading,20)
//                                    .padding(.horizontal, 100)
                                    
                                } dropdown: {
                                    // Dropdown options displayed in a scrollable list.
                                    ZStack {
                                        // Rounded rectangle border.
                                        RoundedRectangle(cornerRadius: 5)
                                            .stroke(Color.gray.opacity(0.5), lineWidth: 0.5)
                                        // Scrollable list of options.
                                        ScrollView {
                                            VStack(alignment: .leading) {
                                                // Iterate through options and create a button for each.
                                                ForEach(studentExamVm.years, id: \.self) { option in
                                                    Button(action: {
                                                        // Set selected option and toggle dropdown visibility.
                                                        studentExamVm.selectedYear = option
                                                        studentExamVm.yearsIsDropdownVisible.toggle()
                                                        studentExamVm.getStudentExams(schudelToken: "",moduleExamTypeToken: self.constant.MODULE_EXAM_TYPE_TOKEN_EXAMS,examSearchStatusTypeToken : finishedExam == self.constant.EXAM_SEARCH_STATUS_TYPE_FINISHED ? self.constant.EXAM_SEARCH_STATUS_TYPE_FINISHED : finishedExam == self.constant.EXAM_SEARCH_STATUS_TYPE_CURRENT ? self.constant.EXAM_SEARCH_STATUS_TYPE_CURRENT : "" )
                                                    }, label: {
                                                        VStack {
                                                            // Stylized option button with rounded rectangle background.
                                                            ZStack {
                                                                RoundedRectangle(cornerRadius: 5)
                                                                    .foregroundColor(studentExamVm.selectedYear == option ? Color.gray : Color.white)
                                                                Text(option)
                                                                    .foregroundColor(.black)
                                                            }
                                                            // Separator line between options.
                                                            Rectangle()
                                                                .frame(height: 1)
                                                                .foregroundColor(.black.opacity(option != studentExamVm.years.last ? 0.2 : 0))
                                                                .padding(.horizontal, 30)
                                                        }
                                                        .frame(height: 40)
                                                    })
                                                }
                                            }
                                        }
                                        .frame(height: 200)
                                    }
                                    .background(Color.white)
                                    .padding(.horizontal, 60)
                                }
                                // Set default selected option on view appear.
                                .onAppear {
                                    self.studentExamVm.selectedYear = studentExamVm.years[5]
                                }
                            }
                            .padding(.top, 100)
                            
                            VStack {
                                
                                Text(NSLocalizedString("month", comment: ""))
                                    .font(
                                        Font.custom(Fonts().getFontBold(), size: 15).weight(.bold))
                                    .foregroundColor(genralVm.isDark ? .white: .black)
                                
                                DropDownView(show: $studentExamVm.monthIsDropdownVisible) {
                                    // Custom stylized dropdown button.
                                    ZStack {
                                        // Rounded rectangle border.
                                        RoundedRectangle(cornerRadius: 5)
                                            .stroke(Color.gray.opacity(0.5), lineWidth: 0.5)
                                        HStack {
                                            // Display selected option text.
                                            Text(studentExamVm.selectedMonth)
                                                .foregroundColor(.black)
                                                .font(.system(size: 18))
                                                .padding(.horizontal, 10)
                                            Spacer()
                                            // Chevron icon indicating dropdown state.
                                            Image(systemName: studentExamVm.monthIsDropdownVisible ? "chevron.up" : "chevron.down")
                                                .resizable()
                                                .frame(width: 12, height: 7)
                                                .font(.headline)
                                                .aspectRatio(contentMode: .fill)
                                                .foregroundColor(.black)
                                                .padding(.trailing, 10)
                                        }
                                    }
                                    .background(Color.white)
                                    .frame(height: 40)
                                    .padding(.horizontal, 40)
                                    
                                } dropdown: {
                                    // Dropdown options displayed in a scrollable list.
                                    ZStack {
                                        // Rounded rectangle border.
                                        RoundedRectangle(cornerRadius: 5)
                                            .stroke(Color.gray.opacity(0.5), lineWidth: 0.5)
                                        // Scrollable list of options.
                                        ScrollView {
                                            VStack(alignment: .leading) {
                                                // Iterate through options and create a button for each.
                                                ForEach(studentExamVm.months, id: \.self) { option in
                                                    Button(action: {
                                                        // Set selected option and toggle dropdown visibility.
                                                        studentExamVm.selectedMonth = option
                                                        studentExamVm.monthIsDropdownVisible.toggle()
                                                        studentExamVm.getStudentExams(schudelToken: "",moduleExamTypeToken: self.constant.MODULE_EXAM_TYPE_TOKEN_EXAMS,examSearchStatusTypeToken : finishedExam == self.constant.EXAM_SEARCH_STATUS_TYPE_FINISHED ? self.constant.EXAM_SEARCH_STATUS_TYPE_FINISHED : finishedExam == self.constant.EXAM_SEARCH_STATUS_TYPE_CURRENT ? self.constant.EXAM_SEARCH_STATUS_TYPE_CURRENT : "" )
                                                    }, label: {
                                                        VStack {
                                                            // Stylized option button with rounded rectangle background.
                                                            ZStack {
                                                                RoundedRectangle(cornerRadius: 5)
                                                                    .foregroundColor(studentExamVm.selectedMonth == option ? Color.gray : Color.white)
                                                                Text(option)
                                                                    .foregroundColor(.black)
                                                            }
                                                            // Separator line between options.
                                                            Rectangle()
                                                                .frame(height: 1)
                                                                .foregroundColor(.black.opacity(option != studentExamVm.months.last ? 0.2 : 0))
                                                                .padding(.horizontal, 30)
                                                        }
                                                        .frame(height: 40)
                                                    })
                                                }
                                            }
                                        }
                                        .frame(height: 200)
                                    }
                                    .background(Color.white)
                                    .padding(.horizontal, 40)
                                }
                                // Set default selected option on view appear.
                                .onAppear {
                                    self.studentExamVm.selectedMonth = studentExamVm.months[5]
                                }
                            }
                            .padding(.top, 100)
                        }
                    }
                }
            }
            .ipad()
            .edgesIgnoringSafeArea(.all)
            .onAppear {
                studentExamVm.getStudentExams(schudelToken: "",moduleExamTypeToken: self.constant.MODULE_EXAM_TYPE_TOKEN_EXAMS,examSearchStatusTypeToken : finishedExam == self.constant.EXAM_SEARCH_STATUS_TYPE_FINISHED ? self.constant.EXAM_SEARCH_STATUS_TYPE_FINISHED : finishedExam == self.constant.EXAM_SEARCH_STATUS_TYPE_CURRENT ? self.constant.EXAM_SEARCH_STATUS_TYPE_CURRENT : "" )
            }
            .refreshable {
                studentExamVm.currentPage = 1
                studentExamVm.paginated = false
                studentExamVm.getStudentExams(schudelToken: "",moduleExamTypeToken: self.constant.MODULE_EXAM_TYPE_TOKEN_EXAMS,examSearchStatusTypeToken : finishedExam == self.constant.EXAM_SEARCH_STATUS_TYPE_FINISHED ? self.constant.EXAM_SEARCH_STATUS_TYPE_FINISHED : finishedExam == self.constant.EXAM_SEARCH_STATUS_TYPE_CURRENT ? self.constant.EXAM_SEARCH_STATUS_TYPE_CURRENT : "" )
            }
            .overlay(
                studentExamVm.isLoading ?
                GeometryReader { geometry in
                    ZStack {
                        LoadingView(placHolder: NSLocalizedString("loading", comment: ""))
                            .frame(width: geometry.size.width, height: geometry.size.height)
                            .transition(.scale)
                    } } : nil
            )
            
            .background(AzDialogActions(isPresented: $studentExamVm.showOpenAlert, title: NSLocalizedString("alert", comment: ""), message:  NSLocalizedString("msgOpenExam", comment: ""), imageTop: "logout_button", buttonClick: NSLocalizedString("startExamAlert", comment: ""), onClick: {
                studentExamVm.startExam(studentExamToken: self.studentExamVm.studentExamToken)
                
            }))
            .background(AZDialogAlert(isPresented: $studentExamVm.youAreNotstudenAlert,
                                      title: NSLocalizedString("alert", comment: ""),
                                      message: NSLocalizedString("msgTypeFamily", comment: ""),
                                      imageTop: "3d-lock"))
            .padding(.bottom, 25)
            .padding(.horizontal, 10)
            
            .fullScreenCover(isPresented: $studentExamVm.backFromStudentExam, content: {
                StudentMainTabView()
                    .environmentObject(ScreenshotDetector())
                    .environmentObject(ScreenRecordingDetector())
                
            })
            .fullScreenCover(isPresented: $studentExamVm.showExamFromOnlineContentDetails, content: {
                ParagraphView()

            })
            .fullScreenCover(isPresented: $studentExamVm.showReview, content: {
                ParagraphReview(examParagraphsInfoData: self.studentExamVm.examParagraphsInfoData, educationGroupTimeToken:"")


            })
            .navigationBarItems(leading: CustomBackButton(){
                studentExamVm.clearStatesWithAction(valueState: &studentExamVm.backFromStudentExam)
            })
        }
        
    }
  
}
