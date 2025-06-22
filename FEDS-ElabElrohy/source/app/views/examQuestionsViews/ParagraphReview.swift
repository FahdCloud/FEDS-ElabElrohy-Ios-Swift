//
//  ParagraphReview.swift
//  FEDS-Center-Dev-IOS
//
//  Created by Mrwan on 24/06/2024.
//

import SwiftUI
import RichText
import BottomSheetSwiftUI

@available(iOS 16.0, *)
struct ParagraphReview: View {
    @StateObject private var detector = ScreenRecordingDetector()
    @StateObject private var genralVm : GeneralVm = GeneralVm()
    @StateObject private var paragraphViewVm : ParagraphViewVm = ParagraphViewVm()
    
    @State private var showDescriptionImage: BottomSheetPosition = .hidden
    let switchablePositions: [BottomSheetPosition] = [.dynamic]
    @State private var visualEffect  = VisualEffect.systemDark
    
    @State var examParagraphsInfoData : [ExamParagraphsInfoData] = []
    @State private var backGeasture : Bool = false
    @State private var showLoading : Bool = false
    @State private var toast: Toast? = nil
    @State private var currentQuestionIndex = 0
    @State private var selectedParagraph: ExamParagraphsInfoData?
    @State private var showMCQList = false
    @State private var showTrueFalseList = false
    @State private var mcqList: [ParagraphQuestionsWithAnswer] = []
    @State private var trueFalseList: [ParagraphQuestionsWithAnswer] = []
    @State private var answersFinished = [QuestionAnswer]()
    @State private var questionAnswer :String = ""
    
    var educationGroupTimeToken : String
    let isReview = UserDefaultss().restoreBool(key: "isReview")
    let studentExamToken = UserDefaultss().restoreString(key: "studentExamToken")
    let row = GridItem(.fixed(50), spacing: 5, alignment: .center)
    
    var body: some View {
        NavigationStack {
            VStack {
                if examParagraphsInfoData.isEmpty {
                    NoContent(message: NSLocalizedString("message_no_paragraphs", comment: ""))
                } else {
                    VStack(alignment: .center, spacing: 5){
                        Text(self.paragraphViewVm.startStudentExamData.educationalExamInfoData?.educationalExamTitle ?? "")
                            .font( Font.custom(Fonts().getFontBold(), size: 20).weight(.bold))
                            .foregroundStyle(genralVm.isDark ? Color(Colors().darkBodyText): Color(Colors().lightBodyText))
                            .lineLimit(1)
                        
                        ScrollView(.horizontal,showsIndicators: false) {
                            LazyHGrid(rows: [row]) {
                                ForEach(examParagraphsInfoData,id:\.examParagraphToken) { pragraph in
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
                                                self.selectedParagraph = pragraph
                                                self.currentQuestionIndex = 0
                                                let (mcq, trueFalse) = separateQuestions(paragraphs: self.selectedParagraph?.paragraphQuestionsWithAnswer ?? [])
                                                self.mcqList = mcq
                                                self.trueFalseList = trueFalse
                                                getAndSetQuestions(pragraph: self.selectedParagraph!)
                                            }
                                    }
                                    .onAppear(perform: {
                                        if examParagraphsInfoData.indices.contains(0) {
                                            self.selectedParagraph = examParagraphsInfoData[0]
                                            let (mcq, trueFalse) = separateQuestions(paragraphs: self.selectedParagraph?.paragraphQuestionsWithAnswer ?? [])
                                            self.showMCQList = true
                                            self.mcqList = mcq
                                            self.trueFalseList = trueFalse
                                            getAndSetQuestions(pragraph: self.selectedParagraph!)
                                            
                                        }
                                    })
                                    .onLongPressGesture(perform: {
                                        if pragraph.examParagraphDescription != "" {
                                            
                                        }
                                    })
                                    .padding()
                                    .background(self.selectedParagraph?.examParagraphToken == pragraph.examParagraphToken ? (genralVm.isDark ? Color(Colors().darkBtnMenu): Color(Colors().lightBtnMenu)): Color.gray.opacity(0.3))
                                    .cornerRadius(15)
                                    
                                }
                            }
                            .padding(.horizontal, 5)
                            .padding(.vertical, 10)
                            .offset(y:-30)
                        }
                        
                        HStack(alignment: .center, spacing: 10) {
                            if mcqList.count > 0 {
                                
                                HStack(alignment: .center, spacing: 5) {
                                    Button {
                                        self.currentQuestionIndex = 0
                                        let (mcq, trueFalse) = separateQuestions(paragraphs: self.selectedParagraph?.paragraphQuestionsWithAnswer ?? [])
                                        self.mcqList = mcq
                                        self.trueFalseList = trueFalse
                                        self.showMCQList = true
                                        self.showTrueFalseList = false
                                        
                                    } label: {
                                        Text(NSLocalizedString("mcq", comment: ""))
                                            .font(
                                                Font.custom(Fonts().getFontBold(), size: 15)
                                                    .weight(.bold)
                                            )
                                            .foregroundStyle(genralVm.isDark ? Color(Colors().darkBodyText): Color(Colors().lightBodyText))
                                    }
                                }
                                .frame(width: 150, height: 58, alignment: .center)
                                .background(showMCQList ? Color.green : Color.red.opacity(0.5))
                                .cornerRadius(10)
                            }
                            
                            if trueFalseList.count > 0 {
                                
                                HStack(alignment: .center, spacing: 5) {
                                    
                                    Button {
                                        self.currentQuestionIndex = 0
                                        let (mcq, trueFalse) = separateQuestions(paragraphs: self.selectedParagraph?.paragraphQuestionsWithAnswer ?? [])
                                        self.mcqList = mcq
                                        self.trueFalseList = trueFalse
                                        self.showTrueFalseList = true
                                        self.showMCQList = false
                                        
                                    } label: {
                                        Text(NSLocalizedString("trueFalse", comment: ""))
                                            .font(
                                                Font.custom(Fonts().getFontBold(), size: 15)
                                                    .weight(.bold)
                                            )
                                            .foregroundStyle(genralVm.isDark ? Color(Colors().darkBodyText): Color(Colors().lightBodyText))
                                    }
                                }
                                .frame(width: 150, height: 58, alignment: .center)
                                .background(showTrueFalseList ? Color.green : Color.red.opacity(0.2))
                                .cornerRadius(10)
                            }
                        }
                        .padding(.vertical, 5)
                        .padding(.horizontal, 15)
                        .offset(y:-70)
                        
                        
                        ScrollView(showsIndicators: false) {
                            VStack {
                                VStack {
                                    Text(SplitHtmlContent.parseHTML(htmlString: self.showMCQList ? self.mcqList[currentQuestionIndex].questionTitle ?? "" : self.showTrueFalseList ? self.trueFalseList[currentQuestionIndex].questionTitle ?? "" : self.selectedParagraph?.paragraphQuestionsWithoutAnswer?[currentQuestionIndex].questionTitle ?? "" ).text)
                                        .font(
                                            Font.custom(Fonts().getFontBold(), size: 20)
                                                .weight(.bold)
                                        )
                                        .foregroundStyle(genralVm.isDark ? Color(Colors().darkBodyText): Color(Colors().lightBodyText))
                                    
                                    if SplitHtmlContent.parseHTML(htmlString: self.showMCQList ? self.mcqList[currentQuestionIndex].questionTitle ?? "" : self.showTrueFalseList ? self.trueFalseList[currentQuestionIndex].questionTitle ?? "" : self.selectedParagraph?.paragraphQuestionsWithoutAnswer?[currentQuestionIndex].questionTitle ?? "").imageUrls.indices.contains(0) {
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
                                    if SplitHtmlContent.parseHTML(htmlString: self.showMCQList ? self.mcqList[currentQuestionIndex].questionTitle ?? "" : self.showTrueFalseList ? self.trueFalseList[currentQuestionIndex].questionTitle ?? "" : self.selectedParagraph?.paragraphQuestionsWithoutAnswer?[currentQuestionIndex].questionTitle ?? "").imageUrls.indices.contains(0) {
                                        
                                        
                                        
                                        let htmlString = self.showMCQList ? self.mcqList[paragraphViewVm.currentQuestionIndex].questionTitle ?? "" : self.showTrueFalseList ? self.trueFalseList[paragraphViewVm.currentQuestionIndex].questionTitle ?? "" : self.selectedParagraph?.paragraphQuestionsWithoutAnswer?[currentQuestionIndex].questionTitle ?? ""
                                        
                                        let imageUrls = SplitHtmlContent.parseHTML(htmlString: htmlString).imageUrls
                                        UserDefaults.standard.set(imageUrls, forKey: "imageUrls")
                                        
                                        self.showDescriptionImage = .dynamic
                                    }
                                }
                                Divider()
                                    .frame(height: 3)
                                    .background(genralVm.isDark ? Color(Colors().darkCardBg): Color(Colors().lightCardBg))
                                    .padding(.horizontal, 20)
                                
                                VStack (alignment: .leading){
                                    
                                    if self.showMCQList == true {
                                        if let options = self.mcqList[currentQuestionIndex].opationsMCQ {
                                            ForEach(options,id:\.self) { option in
                                                VStack{
                                                HStack{
                                                    
                                                    Image(self.mcqList[currentQuestionIndex].studentAnswer == option ? "correct_check_box" : "uncorrect_check_box")
                                                        .resizable()
                                                        .frame(width:40,height:40)
                                                    
                                                    Text(SplitHtmlContent.parseHTML(htmlString: option).text)
                                                        .font(
                                                            Font.custom(Fonts().getFontBold(), size: 20)
                                                                .weight(.bold)
                                                        )
                                                        .foregroundStyle(genralVm.isDark ? Color(Colors().darkBodyText): Color(Colors().lightBodyText))
                                                    
                                                    Spacer()
                                                    
                                                    Image( self.mcqList[currentQuestionIndex].systemTrueAnswer! == option ? "true_icon" : "false_icon")
                                                        .resizable()
                                                        .frame(width:40,height:40)
                                                    
                                                }
                                                    
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
                                            }
                                            .onAppear {
                                                getAndSetQuestions(pragraph: self.selectedParagraph!)
                                            }
                                        }
                                        
                                    } else if self.showTrueFalseList {
                                        VStack {
                                            HStack(spacing:10){
                                                Image(self.trueFalseList[currentQuestionIndex].studentAnswer?.lowercased() == "True".lowercased() ? "correct_check_box" : "uncorrect_check_box")
                                                    .resizable()
                                                    .frame(width:40,height:40)
                                                
                                                Text(NSLocalizedString("right", comment: ""))
                                                    .font(
                                                        Font.custom(Fonts().getFontBold(), size: 16)
                                                            .weight(.bold)
                                                    )
                                                    .foregroundStyle(genralVm.isDark ? Color(Colors().darkBodyText): Color(Colors().lightBodyText))
                                                
                                                Spacer()
                                                
                                                Image(self.trueFalseList[currentQuestionIndex].systemTrueAnswer?.lowercased() ==  "True".lowercased()  ? "true_icon" : "false_icon")
                                                    .resizable()
                                                    .frame(width:40,height:40)
                                                
                                            }
                                            
                                            HStack(spacing:10){
                                                Image(self.trueFalseList[currentQuestionIndex].studentAnswer?.lowercased() == "False".lowercased() ? "correct_check_box" : "uncorrect_check_box")
                                                    .resizable()
                                                    .frame(width:40,height:40)
                                                
                                                Text(NSLocalizedString("wrong", comment: ""))
                                                    .font(
                                                        Font.custom(Fonts().getFontBold(), size: 16)
                                                            .weight(.bold)
                                                    )
                                                    .foregroundStyle(genralVm.isDark ? Color(Colors().darkBodyText): Color(Colors().lightBodyText))
                                                Spacer()
                                                
                                                Image(self.trueFalseList[currentQuestionIndex].systemTrueAnswer?.lowercased() ==  "False".lowercased()  ? "true_icon" : "false_icon")
                                                    .resizable()
                                                    .frame(width:40,height:40)
                                            }
                                        }
                                        .onAppear {
                                            getAndSetQuestions(pragraph: self.selectedParagraph!)
                                        }
                                    } else {
                                        EmptyView()
                                    }
                                }
                            }
                        }
                        .padding(.horizontal, 10)
                        .padding(.top, -70)

                        Spacer()
                        HStack {
                            if self.showMCQList {
                                if (self.mcqList.indices.contains(0)) {
                                    if (self.currentQuestionIndex > 0 &&
                                        self.currentQuestionIndex < self.mcqList.count ) {
                                        Button {
                                            if (self.currentQuestionIndex > 0 &&
                                                self.currentQuestionIndex <= self.mcqList.count ){
                                                self.currentQuestionIndex -= 1
                                            } else {
                                                self.currentQuestionIndex = 0
                                            }
                                            self.getAndSetQuestions(pragraph: self.selectedParagraph!)
                                            
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
                            else if self.showTrueFalseList {
                                if (self.trueFalseList.indices.contains(0)) {
                                    if (self.currentQuestionIndex > 0 &&
                                        self.currentQuestionIndex < self.trueFalseList.count ){
                                        Button {
                                            if (self.currentQuestionIndex > 0 &&
                                                self.currentQuestionIndex <= self.trueFalseList.count ){
                                                self.currentQuestionIndex -= 1
                                            } else {
                                                self.currentQuestionIndex = 0
                                            }
                                            self.getAndSetQuestions(pragraph: self.selectedParagraph!)
                                            
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
                                    Text("\(self.currentQuestionIndex + 1)")
                                    Text(NSLocalizedString("from", comment: ""))
                                    
                                    if self.showMCQList {
                                        Text("\(self.mcqList.count)")
                                    } else if self.showTrueFalseList {
                                        Text("\(self.trueFalseList.count)")
                                    } else {
                                        Text("\(self.selectedParagraph?.paragraphQuestionsWithAnswer?.count ?? 0)")
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
                                    if self.showMCQList {
                                        Text(String(format:"%.1f",self.mcqList[self.currentQuestionIndex].questionDegree ?? 0.0))
                                        
                                    } else if self.showTrueFalseList {
                                        Text(String(format:"%.1f",self.trueFalseList[self.currentQuestionIndex].questionDegree ?? 0.0))
                                        
                                    } else {
                                        Text(String(format:"%.1f",self.selectedParagraph?.paragraphQuestionsWithAnswer?[currentQuestionIndex].questionDegree ?? 0.0))
                                        
                                    }
                                }
                                .font(
                                    Font.custom(Fonts().getFontBold(), size: 15).weight(.bold))
                                .foregroundStyle(genralVm.isDark ? Color(Colors().darkBodyText): Color(Colors().lightBodyText))
                            }
                            
                            if self.showMCQList {
                                if (self.mcqList.indices.contains(0)) {
                                    if (self.mcqList.count) > 1 {
                                        Button {
                                            if self.currentQuestionIndex < (self.mcqList.count) - 1 {
                                                self.currentQuestionIndex += 1
                                            } else {
                                                self.currentQuestionIndex = 0
                                            }
                                            self.getAndSetQuestions(pragraph: self.selectedParagraph!)
                                            
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
                            else if self.showTrueFalseList {
                                if (self.trueFalseList.indices.contains(0)) {
                                    if (self.trueFalseList.count) > 1 {
                                        Button {
                                            if self.currentQuestionIndex < (self.trueFalseList.count) - 1 {
                                                self.currentQuestionIndex += 1
                                            } else {
                                                self.currentQuestionIndex = 0
                                            }
                                            self.getAndSetQuestions(pragraph: self.selectedParagraph!)
                                            
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
//                        HStack {
//                            
//                            VStack {
//                                HStack {
//                                    Text(NSLocalizedString("quesNum", comment: ""))
//                                    Text("\(self.currentQuestionIndex + 1)")
//                                    Text(NSLocalizedString("from", comment: ""))
//                                    
//                                    Text("\(self.selectedParagraph?.paragraphQuestionsWithAnswer?.count ?? 0)")
//                                    
//                                }
//                                .font(
//                                    Font.custom(Fonts().getFontBold(), size: 15).weight(.bold))
//                                Divider()
//                                
//                                HStack {
//                                    Text(NSLocalizedString("quesDgree", comment: ""))
//                                    Text(String(format:"%.1f",self.selectedParagraph?.paragraphQuestionsWithAnswer?[currentQuestionIndex].questionDegree ?? 0.0))
//                                }
//                                .font(
//                                    Font.custom(Fonts().getFontBold(), size: 15).weight(.bold))
//                                
//                            }
//                            if showMCQList {
//                                if (mcqList.indices.contains(0)) {
//                                    if (self.mcqList.count) > 1 {
//                                        Button {
//                                            if currentQuestionIndex < (mcqList.count) - 1 {
//                                                currentQuestionIndex += 1
//                                            } else {
//                                                currentQuestionIndex = 0
//                                            }
//                                            self.getAndSetQuestions(pragraph: self.selectedParagraph!)
//                                            
//                                        } label: {
//                                            if self.genralVm.lang == genralVm.constants.APP_IOS_LANGUAGE_AR {
//                                                Image("prev")
//                                                    .resizable()
//                                                    .frame(width:40,height:40)
//                                            } else {
//                                                Image("next")
//                                                    .resizable()
//                                                    .frame(width:40,height:40)
//                                            }
//                                        }
//                                    }
//                                }
//                            } else if showTrueFalseList {
//                                if (trueFalseList.indices.contains(0)) {
//                                    if (self.trueFalseList.count) > 1 {
//                                        Button {
//                                            if currentQuestionIndex < (trueFalseList.count) - 1 {
//                                                currentQuestionIndex += 1
//                                            } else {
//                                                currentQuestionIndex = 0
//                                            }
//                                            self.getAndSetQuestions(pragraph: self.selectedParagraph!)
//                                            
//                                        } label: {
//                                            if self.genralVm.lang == genralVm.constants.APP_IOS_LANGUAGE_AR {
//                                                Image("prev")
//                                                    .resizable()
//                                                    .frame(width:40,height:40)
//                                            } else {
//                                                Image("next")
//                                                    .resizable()
//                                                    .frame(width:40,height:40)
//                                            }
//                                        }
//                                    }
//                                }
//                            } else {
//                                if ((selectedParagraph?.paragraphQuestionsWithAnswer!.indices.contains(0)) != nil) {
//                                    if (self.selectedParagraph?.paragraphQuestionsWithoutAnswer?.count)! > 1 {
//                                        Button {
//                                            if currentQuestionIndex < (selectedParagraph?.paragraphQuestionsWithAnswer?.count)! - 1 {
//                                                currentQuestionIndex += 1
//                                            } else {
//                                                currentQuestionIndex = 0
//                                            }
//                                            self.getAndSetQuestions(pragraph: self.selectedParagraph!)
//                                            
//                                        } label: {
//                                            if self.genralVm.lang == genralVm.constants.APP_IOS_LANGUAGE_AR {
//                                                Image("prev")
//                                                    .resizable()
//                                                    .frame(width:40,height:40)
//                                            } else {
//                                                Image("next")
//                                                    .resizable()
//                                                    .frame(width:40,height:40)
//                                            }
//                                        }
//                                    }
//                                }
//                            }
//                        }
                    }
                }
            }
            .navigationBarItems(leading: CustomBackButton(){
                self.backGeasture.toggle()
            })
            
        }
        .background(genralVm.isDark ? Color(Colors().darkBodyBg): Color(Colors().lightBodyBg))
        .ipad()
        .toastView(toast: $toast)
        
        .onAppear{
            self.loadExamData()
        }
        .overlay(
            showLoading ?
            GeometryReader { geometry in
                ZStack {
                    LoadingView(placHolder: NSLocalizedString("loading", comment: ""))
                        .frame(width: geometry.size.width, height: geometry.size.height)
                        .transition(.scale)
                } } : nil
        )
        .fullScreenCover(isPresented: self.$backGeasture , content: {
            CoursesInfoTapView()
        })
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
    }
    
    func separateQuestions(paragraphs: [ParagraphQuestionsWithAnswer]) -> ([ParagraphQuestionsWithAnswer], [ParagraphQuestionsWithAnswer]) {
        let mcqList = paragraphs.filter { $0.questionTypeToken == "QST-2" }
        let trueFalseList = paragraphs.filter { $0.questionTypeToken == "QST-1" }
        
        return (mcqList, trueFalseList)
    }
    
    private func clearStatesWithAction(valueState: inout Bool) {
        valueState.toggle()
        self.backGeasture = false
    }
    
    func  getAndSetQuestions(pragraph : ExamParagraphsInfoData){
        if let data = UserDefaults.standard.data(forKey: "examAnswersData"){
            do {
                let decoder = JSONDecoder()
                let selectedData = try decoder.decode(SubmitExam.self, from: data)
                self.answersFinished = selectedData.questionAnswers ?? self.answersFinished
                if !isReview {
                    for selected in self.answersFinished {
                        if self.answersFinished.count > 0 {
                            if selected.paragraphQuestionToken == pragraph.paragraphQuestionsWithoutAnswer![currentQuestionIndex].paragraphQuestionToken ?? "" {
                                self.questionAnswer = selected.studentQuestionAnswer ?? ""
                            }
                        }
                    }
                } else {
                    for selected in self.answersFinished {
                        if self.answersFinished.count > 0 {
                            if selected.paragraphQuestionToken == pragraph.paragraphQuestionsWithAnswer![currentQuestionIndex].paragraphQuestionToken ?? "" {
                                self.questionAnswer = selected.studentQuestionAnswer ?? ""
                            }
                        }
                    }
                }
            } catch {
                Helper.traceCrach(error: error, userToken: "")
            }
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

//#Preview {
//    ParagraphView()
//}

