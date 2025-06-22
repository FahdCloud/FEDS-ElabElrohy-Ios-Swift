//
//  OnlineContentViewDetailsView.swift
//  FEDS-Dev-1.1
//
//  Created by Mrwan on 28/08/2024.
//

import SwiftUI
import BottomSheetSwiftUI

struct OnlineContentViewSubscriptionView: View {
    @StateObject var educationCourseDetailsVm : EducationCourseDetailsVm = EducationCourseDetailsVm()
    @StateObject var genralVm : GeneralVm = GeneralVm()
    @StateObject private var detector = ScreenRecordingDetector()
    @State private var educationalCourseData : EducationalCourseInfoData = EducationalCourseInfoData()
    
    @State private var showTrailer : Bool = false
    @State private var showContentLevelView = false
    @State private var mediaTrailerUrl : String = ""
    @State private var toast: Toast? = nil
    
    @EnvironmentObject var screenshotDetector: ScreenshotDetector
    @EnvironmentObject var screenRecordingDetector: ScreenRecordingDetector
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
            ScrollView{
                VStack(alignment: .center, spacing: 12) {
                    HStack {
                        ZStack {
                            
                            CustomImageUrl(defaultImage: "course_default",
                                           url:self.educationalCourseData.educationalCourseThumbnailImageUrl ?? "" ,
                                           width: .infinity, height: 250, corenerRaduis: 10){
                                
                                mediaTrailerUrl = self.educationalCourseData.storageFileWatchViewUrl ?? ""
                                if Validation.IsValidContent(text: mediaTrailerUrl, length: 6){
                                    clearStatesWithAction(valueState: &showTrailer)
                                }
                            }
                            
                            if (self.educationalCourseData.thumbnailImageForVideo ?? false)  {
                                Image("video_icon")
                                    .resizable()
                                    .frame(width: 70,height: 70)
                                
                                    .onTapGesture {
                                        mediaTrailerUrl = self.educationalCourseData.storageFileWatchViewUrl ?? ""
                                        if Validation.IsValidContent(text: mediaTrailerUrl, length: 6){
                                            clearStatesWithAction(valueState: &showTrailer)
                                        }
                                    }
                                    .sheet(isPresented: $showTrailer, content: {
                                        WebView(url: URL(string:
                                                    self.educationalCourseData.storageFileWatchViewUrl ?? "")!, detector: detector)
                                            .onChange(of: detector.isScreenRecording) { isRecording in
                                                if isRecording {
                                                    exit(0)
                                                }
                                            }
                                            .edgesIgnoringSafeArea(.all)
                                    })
                            }
                        }
                    }
                    VStack(alignment: .trailing, spacing: 10) {
                        CardForCourseDetails(startIconName: "appSetting_calender",
                                             startText1:NSLocalizedString("from", comment: ""),
                                             startText2:  "\(self.educationalCourseData.educationalCategoryCustomInfoData?.educationalCategoryNameCurrent ?? "" )"
                                             
                        )
                        
                        VStack(alignment: .leading, spacing: 10) {
                            
                            
                            CardForCourseDetails(startIconName: "allMedia",
                                                 startText1: "\(self.educationalCourseData.educationalCourseNameCurrent ?? "" )"
                            )
                            
                            HStack (spacing:110){
                                VStack(alignment:.leading) {
                                    
                                    CardForCourseDetails(startIconName: "closed_book",
                                                         startText1: "\(self.educationalCourseData.educationalCategoryCustomInfoData?.educationalCategoryNameCurrent ?? "" )"
                                    )
                                    CardForCourseDetails(startIconName: "educationSubject",
                                                         startText1: NSLocalizedString("chapters", comment: ""),
                                                         startText2: "\(self.educationalCourseData.educationalCourseStatsticInfoData?.countChapters ?? 0)"
                                    )
                                    
                                    CardForCourseDetails(startIconName: "questions",
                                                         startText1: NSLocalizedString("examss", comment: ""),
                                                         startText2: "\(self.educationalCourseData.educationalCourseStatsticInfoData?.countExames ?? 0)"
                                    )
                                    
                                    
                                }
                                VStack(alignment:.leading) {
                                    
                                    
                                    CardForCourseDetails(startIconName: "lecture",
                                                         startText1: "\(self.educationalCourseData.userServiceProviderInfoData?.userNameCurrent ?? "")"
                                    )
                                    
                                    CardForCourseDetails(startIconName: "folder",
                                                         startText1:NSLocalizedString("lessonss", comment: ""),
                                                         startText2:  "\(self.educationalCourseData.educationalCourseStatsticInfoData?.countLessones ?? 0)"
                                    )
                                    
                                    CardForCourseDetails(startIconName: "item_of_pages",
                                                         startText1:NSLocalizedString("files", comment: ""),
                                                         startText2:  "\(self.educationalCourseData.educationalCourseStatsticInfoData?.countFiles ?? 0)"
                                    )
                                }
                            }
                            
                            CardForCourseDetails(startIconName: "book",
                                                 startText1: NSLocalizedString("description", comment: "") +  "\n",
                                                 startText2: "\(self.educationalCourseData.educationalCategoryCustomInfoData?.educationalCategoryDescriptionCurrent ?? "")"
                            )
                        }
                    }
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
                    .shadow(color: colorScheme == .dark ? .white.opacity(0.3) : .black.opacity(0.5), radius: 8, x: 0, y: 5)
                }
                .padding()
                
                VStack(alignment: .leading, spacing: 12) {
                    VStack  {
                        HStack{
                            Image("subscriptions")
                                .resizable()
                                .frame(width: 35,height: 35)
                            
                            Text(NSLocalizedString("avaliableSubs", comment: ""))
                                .font(
                                    Font.custom(Fonts().getFontBold(), size: 20)
                                        .weight(.bold)
                                )
                                .foregroundStyle(.primary)
                                .lineLimit(1)
                        }
                        ForEach(0..<(self.educationalCourseData.educationalCourseSubscriptionPlans?.count ?? 0), id: \.self) { index in
                            VStack {
                                if self.genralVm.lang == self.genralVm.constants.APP_LANGUAGE_AR {
                                    Text(" - " + (self.educationalCourseData.educationalCourseSubscriptionPlans?[index].subscriptionPlanNameAr ?? ""))
                                } else {
                                    Text(" - " + (self.educationalCourseData.educationalCourseSubscriptionPlans?[index].subscriptionPlanNameEn ?? ""))
                                }
                            }
                            .padding(5)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .font(
                                Font.custom(Fonts().getFontBold(), size: 16)
                                    .weight(.bold)
                            )
                            .foregroundStyle(.primary)
                            
                        }
                        
                    }
                }
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(12)
                .shadow(color: colorScheme == .dark ? .white.opacity(0.3) : .black.opacity(0.5), radius: 8, x: 0, y: 5)
                .padding(.horizontal, 10)
                
            }
        .background(genralVm.isDark ? Color(Colors().darkBodyBg): Color(Colors().lightBodyBg))
        
        .fullScreenCover(isPresented: $educationCourseDetailsVm.showLogOut, content: {
            RegistrationView()
        })
      
        .fullScreenCover(isPresented: $showContentLevelView) {
            OnlineContentLevelWebView()
        }
        .toastView(toast: $educationCourseDetailsVm.toast)
     
        .onAppear(perform: {
            DispatchQueue.main.asyncAfter(deadline: .now()){
                
                if let savedData = UserDefaults.standard.data(forKey: "educationalCourseInfoData") {
                    do {
                        let decodedData = try JSONDecoder().decode(EducationalCourseInfoData.self, from: savedData)
                        self.educationalCourseData = decodedData
                       
                    } catch {
                        print("Error decoding or encoding APIAppData:", error)
                    }
                } else {
                    print("No data found for key 'appData' in UserDefaults")
                }
            }
            
        })
    }
    
    private func clearStatesWithAction(valueState: inout Bool) {
        valueState.toggle()
        showTrailer = false
        showContentLevelView = false
    }
}

struct CardForCourseDetails: View {
    var startIconName: String
    var startText1: String = ""
    var startText2: String = ""
    var iconWidth: CGFloat = 25
    var iconHeight: CGFloat = 25
    
    var body: some View {
        
        HStack(spacing: 10) {
            HStack {
                Image(startIconName)
                    .resizable()
                    .frame(width: iconWidth,height: iconHeight)
                
                Text(startText1 + startText2)
                    .font(
                        Font.custom(Fonts().getFontBold(), size: 15)
                            .weight(.bold)
                    )
                    .foregroundStyle(.primary)
                //                    .lineLimit(1)
            }
        }
        
    }
}
