//
//  ParagraphView.swift
//  FPLS-Dev
//
//  Created by Omar pakr on 15/11/2023.
//

import SwiftUI
import RichText
import BottomSheetSwiftUI

@available(iOS 16.0, *)
struct ParagraphView: View {
    @StateObject private var detector = ScreenRecordingDetector()
    @StateObject private var genralVm : GeneralVm = GeneralVm()
    @StateObject private var timerViewModel : TimerViewModel = TimerViewModel()
    @StateObject private var paragraphViewVm : ParagraphViewVm = ParagraphViewVm()
    @StateObject private var educationCourseDetailsVm : EducationCourseDetailsVm = EducationCourseDetailsVm()
    
    @State private var showDescriptionImage: BottomSheetPosition = .hidden
    @State private var showSubmitExam: BottomSheetPosition = .hidden
    let switchablePositions: [BottomSheetPosition] = [.dynamic]
    @State private var visualEffect  = VisualEffect.systemDark
    let row = GridItem(.fixed(50), spacing: 5, alignment: .center)
    
    var body: some View {
        NavigationStack {
                if let examParagraphsInfoData = self.paragraphViewVm.startStudentExamData.educationalExamInfoData?.examParagraphsInfoData, !examParagraphsInfoData.isEmpty {
                    
                    VStack(alignment: .center, spacing: 5){
                        Text(self.paragraphViewVm.startStudentExamData.educationalExamInfoData?.educationalExamTitle ?? "")
                            .font( Font.custom(Fonts().getFontBold(), size: 20).weight(.bold))
                            .foregroundStyle(genralVm.isDark ? Color(Colors().darkBodyText): Color(Colors().lightBodyText))
                            .lineLimit(1)
                        
                        Text(timerViewModel.formattedTime)
                            .font( Font.custom(Fonts().getFontBold(), size: 18).weight(.bold))
                            .foregroundStyle(genralVm.isDark ? Color.red : Color.red)
                        
                        ButtonAction(text: NSLocalizedString("submit", comment: ""),
                                     textSize: 20,
                                     color: .green) {
                            self.showSubmitExam = .dynamic
                        }
                                     .padding(.all, 10)
                        
                        ScrollView(.horizontal,showsIndicators: false) {
                            LazyHGrid(rows: [row]) {
                                ForEach(self.paragraphViewVm.startStudentExamData.educationalExamInfoData?.examParagraphsInfoData ?? [ExamParagraphsInfoData]() ,id:\.examParagraphToken) { pragraph in
                                    HStack (spacing : 10){
                                        
                                        Image("paragraph")
                                            .resizable()
                                            .frame(width: 20)
                                            .clipShape(Circle())
                                        
                                        Text(pragraph.examParagraphTitle!)
                                            .foregroundStyle(genralVm.isDark ? Color(Colors().darkBodyText): Color(Colors().lightBodyText))
                                            .font(
                                                Font.custom(Fonts().getFontBold(), size: 18).weight(.bold))
                                            .onTapGesture {
                                                self.paragraphViewVm.selectedParagraph = pragraph
                                                self.paragraphViewVm.setMcqTfQuestions()
                                                paragraphViewVm.getAndSetQuestions(pragraph: self.paragraphViewVm.selectedParagraph!)
                                            }
                                    }
                                    .padding()
                                    .onAppear{
                                        if ((self.paragraphViewVm.startStudentExamData.educationalExamInfoData?.examParagraphsInfoData?.indices.contains(0)) != nil) {
                                            self.paragraphViewVm.selectedParagraph = self.paragraphViewVm.startStudentExamData.educationalExamInfoData?.examParagraphsInfoData?[0]
                                            self.paragraphViewVm.setMcqTfQuestions()
                                            self.paragraphViewVm.showMCQList = true
                                            self.paragraphViewVm.getAndSetQuestions(pragraph: self.paragraphViewVm.selectedParagraph!)
                                            
                                        }
                                    }
                                    .onLongPressGesture(perform: {
                                        if pragraph.examParagraphDescription != "" {
                                            
                                        }
                                    })
                                    .background(self.paragraphViewVm.selectedParagraph?.examParagraphToken == pragraph.examParagraphToken ? (genralVm.isDark ? Color(Colors().darkBtnMenu): Color(Colors().lightBtnMenu)): Color.gray.opacity(0.3))
                                    .cornerRadius(15)
                                    
                                }
                            }
                            
                        }
                        .padding(.horizontal, 5)
                        .padding(.vertical, 10)
                        .offset(y:-40)
                        
                        HStack(alignment: .center, spacing: 10) {
                            if paragraphViewVm.mcqList.count > 0 {
                                Button {
                                    self.paragraphViewVm.setMcqTfQuestions()
                                    self.paragraphViewVm.showMCQList = true
                                    self.paragraphViewVm.showTrueFalseList = false
                                    
                                } label: {
                                    Text(NSLocalizedString("mcq", comment: ""))
                                        .font(
                                            Font.custom(Fonts().getFontBold(), size: 15)
                                                .weight(.bold)
                                        )
                                        .foregroundStyle(genralVm.isDark ? Color(Colors().darkBodyText): Color(Colors().lightBodyText))
                                }
                                .frame(width: 150, height: 58, alignment: .center)
                                .background(paragraphViewVm.showMCQList ? Color.green : Color.red.opacity(0.5))
                                .cornerRadius(10)
                            }
                            if paragraphViewVm.trueFalseList.count > 0 {
                                
                                
                                Button {
                                    self.paragraphViewVm.setMcqTfQuestions()
                                    self.paragraphViewVm.showTrueFalseList = true
                                    self.paragraphViewVm.showMCQList = false
                                    
                                } label: {
                                    Text(NSLocalizedString("trueFalse", comment: ""))
                                        .font(
                                            Font.custom(Fonts().getFontBold(), size: 15)
                                                .weight(.bold)
                                        )
                                        .foregroundStyle(genralVm.isDark ? Color(Colors().darkBodyText): Color(Colors().lightBodyText))
                                }
                                .frame(width: 150, height: 58, alignment: .center)
                                .background(paragraphViewVm.showTrueFalseList ? Color.green : Color.red.opacity(0.5))
                                .cornerRadius(10)
                            }
                        }
                        .padding(.vertical, 5)
                        .padding(.horizontal, 15)
                        .offset(y:-70)
                        
                        ScrollView(showsIndicators: false){
                            VStack {
                                VStack {
                                    
                                    Text(SplitHtmlContent.parseHTML(htmlString:self.paragraphViewVm.showMCQList ? self.paragraphViewVm.mcqList[paragraphViewVm.currentQuestionIndex].questionTitle ?? "" : self.paragraphViewVm.showTrueFalseList ? self.paragraphViewVm.trueFalseList[paragraphViewVm.currentQuestionIndex].questionTitle ?? "" : self.paragraphViewVm.selectedParagraph?.paragraphQuestionsWithoutAnswer?[paragraphViewVm.currentQuestionIndex].questionTitle ?? "").text)
                                        .font(
                                            Font.custom(Fonts().getFontBold(), size: 20)
                                                .weight(.bold)
                                        )
                                        .foregroundStyle(genralVm.isDark ? Color(Colors().darkBodyText): Color(Colors().lightBodyText))
                                    
                                    if (SplitHtmlContent.parseHTML(htmlString: self.paragraphViewVm.showMCQList ? self.paragraphViewVm.mcqList[paragraphViewVm.currentQuestionIndex].questionTitle ?? "" : self.paragraphViewVm.showTrueFalseList ? self.paragraphViewVm.trueFalseList[paragraphViewVm.currentQuestionIndex].questionTitle ?? "" : self.paragraphViewVm.selectedParagraph?.paragraphQuestionsWithoutAnswer?[paragraphViewVm.currentQuestionIndex].questionTitle ?? "").imageUrls.indices.contains(0)){
                                        HStack(alignment: .center, spacing: 5 ){
                                            Image("svg-image")
                                                .resizable()
                                                .frame(width:30,height:30)
                                            
                                            Text(NSLocalizedString("tab_showing_image", comment: ""))
                                                .font(
                                                    Font.custom(Fonts().getFontBold(), size: 18)
                                                        .weight(.bold)
                                                )
                                                .foregroundStyle(genralVm.isDark ? Color(Colors().darkBodyText): Color(Colors().lightBodyText))
                                        }
                                    }
                                    
                                }
                                .padding(.all, 5)
                                .onTapGesture {
                                    if (SplitHtmlContent.parseHTML(htmlString: self.paragraphViewVm.showMCQList ? self.paragraphViewVm.mcqList[paragraphViewVm.currentQuestionIndex].questionTitle ?? "" : self.paragraphViewVm.showTrueFalseList ? self.paragraphViewVm.trueFalseList[paragraphViewVm.currentQuestionIndex].questionTitle ?? "" : self.paragraphViewVm.selectedParagraph?.paragraphQuestionsWithoutAnswer?[paragraphViewVm.currentQuestionIndex].questionTitle ?? "").imageUrls.indices.contains(0)){
                                        
                                        
                                        
                                        let htmlString = self.paragraphViewVm.showMCQList ? self.paragraphViewVm.mcqList[paragraphViewVm.currentQuestionIndex].questionTitle ?? "" : self.paragraphViewVm.showTrueFalseList ? self.paragraphViewVm.trueFalseList[paragraphViewVm.currentQuestionIndex].questionTitle ?? "" : self.paragraphViewVm.selectedParagraph?.paragraphQuestionsWithoutAnswer?[paragraphViewVm.currentQuestionIndex].questionTitle ?? ""
                                        
                                        let imageUrls = SplitHtmlContent.parseHTML(htmlString: htmlString).imageUrls
                                        UserDefaults.standard.set(imageUrls, forKey: "imageUrls")
                                        
                                        self.showDescriptionImage = .dynamic
                                    }
                                }
                                Divider()
                                    .frame(height: 3)
                                    .background(genralVm.isDark ? Color(Colors().darkCardBg): Color(Colors().lightCardBg))
                                    .padding(.horizontal, 20)
                                
                                
                                VStack{
                                    
                                    if self.paragraphViewVm.showMCQList == true {
                                        if let options = self.paragraphViewVm.mcqList[paragraphViewVm.currentQuestionIndex].opationsMCQ {
                                            ForEach(options,id:\.self) { option in
                                                HStack(spacing: 5){
                                                    CustomIcon(imageName: self.paragraphViewVm.selectedOptions[self.paragraphViewVm.mcqList[paragraphViewVm.currentQuestionIndex].paragraphQuestionToken ?? ""] == option ? "correct_check_box" : "uncorrect_check_box",
                                                               width: 40,
                                                               height: 40,
                                                               darkColor: self.paragraphViewVm.selectedOptions[self.paragraphViewVm.mcqList[paragraphViewVm.currentQuestionIndex].paragraphQuestionToken ?? ""] == option ? Color.green : Color(Colors().darkBodyText) ,
                                                               lightColor: self.paragraphViewVm.selectedOptions[self.paragraphViewVm.mcqList[paragraphViewVm.currentQuestionIndex].paragraphQuestionToken ?? ""] == option ? Color.green : Color(Colors().lightBodyText))
                                                    
                                                    Text(SplitHtmlContent.parseHTML(htmlString: option).text)
                                                        .font(
                                                            Font.custom(Fonts().getFontBold(), size: 18)
                                                                .weight(.bold)
                                                        )
                                                        .foregroundStyle(genralVm.isDark ? Color(Colors().darkBodyText): Color(Colors().lightBodyText))
                                                    
                                                }
                                                .onTapGesture {
                                                    withAnimation(.easeInOut) {
                                                        self.paragraphViewVm.selectedOptions[self.paragraphViewVm.mcqList[paragraphViewVm.currentQuestionIndex].paragraphQuestionToken ?? ""] = option
                                                    }
                                                    paragraphViewVm.saveAnswers(questionToken: self.paragraphViewVm.mcqList[paragraphViewVm.currentQuestionIndex].paragraphQuestionToken ?? "", answerToken: option, pragraph: self.paragraphViewVm.selectedParagraph!)
                                                    
                                                }
                                                .frame(maxWidth: .infinity, alignment: .leading)
                                                
                                                if SplitHtmlContent.parseHTML(htmlString: option).imageUrls.indices.contains(0) {
                                                    HStack(alignment: .center, spacing: 5 ){
                                                        Image("svg-image")
                                                            .resizable()
                                                            .frame(width: 25,height:25)
                                                        
                                                        Text(NSLocalizedString("tab_showing_choose_image", comment: ""))
                                                            .font(
                                                                Font.custom(Fonts().getFontBold(), size: 15)
                                                                    .weight(.bold)
                                                            )
                                                            .foregroundStyle(genralVm.isDark ? Color(Colors().darkBodyText): Color(Colors().lightBodyText))
                                                    }
                                                    .onTapGesture {
                                                        let imageUrls = SplitHtmlContent.parseHTML(htmlString: option).imageUrls
                                                        UserDefaults.standard.set(imageUrls, forKey: "imageUrls")
                                                        self.showDescriptionImage = .dynamic
                                                    }
                                                }
                                                Divider()
                                                    .frame(height: 1)
                                                    .background(genralVm.isDark ? Color(Colors().lightCardBg): Color(Colors().darkCardBg))
                                                    .padding(.horizontal, 80)
                                            }
                                            .onAppear {
                                                paragraphViewVm.getAndSetQuestions(pragraph: self.paragraphViewVm.selectedParagraph!)
                                            }
                                        }
                                        
                                    } else if self.paragraphViewVm.showTrueFalseList {
                                        VStack {
                                            HStack(spacing:10){
                                                CustomIcon(imageName: self.paragraphViewVm.selectedOptions[self.paragraphViewVm.trueFalseList[paragraphViewVm.currentQuestionIndex].paragraphQuestionToken ?? ""] == "True" ? "correct_check_box" : "uncorrect_check_box",
                                                           width: 40,
                                                           height: 40,
                                                           darkColor: self.paragraphViewVm.selectedOptions[self.paragraphViewVm.trueFalseList[paragraphViewVm.currentQuestionIndex].paragraphQuestionToken ?? ""] == "True" ? Color.green : Color(Colors().darkBodyText) ,
                                                           lightColor: self.paragraphViewVm.selectedOptions[self.paragraphViewVm.trueFalseList[paragraphViewVm.currentQuestionIndex].paragraphQuestionToken ?? ""] == "True" ? Color.green : Color(Colors().lightBodyText))
                                                
                                                .onTapGesture {
                                                    withAnimation(.easeInOut) {
                                                        self.paragraphViewVm.selectedOptions[self.paragraphViewVm.trueFalseList[paragraphViewVm.currentQuestionIndex].paragraphQuestionToken ?? ""] = "True"
                                                    }
                                                    paragraphViewVm.saveAnswers(questionToken: self.paragraphViewVm.trueFalseList[paragraphViewVm.currentQuestionIndex].paragraphQuestionToken ?? "", answerToken: "True", pragraph: self.paragraphViewVm.selectedParagraph!)
                                                    
                                                }
                                                Text(NSLocalizedString("right", comment: ""))
                                                    .font(
                                                        Font.custom(Fonts().getFontBold(), size: 15).weight(.bold))
                                            }
                                            
                                            HStack(spacing:10){
                                                CustomIcon(imageName: self.paragraphViewVm.selectedOptions[self.paragraphViewVm.trueFalseList[paragraphViewVm.currentQuestionIndex].paragraphQuestionToken ?? ""] == "False" ? "correct_check_box" : "uncorrect_check_box",
                                                           width: 40,
                                                           height: 40,
                                                           darkColor: self.paragraphViewVm.selectedOptions[self.paragraphViewVm.trueFalseList[paragraphViewVm.currentQuestionIndex].paragraphQuestionToken ?? ""] == "False" ? Color.red : Color(Colors().darkBodyText) ,
                                                           lightColor: self.paragraphViewVm.selectedOptions[self.paragraphViewVm.trueFalseList[paragraphViewVm.currentQuestionIndex].paragraphQuestionToken ?? ""] == "False" ? Color.red : Color(Colors().lightBodyText))
                                                
                                                
                                                .onTapGesture {
                                                    withAnimation(.easeInOut) {
                                                        self.paragraphViewVm.selectedOptions[self.paragraphViewVm.trueFalseList[paragraphViewVm.currentQuestionIndex].paragraphQuestionToken ?? ""] = "False"
                                                    }
                                                    paragraphViewVm.saveAnswers(questionToken: self.paragraphViewVm.trueFalseList[paragraphViewVm.currentQuestionIndex].paragraphQuestionToken ?? "", answerToken: "False", pragraph: self.paragraphViewVm.selectedParagraph!)
                                                    
                                                }
                                                Text(NSLocalizedString("wrong", comment: ""))
                                                    .font(
                                                        Font.custom(Fonts().getFontBold(), size: 15).weight(.bold))
                                            }
                                        }
                                        .onAppear {
                                            paragraphViewVm.getAndSetQuestions(pragraph: self.paragraphViewVm.selectedParagraph!)
                                        }
                                    } else {
                                        EmptyView()
                                    }
                                }
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding()
                            }
                        }
                        .padding(.top, -70)
                        
                        Spacer()
                        
                        HStack {
                            if paragraphViewVm.showMCQList {
                                if (paragraphViewVm.mcqList.indices.contains(0)) {
                                    if (paragraphViewVm.currentQuestionIndex > 0 &&
                                        paragraphViewVm.currentQuestionIndex < paragraphViewVm.mcqList.count ) {
                                        Button {
                                            if (paragraphViewVm.currentQuestionIndex > 0 &&
                                                paragraphViewVm.currentQuestionIndex <= paragraphViewVm.mcqList.count ){
                                                paragraphViewVm.currentQuestionIndex -= 1
                                            } else {
                                                paragraphViewVm.currentQuestionIndex = 0
                                            }
                                            self.paragraphViewVm.getAndSetQuestions(pragraph: self.paragraphViewVm.selectedParagraph!)
                                            
                                        } label: {
                                            if self.paragraphViewVm.lang == genralVm.constants.APP_IOS_LANGUAGE_AR {
                                                CustomIcon(imageName: "next",
                                                           width: 40,
                                                           height: 40,
                                                           darkColor: Color(Colors().darkBodyText),
                                                           lightColor: Color(Colors().lightBodyText))
                                                
                                            } else {
                                                CustomIcon(imageName: "prev",
                                                           width: 40,
                                                           height: 40,
                                                           darkColor: Color(Colors().darkBodyText),
                                                           lightColor: Color(Colors().lightBodyText))
                                                
                                            }
                                        }
                                    }
                                }
                            }
                            else if paragraphViewVm.showTrueFalseList {
                                if (paragraphViewVm.trueFalseList.indices.contains(0)) {
                                    if (paragraphViewVm.currentQuestionIndex > 0 &&
                                        paragraphViewVm.currentQuestionIndex < paragraphViewVm.trueFalseList.count ){
                                        Button {
                                            if (paragraphViewVm.currentQuestionIndex > 0 &&
                                                paragraphViewVm.currentQuestionIndex <= paragraphViewVm.trueFalseList.count ){
                                                paragraphViewVm.currentQuestionIndex -= 1
                                            } else {
                                                paragraphViewVm.currentQuestionIndex = 0
                                            }
                                            self.paragraphViewVm.getAndSetQuestions(pragraph: self.paragraphViewVm.selectedParagraph!)
                                            
                                        } label: {
                                            if self.paragraphViewVm.lang == genralVm.constants.APP_IOS_LANGUAGE_AR {
                                                CustomIcon(imageName: "next",
                                                           width: 40,
                                                           height: 40,
                                                           darkColor: Color(Colors().darkBodyText),
                                                           lightColor: Color(Colors().lightBodyText))
                                            } else {
                                                CustomIcon(imageName: "prev",
                                                           width: 40,
                                                           height: 40,
                                                           darkColor: Color(Colors().darkBodyText),
                                                           lightColor: Color(Colors().lightBodyText))
                                            }
                                        }
                                    }
                                }
                            }
                            
                            VStack {
                                HStack {
                                    Text(NSLocalizedString("quesNum", comment: ""))
                                    Text("\(self.paragraphViewVm.currentQuestionIndex + 1)")
                                    Text(NSLocalizedString("from", comment: ""))
                                    
                                    if paragraphViewVm.showMCQList {
                                        Text("\(self.paragraphViewVm.mcqList.count)")
                                    } else if paragraphViewVm.showTrueFalseList {
                                        Text("\(self.paragraphViewVm.trueFalseList.count)")
                                    } else {
                                        Text("\(self.paragraphViewVm.selectedParagraph?.paragraphQuestionsWithoutAnswer?.count ?? 0)")
                                    }
                                    
                                }
                                .font(
                                    Font.custom(Fonts().getFontBold(), size: 15).weight(.bold))
                                .foregroundStyle(genralVm.isDark ? Color(Colors().darkBodyText): Color(Colors().lightBodyText))
                                
                                Divider()
                                    .frame(height: 2)
                                    .background(genralVm.isDark ? Color(Colors().darkBodyText): Color(Colors().lightBodyText))
                                    .padding(.horizontal, 20)
                                
                                HStack {
                                    Text(NSLocalizedString("quesDgree", comment: ""))
                                    if paragraphViewVm.showMCQList {
                                        Text(String(format:"%.1f",self.paragraphViewVm.mcqList[paragraphViewVm.currentQuestionIndex].questionDegree ?? 0.0))
                                        
                                    } else if paragraphViewVm.showTrueFalseList {
                                        Text(String(format:"%.1f",self.paragraphViewVm.trueFalseList[paragraphViewVm.currentQuestionIndex].questionDegree ?? 0.0))
                                        
                                    } else {
                                        Text(String(format:"%.1f",self.paragraphViewVm.selectedParagraph?.paragraphQuestionsWithoutAnswer?[paragraphViewVm.currentQuestionIndex].questionDegree ?? 0.0))
                                        
                                    }
                                }
                                
                                .font(
                                    Font.custom(Fonts().getFontBold(), size: 15).weight(.bold))
                                .foregroundStyle(genralVm.isDark ? Color(Colors().darkBodyText): Color(Colors().lightBodyText))
                            }
                            
                            if paragraphViewVm.showMCQList {
                                if (paragraphViewVm.mcqList.indices.contains(0)) {
                                    if (self.paragraphViewVm.mcqList.count) > 1 {
                                        Button {
                                            if paragraphViewVm.currentQuestionIndex < (paragraphViewVm.mcqList.count) - 1 {
                                                paragraphViewVm.currentQuestionIndex += 1
                                            } else {
                                                paragraphViewVm.currentQuestionIndex = 0
                                            }
                                            self.paragraphViewVm.getAndSetQuestions(pragraph: self.paragraphViewVm.selectedParagraph!)
                                            
                                        } label: {
                                            if self.paragraphViewVm.lang == genralVm.constants.APP_IOS_LANGUAGE_AR {
                                                CustomIcon(imageName: "prev",
                                                           width: 40,
                                                           height: 40,
                                                           darkColor: Color(Colors().darkBodyText),
                                                           lightColor: Color(Colors().lightBodyText))
                                            } else {
                                                CustomIcon(imageName: "next",
                                                           width: 40,
                                                           height: 40,
                                                           darkColor: Color(Colors().darkBodyText),
                                                           lightColor: Color(Colors().lightBodyText))
                                            }
                                        }
                                    }
                                }
                            }
                            else if paragraphViewVm.showTrueFalseList {
                                if (paragraphViewVm.trueFalseList.indices.contains(0)) {
                                    if (self.paragraphViewVm.trueFalseList.count) > 1 {
                                        Button {
                                            if paragraphViewVm.currentQuestionIndex < (paragraphViewVm.trueFalseList.count) - 1 {
                                                paragraphViewVm.currentQuestionIndex += 1
                                            } else {
                                                paragraphViewVm.currentQuestionIndex = 0
                                            }
                                            self.paragraphViewVm.getAndSetQuestions(pragraph: self.paragraphViewVm.selectedParagraph!)
                                            
                                        } label: {
                                            if self.paragraphViewVm.lang == genralVm.constants.APP_IOS_LANGUAGE_AR {
                                                CustomIcon(imageName: "prec",
                                                           width: 40,
                                                           height: 40,
                                                           darkColor: Color(Colors().darkBodyText),
                                                           lightColor: Color(Colors().lightBodyText))
                                            } else {
                                                CustomIcon(imageName: "next",
                                                           width: 40,
                                                           height: 40,
                                                           darkColor: Color(Colors().darkBodyText),
                                                           lightColor: Color(Colors().lightBodyText))
                                            }
                                        }
                                    }
                                }
                            }
                            
                        }
                    }
                    
                    
                }else{
                    if !(self.paragraphViewVm.showLoading) {
                        NoContent(message: NSLocalizedString("message_no_education_cours_levels", comment: ""))
                    }else {
                        NoContent(message: NSLocalizedString("loading", comment: ""), image: "loading_circles_blue_gradient")
                    }
                }
        }
        .background(genralVm.isDark ? Color(Colors().darkBodyBg): Color(Colors().lightBodyBg))
        .ipad()
        .toastView(toast: $paragraphViewVm.toast)
        
        .onAppear{
            self.timerViewModel.startTimer()
            self.loadExamData()
        }
        .bottomSheet(
            bottomSheetPosition: $showDescriptionImage,
            switchablePositions: switchablePositions,
            headerContent: {},
            mainContent: {
                
                let imageUrls = UserDefaults.standard.array(forKey: "imageUrls") as? [String]
                
                VStack(spacing: 0) {
                    List(imageUrls ?? [], id: \.self) { url in
                        WebViewHtmlImageList(imageUrls: [url], detector: detector)
                            .frame(height: 300)
                    }
                    .listStyle(PlainListStyle())
                    
                    ButtonAction(text: NSLocalizedString("close", comment: ""),
                                 textSize: 20,
                                 color: .red) {
                        self.showDescriptionImage = .hidden
                    }
                                 .padding()
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
        )
        .enableSwipeToDismiss(false)
        .enableTapToDismiss(false)
        .enableBackgroundBlur(true)
        .enableContentDrag(true)
        .backgroundBlurMaterial(visualEffect)
        
        .bottomSheet(
                    bottomSheetPosition: $showSubmitExam,
                    switchablePositions: switchablePositions,
                    headerContent: {},
                    mainContent: {
                        CustomPopupContentView(iconName: "logout_button",
                                               title: NSLocalizedString("alert", comment: ""),
                                               message: NSLocalizedString("msgSubmitExam", comment: ""),
                                               buttonOneAction: {
                            
                            self.showSubmitExam = .hidden
                            self.paragraphViewVm.submitExam()
                            
                        },
                                               buttonOneTitle: NSLocalizedString("submit", comment: ""),
                                               buttonOneColor: .green,
                                               numAction: 1)
                        
                    }
                    
                )
                .enableSwipeToDismiss(false)
                .enableTapToDismiss(true)
                .enableBackgroundBlur(true)
                .enableContentDrag(true)
                .backgroundBlurMaterial(visualEffect)
        
        .overlay(
            self.paragraphViewVm.showLoading ?
            GeometryReader { geometry in
                ZStack {
                    LoadingView(placHolder: NSLocalizedString("loading", comment: ""))
                        .frame(width: geometry.size.width, height: geometry.size.height)
                        .transition(.scale)
                } } : nil
        )
      
        .fullScreenCover(isPresented: $paragraphViewVm.examSubmittedSuccess, content: {
            CoursesInfoTapView()
        })
        
        .onDisappear {
            paragraphViewVm.backGeasture = false
            paragraphViewVm.showQuestions = false
            self.paragraphViewVm.showLoading = false
            paragraphViewVm.toggleAnswerFalse = false
            paragraphViewVm.toggleAnswerRight = false
            paragraphViewVm.examSubmittedSuccess = false
            paragraphViewVm.showMCQList = false
            paragraphViewVm.showTrueFalseList = false
        }
    }
    
    func loadExamData() {
        self.paragraphViewVm.showLoading = true
        if let savedData = UserDefaults.standard.data(forKey: "examParagraphsInfoData") {
               do {
                   self.paragraphViewVm.startStudentExamData = try JSONDecoder().decode(ExamPargraphInfo.self, from: savedData)
                   self.paragraphViewVm.showLoading = false
                   print("Data loaded successfully.")
               } catch {
                   self.paragraphViewVm.showLoading = false
                   print("Error decoding data: \(error)")
               }
           } else {
               self.paragraphViewVm.showLoading = false
           }
       }

}

