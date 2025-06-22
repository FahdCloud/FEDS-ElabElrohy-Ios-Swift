//
//  EducationGroupTimesMediaView.swift
//  FPLS-Dev
//
//  Created by Omar pakr on 30/10/2023.
//

import SwiftUI

@available(iOS 16.0, *)
struct EducationGroupTimesMediaView: View {
    @StateObject var groupTimeMediaVm : EducationGroupTimeMediaVm = EducationGroupTimeMediaVm()
    @StateObject var genralVm : GeneralVm = GeneralVm()

    let groupTimeToken : String
    let groupToken : String
    @State private var showStudentMainFromEducationGroupMedia : Bool = false
    @State private var playVideo : Bool = false
    @State private var showImage : Bool = false
    @State private var openLink : Bool = false
    @State private var isShowen : Bool = false
    @State private var showRecordingPage : Bool = false
    @EnvironmentObject var screenshotDetector: ScreenshotDetector
    @EnvironmentObject var screenRecordingDetector: ScreenRecordingDetector
    @StateObject private var detector = ScreenRecordingDetector()
    
    
    var body: some View {
        NavigationView {
            ZStack {
                if groupTimeMediaVm.noData {
                    NoContent(message: groupTimeMediaVm.msg)
                      
                } else {
                    VStack {
                        List {
                            ForEach(groupTimeMediaVm.educationalGroupScheduleTimesMedia, id: \.systemMediaToken) { media in
                                HStack(spacing:50) {
                                    CustomImageUrl(url: media.storageFileData?.thumbnailImageUrl ?? "")
                                    Text(media.systemMediaTitle ?? "")
                                        .font(
                                            Font.custom(Fonts().getFontBold(), size: 14)
                                                .weight(.bold)
                                        )
                                        .multilineTextAlignment(.center)
                                        .lineLimit(4)
                                }
                                .onTapGesture {
                                    UserDefaultss().saveStrings(value: media.storageFileData?.watchViewUrl ?? "", key: "mediaUrl")
                                    if media.storageFileData?.storageFileMediaTypeToken == genralVm.constants.MEDIA_TYPE_IMAGE {
                                        showImage.toggle()
                                    } else if media.storageFileData?.storageFileMediaTypeToken == genralVm.constants.MEDIA_TYPE_VIDEO {
                                        self.playVideo.toggle()
                                    } else  {
                                        openLink.toggle()
                                    }
                                }
                            }
                        }
                    }
                    .onAppear(perform: {
                        let timeToken = UserDefaultss().restoreString(key: "educationalGroupScheduleTimeToken")
                        groupTimeMediaVm.getEducationGroupTimesMedia(groupTimeMediaToken: timeToken,groupMediaToken:groupToken)
                    })
                    
                    
                    .sheet(isPresented: $showImage, content: {
                        let mediaUrl : String = UserDefaultss().restoreString(key: "mediaUrl")
                        CustomImageUrl(url: mediaUrl,width:.infinity,height:.infinity)
                    })
                    .onReceive(screenshotDetector.screenshotTaken) {
                        exit(0)
                    }
                    .onReceive(screenRecordingDetector.$isScreenRecording) { isRecording in
                        showRecordingPage = isRecording
                    }
                    .sheet(isPresented: $playVideo, content: {
                        let mediaUrl : String = UserDefaultss().restoreString(key: "mediaUrl")
                        VideoPlayerView(videoURL: URL(string: mediaUrl)!)
                            .ignoresSafeArea()
                    })
                    
                    .onReceive(screenshotDetector.screenshotTaken) {
                        exit(0)
                    }
                    
                    .sheet(isPresented: $openLink) {
                        if isShowen {
                            let mediaUrl : String = UserDefaultss().restoreString(key: "mediaUrl")
                            WebView(url: URL(string:mediaUrl)!,detector:detector)
                                .edgesIgnoringSafeArea(.all)
                            
                        }
                    }
                }
            }
            .navigationBarItems(leading: CustomBackButton(){
                clearStatesWithAction(valueState: &showStudentMainFromEducationGroupMedia)
            })
            .fullScreenCover(isPresented: $showStudentMainFromEducationGroupMedia, content: {
                StudentMainTabView()
            })
            .fullScreenCover(isPresented: $groupTimeMediaVm.showLogOut, content: {
                RegistrationView()
            })
            .refreshable {
                let timeToken = UserDefaultss().restoreString(key: "educationalGroupScheduleTimeToken")
                groupTimeMediaVm.getEducationGroupTimesMedia(groupTimeMediaToken: timeToken,groupMediaToken:groupToken) 
            }
            
            .overlay(
                groupTimeMediaVm.isLoading ?
                GeometryReader { geometry in
                    ZStack {
                        LoadingView(placHolder: NSLocalizedString("loading", comment: ""))
                            .frame(width: geometry.size.width, height: geometry.size.height)
                            .transition(.scale)
                    } } : nil
            )
            .navigationTitle(NSLocalizedString("groupTimeMedia", comment: ""))
            .onDisappear(perform: {
                clearStatesWithAction(valueState: &genralVm.dissapearView)
            })
        }
    }
    private func clearStatesWithAction(valueState: inout Bool) {
        valueState.toggle()
        showStudentMainFromEducationGroupMedia = false
    }
}
