//
//  NewLevels.swift
//  FEDS-Center-Dev-IOS
//
//  Created by Omar Pakr on 07/04/2024.
//

import SwiftUI
import BottomSheetSwiftUI

@available(iOS 16.0, *)
struct OnlineContentLevelsView: View {
    
    @StateObject var educationCourseDetailsVm : EducationCourseDetailsVm = EducationCourseDetailsVm()
    @StateObject var genralVm : GeneralVm = GeneralVm()
    @StateObject var studentExamVm : StudentExamVm = StudentExamVm()
    @State var educationalCourseData : EducationalCourseInfoData = EducationalCourseInfoData()
    
    
    @State private var isExpand : Bool = false
    @State private var showContentLevelView = false
    @State private var unValidSubscriptionAlert = false
    @State private var userCanReExamIfAfterFailed = false
    @State private var userCanReviewExamIfFailed  = false
    @State private var userCanReviewExamIfSucsess = false
    
    @State private var msgDialogExam : String = ""
    @State private var msgDialogUnValidSubscription : String = ""
    @State private var studentExamToken : String = ""
    @State private var educationalCourseStudentToken : String = ""
    @State private var educationalCourseLessonToken : String = ""
    
    @State private var showDailogUnDeliveredExam: BottomSheetPosition = .hidden
    @State private var showDailogFaliedExam: BottomSheetPosition = .hidden
    @State private var showDailogNonRequestedExam: BottomSheetPosition = .hidden
    @State private var showDailogSucsessedExam: BottomSheetPosition = .hidden
    @State private var unValidSubscriptionPopup: BottomSheetPosition = .hidden
    @State private var toast: Toast? = nil
    @State private var visualEffect  = VisualEffect.systemDark
    let switchablePositions: [BottomSheetPosition] = [.dynamic]
    
    @Environment(\.colorScheme) var colorScheme
    @EnvironmentObject var screenshotDetector: ScreenshotDetector
    @EnvironmentObject var screenRecordingDetector: ScreenRecordingDetector
    
    var body: some View {
        ScrollView {
            VStack{
                if let chaptersInfoData = self.educationalCourseData.educationalCourseChaptersInfoData, !chaptersInfoData.isEmpty {
                    VStack {
                        ForEach(self.educationalCourseData.educationalCourseChaptersInfoData ?? [EducationalCourseChaptersInfoDatum](), id: \.educationalCourseChapterToken) { chapters in
                            CollapsibleDisclosureGroup(isExpanded: $isExpand,
                                                       title: chapters.educationalCourseChapterTitle ?? "",
                                                       subTitle:NSLocalizedString("contentCount", comment: "") + " " + "\(chapters.educationalCourseLessonsInfoData?.count ?? 0)" ) {
                                if let lessons = chapters.educationalCourseLessonsInfoData {
                                    ForEach(lessons, id: \.educationalCourseLessonNumber) { lesson in
                                        VStack{
                                            HStack ( spacing: 10){
                                                
                                                let mediaType = lesson.educationalCourseLessonFileInfo?.fileMediaTypeToken ?? ""
                                                
                                                educationCourseDetailsVm.imageForMediaType(mediaType, constants: self.genralVm.constants, lessonTypeToken: lesson.educationalCourseLessonTypeToken ?? "")
                                                    .resizable()
                                                    .frame(width: 25, height: 25)
                                                
                                                Text(lesson.educationalCourseLessonTitle ?? "")
                                                    .font(
                                                        Font.custom(Fonts().getFontBold(), size: 18)
                                                            .weight(.bold)
                                                    )
                                                    .multilineTextAlignment(.leading)
                                                    .lineLimit(4)
                                                Spacer()
                                                
                                                Image(systemName: lesson.canOpenFile! == false  ? "lock.fill" : "" )
                                                    .foregroundColor(.red)
                                                
                                            }
                                            
                                            .padding()
                                            .background(
                                                RoundedRectangle(cornerRadius: 10)
                                                    .stroke(genralVm.isDark ? Color(Colors().darkCardBg): Color(Colors().lightCardBg), lineWidth: 4)
                                            )
                                        }
                                        .contentShape(Rectangle())
                                        .onTapGesture(perform: {
                                            
                                            if lesson.canOpenFile! == true {
                                                if lesson.educationalCourseLessonTypeToken! == self.genralVm.constants.LESSONS_TYPE_TOKEN_FILE {
                                                    UserDefaultss().saveStrings(value: (lesson.educationalCourseLessonFileInfo?.fileWatchViewUrl ?? ""), key: "fileWatchViewUrl")
                                                    let url = UserDefaultss().restoreString(key: "fileWatchViewUrl")
                                                    if Validation.IsValidContent(text: url, length: 6){
                                                        clearStatesWithAction(valueState: &showContentLevelView)
                                                    }
                                                } else if lesson.educationalCourseLessonTypeToken! == self.genralVm.constants.LESSONS_TYPE_TOKEN_EXAM {
                                                    
                                                    
                                                    
                                                    self.educationalCourseStudentToken = self.educationalCourseData.educationalCourseStudentSubscriptionInfoData?.educationalCourseStudentToken ?? ""
                                                    
                                                    self.educationalCourseLessonToken = lesson.educationalCourseLessonToken ?? ""
                                                    
                                                    self.studentExamToken = lesson.educationalCourseLessonExamInfo?.studentExamToken ?? ""
                                                    
                                                    self.userCanReExamIfAfterFailed = lesson.educationalCourseLessonExamInfo?.userCanReExamIfAfterFailed ?? false
                                                    self.userCanReviewExamIfFailed  = lesson.educationalCourseLessonExamInfo?.userCanReviewExamIfFailed ?? false
                                                    self.userCanReviewExamIfSucsess = lesson.educationalCourseLessonExamInfo?.userCanReviewExamIfSucsess ?? false
                                                    
                                                    
                                                    if lesson.educationalCourseLessonExamInfo?.examIsRequested ?? false  {
                                                        let examDeliveryStatusTypeToken =  lesson.educationalCourseLessonExamInfo?.examDeliveryStatusTypeToken ?? ""
                                                        if (examDeliveryStatusTypeToken == self.genralVm.constants.EXAM_DELIVERY_STATUS_DELIVERD )
                                                        {
                                                            
                                                            if (lesson.educationalCourseLessonExamInfo?.isSucsess ?? false) {
                                                                msgDialogExam =
                                                                NSLocalizedString("msgReviewExam", comment: "") +
                                                                "\n" +
                                                                NSLocalizedString("deg", comment: "") +
                                                                " " +
                                                                String (lesson.educationalCourseLessonExamInfo?.systemFinalDegree ?? 0.0 )  +
                                                                " " +
                                                                NSLocalizedString("from", comment: "") +
                                                                " " +
                                                                String(lesson.educationalCourseLessonExamInfo?.totalQuestionDegree ?? 0.0 )
                                                                //
                                                                self.showDailogSucsessedExam = .dynamic
                                                            }else {
                                                                msgDialogExam =
                                                                NSLocalizedString("msgFaliedExam", comment: "") +
                                                                "\n" +
                                                                NSLocalizedString("deg", comment: "") +
                                                                " " +
                                                                String (lesson.educationalCourseLessonExamInfo?.systemFinalDegree ?? 0.0 )  +
                                                                " " +
                                                                NSLocalizedString("from", comment: "") +
                                                                " " +
                                                                String(lesson.educationalCourseLessonExamInfo?.totalQuestionDegree ?? 0.0 )
                                                                //
                                                                self.showDailogFaliedExam = .dynamic
                                                            }
                                                        }else {
                                                            msgDialogExam = NSLocalizedString("msgContinueExam", comment: "")
                                                            self.showDailogUnDeliveredExam = .dynamic
                                                        }
                                                    }else {
                                                        msgDialogExam = NSLocalizedString("msgOpenExam", comment: "")
                                                        self.showDailogNonRequestedExam = .dynamic
                                                        
                                                    }
                                                }
                                            } else {
                                                msgDialogUnValidSubscription = lesson.canOpenMsg ?? ""
                                                self.unValidSubscriptionPopup = .dynamic
                                            }
                                        })
                                    }
                                }
                            }
                        }
                    }
                    .padding(.horizontal)
                }else{
                    if !(educationCourseDetailsVm.isLoading) {
                        NoContent(message: NSLocalizedString("message_no_education_cours_levels", comment: ""))
                    }else {
                        NoContent(message: NSLocalizedString("loading", comment: ""), image: "card_home_materials")
                    }
                }
                
                
            }
            .background(genralVm.isDark ? Color(Colors().darkBodyBg): Color(Colors().lightBodyBg))

            .padding(.top, 10)
            .scrollIndicators(.hidden)
            .fullScreenCover(isPresented: $educationCourseDetailsVm.showLogOut, content: {
                RegistrationView()
            })
            .fullScreenCover(isPresented: $showContentLevelView) {
                OnlineContentLevelWebView()
            }
            .fullScreenCover(isPresented: $educationCourseDetailsVm.showExam, content: {
                ParagraphView()
            })
            .fullScreenCover(isPresented: $educationCourseDetailsVm.reloadCourseInfo, content: {
                CoursesInfoTapView()
            })
            .fullScreenCover(isPresented: $educationCourseDetailsVm.showReview, content: {
                ParagraphReview(examParagraphsInfoData: educationCourseDetailsVm.examParagraphsInfoData,educationGroupTimeToken:"")
            })
        }
        .toastView(toast: $toast)
        .ipad()
        .overlay(
            self.educationCourseDetailsVm.isLoading ?
            GeometryReader { geometry in
                ZStack {
                    LoadingView(placHolder: NSLocalizedString("loading", comment: ""))
                        .frame(width: geometry.size.width, height: geometry.size.height)
                        .transition(.scale)
                } } : nil
        )
        .bottomSheet(
            bottomSheetPosition: $showDailogUnDeliveredExam,
            switchablePositions: switchablePositions,
            headerContent: {},
            mainContent: {
                CustomPopupContentView(iconName: "error_alert",
                                       title: NSLocalizedString("alert", comment: ""),
                                       message: msgDialogExam,
                                       buttonOneAction: {
                    self.educationCourseDetailsVm.startExam(studentExamToken: studentExamToken)
                    self.showDailogUnDeliveredExam = .hidden
                },
                                       buttonOneTitle: NSLocalizedString("continue", comment: ""),
                                       buttonOneColor: .green,
                                       numAction: 1)
                
            }
            
        )
        .enableSwipeToDismiss(false)
        .enableTapToDismiss(true)
        .enableBackgroundBlur(true)
        .enableContentDrag(true)
        .backgroundBlurMaterial(visualEffect)
        
        .bottomSheet(
            bottomSheetPosition: $unValidSubscriptionPopup,
            switchablePositions: switchablePositions,
            headerContent: {},
            mainContent: {
                CustomPopupContentView(iconName: "error_alert",
                                       title: NSLocalizedString("alert", comment: ""),
                                       message: msgDialogUnValidSubscription)
                
            }
            
        )
        .enableSwipeToDismiss(false)
        .enableTapToDismiss(true)
        .enableBackgroundBlur(true)
        .enableContentDrag(true)
        .backgroundBlurMaterial(visualEffect)
        
        .bottomSheet(
            bottomSheetPosition: $showDailogSucsessedExam,
            switchablePositions: switchablePositions,
            headerContent: {},
            mainContent: {
                CustomPopupContentView(iconName: "correct_check_box",
                                       title: NSLocalizedString("success", comment: ""),
                                       message: msgDialogExam,
                                       buttonOneAction: {
                    if (self.userCanReviewExamIfSucsess){
                        self.educationCourseDetailsVm.reviewExam(studentExamToken: studentExamToken)
                    }else{
                        self.toast = Helper.showToast(style: .error, message: NSLocalizedString("msg_locked_preview", comment: ""))
                    }
                    self.showDailogSucsessedExam = .hidden
                },
                                       buttonOneTitle: NSLocalizedString("review", comment: ""),
                                       buttonOneColor: .green,
                                       numAction: 1)
                
            }
            
        )
        .enableSwipeToDismiss(false)
        .enableTapToDismiss(true)
        .enableBackgroundBlur(true)
        .enableContentDrag(true)
        .backgroundBlurMaterial(visualEffect)
        
        .bottomSheet(
            bottomSheetPosition: $showDailogNonRequestedExam,
            switchablePositions: switchablePositions,
            headerContent: {},
            mainContent: {
                CustomPopupContentView(iconName: "exams",
                                       title: NSLocalizedString("alert", comment: ""),
                                       message: msgDialogExam,
                                       buttonOneAction: {
                    
                    self.educationCourseDetailsVm.requestExam(educationalCourseLessonToken: educationalCourseLessonToken, educationalCourseStudentToken: educationalCourseStudentToken)
                    self.showDailogNonRequestedExam = .hidden
                    
                },
                                       buttonOneTitle: NSLocalizedString("start", comment: ""),
                                       buttonOneColor: .green,
                                       numAction: 1)
                
            }
            
        )
        .enableSwipeToDismiss(false)
        .enableTapToDismiss(true)
        .enableBackgroundBlur(true)
        .enableContentDrag(true)
        .backgroundBlurMaterial(visualEffect)
        
        .bottomSheet(
            bottomSheetPosition: $showDailogFaliedExam,
            switchablePositions: switchablePositions,
            headerContent: {},
            mainContent: {
                CustomPopupContentView(iconName: "error_alert",
                                       title: NSLocalizedString("failed", comment: ""),
                                       message: msgDialogExam,
                                       buttonOneAction: {
                    
                    self.showDailogFaliedExam = .hidden
                    if (self.userCanReviewExamIfFailed){
                        self.educationCourseDetailsVm.isLoading = true
                        self.educationCourseDetailsVm.reviewExam(studentExamToken: studentExamToken)
                    }else{
                        self.toast = Helper.showToast(style: .error, message: NSLocalizedString("msg_locked_preview", comment: ""))
                    }
                    
                },
                                       buttonOneTitle: NSLocalizedString("review", comment: ""),
                                       buttonOneColor: .green,
                                       buttonTwoAction: {
                    self.showDailogFaliedExam = .hidden
                    if (self.userCanReExamIfAfterFailed){
                        self.educationCourseDetailsVm.isLoading = true
                        self.educationCourseDetailsVm.requestExam(educationalCourseLessonToken: educationalCourseLessonToken, educationalCourseStudentToken: educationalCourseStudentToken)
                    }else{
                        self.toast = Helper.showToast(style: .error, message: NSLocalizedString("msg_locked_re_exam", comment: ""))
                    }
                    
                },
                                       buttonTwoTitle: NSLocalizedString("reExam", comment: ""),
                                       buttonTwoColor: .gray,
                                       numAction: 2)
                
            }
            
        )
        .enableSwipeToDismiss(false)
        .enableTapToDismiss(true)
        .enableBackgroundBlur(true)
        .enableContentDrag(true)
        .backgroundBlurMaterial(visualEffect)
        
        
        .background(genralVm.isDark ? Color(Colors().darkBodyBg): Color(Colors().lightBodyBg))
        
        
        .background(AZDialogAlert(isPresented: $unValidSubscriptionAlert,
                                  title: NSLocalizedString("alert", comment: ""),
                                  message: msgDialogUnValidSubscription,
                                  imageTop: "3d-lock"))
        
        .toastView(toast: $educationCourseDetailsVm.toast)
        .onAppear{
            self.educationCourseDetailsVm.isLoading = true
                if let savedData = UserDefaults.standard.data(forKey: "educationalCourseInfoData") {
                    do {
                        let decodedData = try JSONDecoder().decode(EducationalCourseInfoData.self, from: savedData)
                        self.educationalCourseData = decodedData
                        self.educationCourseDetailsVm.isLoading = false
                    } catch {
                        self.educationCourseDetailsVm.isLoading = false
                    }
                } else {
                    self.educationCourseDetailsVm.isLoading = false
                }
            
        }
        .refreshable {
            self.educationCourseDetailsVm.reloadCourseInfo = true

        }
        .onDisappear {
            self.showContentLevelView = false
            self.educationCourseDetailsVm.showExam = false
            self.educationCourseDetailsVm.reloadCourseInfo = false
            self.isExpand = false
            self.showContentLevelView = false
            self.unValidSubscriptionAlert = false
            self.userCanReExamIfAfterFailed = false
            self.userCanReviewExamIfFailed  = false
            self.userCanReviewExamIfSucsess = false
            self.educationCourseDetailsVm.isLoading = false
            clearStatesWithAction(valueState: &genralVm.dissapearView)

            
        }
        
    }
    
    private func clearStatesWithAction(valueState: inout Bool) {
        valueState.toggle()
        self.showContentLevelView = false
        self.educationCourseDetailsVm.showExam = false
        self.educationCourseDetailsVm.reloadCourseInfo = false
        self.isExpand = false
        self.showContentLevelView = false
        self.unValidSubscriptionAlert = false
        self.userCanReExamIfAfterFailed = false
        self.userCanReviewExamIfFailed  = false
        self.userCanReviewExamIfSucsess = false
        
    }
    
    
}


struct CollapsibleDisclosureGroup<Content: View>: View {
    @Binding var isExpanded: Bool
    let title: String
    let subTitle: String
    let content: Content
    @StateObject var genralVm : GeneralVm = GeneralVm()
    
    init(isExpanded: Binding<Bool>, title: String ,subTitle:String, @ViewBuilder content: () -> Content) {
        self._isExpanded = isExpanded
        self.title = title
        self.subTitle = subTitle
        self.content = content()
    }
    
    var body: some View {
        DisclosureGroup(isExpanded: $isExpanded) {
            content
                .padding()
        } label: {
            HStack {
                
                Text(title)
                    .font(
                        Font.custom(Fonts().getFontBold(), size: 20)
                            .weight(.bold)
                    )
                    .foregroundStyle(genralVm.isDark ? Color(Colors().darkBodyText): Color(Colors().lightBodyText))
                Spacer()
                
                Text(subTitle)
                    .font(
                        Font.custom(Fonts().getFontBold(), size: 15)
                            .weight(.bold)
                    )
                    .foregroundStyle(genralVm.isDark ? Color(Colors().darkBodyText): Color(Colors().lightBodyText))
            }
            .padding()
            .background(genralVm.isDark ? Color(Colors().darkBtnMenu): Color(Colors().lightBtnMenu))
            .cornerRadius(12)
        }
    }
}


