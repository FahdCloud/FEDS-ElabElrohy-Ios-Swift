//
//  AllMediaView.swift
//  FEDS-Center-Dev
//
//  Created by Omar pakr on 27/01/2024.
//


import SwiftUI


@available(iOS 16.0, *)
struct AttatchmentsView: View {
    @StateObject var allMediaVm : AllMediaVm = AllMediaVm()
    @StateObject var genralVm : GeneralVm = GeneralVm()

    let columns = [GridItem(.fixed(400), spacing: 30)]
    
    @State private var  showStudentMainFromAttachment : Bool = false
    
    @Environment(\.refresh) private var refreshAction
    @State private var refresh: Bool = false
    @State private var showMedia: Bool = false
    @State private var showScreenRecordView: Bool = false
    @State private var url: String = ""
    @State private var codePrice: Double = 0.0
    @State private var toast: Toast? = nil
    let groupTimeToken : String
    @EnvironmentObject var screenshotDetector: ScreenshotDetector
    @EnvironmentObject var screenRecordingDetector: ScreenRecordingDetector
    @StateObject private var detector = ScreenRecordingDetector()
  
    
    var body: some View {
        NavigationView {
            ZStack {
                if allMediaVm.noData {
                    NoContent(message: allMediaVm.msg)
                } 
                else {
                    VStack {
                        ScrollView {
                            LazyVGrid(columns: columns,spacing: 10) {
                                ForEach(allMediaVm.allMediaData,id:\.systemMediaToken) { media in
                                    VStack {
                                        VStack {
                                            HStack {
                                                Spacer()
                                                CustomImageUrl(url: media.storageFileData?.thumbnailImageUrl ?? "", width: 150, height: 150){
                                                    UserDefaultss().saveStrings(value: media.storageFileData?.watchViewUrl ?? "", key: "storageFileUrl")
                                                    clearStatesWithAction(valueState: &showMedia)
                                                }
                                                
                                            .padding(.leading,20)
                                                VStack {
                                                    Text(media.systemMediaTitle ?? "")
                                                        .font(
                                                            Font.custom(Fonts().getFontBold(), size: 24)
                                                                .weight(.bold)
                                                        )
                                                        .multilineTextAlignment(.center)
                                                        .lineLimit(4)
                                                        .foregroundColor(genralVm.isDark ? Color(Colors().darkCardText): Color(Colors().lightCardText))
                                                        .frame(width: 200, height: .infinity, alignment: .leading)
                                                        .padding()
                                                    
                                                    Spacer()
                                                    
                                                    HStack(spacing:40) {
                                                        Text(media.storageFileData?.totalSizeSizeText ?? "")
                                                        
                                                        if (media.storageFileData?.storageFileMediaTypeToken!) == genralVm.constants.MEDIA_TYPE_VIDEO {
                                                            Text(NSLocalizedString("video", comment: ""))
                                                        } else if (media.storageFileData?.storageFileMediaTypeToken!) == genralVm.constants.MEDIA_TYPE_PDF {
                                                            Text(NSLocalizedString("pdf", comment: ""))
                                                        } else if (media.storageFileData?.storageFileMediaTypeToken!) == genralVm.constants.MEDIA_TYPE_WORD {
                                                            Text(NSLocalizedString("word", comment: ""))
                                                        } else if (media.storageFileData?.storageFileMediaTypeToken!) == genralVm.constants.MEDIA_TYPE_VOICE {
                                                            Text(NSLocalizedString("voice", comment: ""))
                                                        } else if (media.storageFileData?.storageFileMediaTypeToken!) == genralVm.constants.MEDIA_TYPE_IMAGE {
                                                            Text(NSLocalizedString("image", comment: ""))
                                                        } else if (media.storageFileData?.storageFileMediaTypeToken!) == genralVm.constants.MEDIA_TYPE_EXCEl {
                                                            Text(NSLocalizedString("excel", comment: ""))
                                                        }
                                                    }
                                                    .font(
                                                        Font.custom(Fonts().getFontBold(), size: 20)
                                                            .weight(.light)
                                                    )
                                                    
                                                    .multilineTextAlignment(.center)
                                                    .lineLimit(4)
                                                    .foregroundColor(genralVm.isDark ? Color(Colors().darkCardText): Color(Colors().lightCardText))
                                                    .frame(width: 150, height: .infinity, alignment: .trailing)
                                                    .padding()
                                                }
                                            }
                                            .padding(.leading,10)
                                            .padding(.trailing,10)
                                        }
                                        .padding()
                                        .frame(width: 400)
                                        .background(genralVm.isDark ? Color(Colors().darkCardBg): Color(Colors().lightCardBg))
                                        
                                        .cornerRadius(20)
                                        .padding()
                                    }
                                    .onTapGesture {
                                        UserDefaultss().saveStrings(value: media.storageFileData?.watchViewUrl ?? "", key: "storageFileUrl")
                                        showMedia.toggle()
                                    }
                                    
                                }
                            }
                            .padding()
                        }
                        
                        .refreshable {
                            allMediaVm.getAllMedia(groupTimeToken: self.groupTimeToken)
                        }
                        .onAppear {
                            allMediaVm.getAllMedia(groupTimeToken: self.groupTimeToken)
                        }
                        .toastView(toast: $toast)
                    }
                    
                }
            }
         
            
            .navigationTitle(NSLocalizedString("myMedia", comment: ""))
            .navigationBarItems(leading: CustomBackButton(){
                clearStatesWithAction(valueState: &showStudentMainFromAttachment)
            })
            .sheet(isPresented: $showMedia, content: {
                let mediaUrl : String = UserDefaultss().restoreString(key: "storageFileUrl")
                WebView(url: URL(string: mediaUrl)!, detector: detector)
                    .onChange(of: detector.isScreenRecording) { isRecording in
                        if isRecording {
                            exit(0)
                        }
                    }
                    .edgesIgnoringSafeArea(.all)
            })
            .onReceive(screenshotDetector.screenshotTaken) {
                exit(0)
            }
            .onReceive(screenRecordingDetector.$isScreenRecording) { isRecording in
                showScreenRecordView = isRecording
            }
            .overlay(
                allMediaVm.isLoading ?
                GeometryReader { geometry in
                    ZStack {
                        LoadingView(placHolder: NSLocalizedString("loading", comment: ""))
                            .frame(width: geometry.size.width, height: geometry.size.height)
                            .transition(.scale)
                    } } : nil
            )
            .refreshable {
                allMediaVm.getAllMedia(groupTimeToken: self.groupTimeToken)
            }
            .onDisappear(perform: {
                clearStatesWithAction(valueState: &genralVm.dissapearView)
            })
            .fullScreenCover(isPresented: $allMediaVm.showLogOut, content: {
                RegistrationView()
            })
            .fullScreenCover(isPresented: $showStudentMainFromAttachment, content: {
                StudentMainTabView()
            })
            if showScreenRecordView {
                exit(0)
            }
            
        }
        .background(genralVm.isDark ? Color(Colors().darkBodyBg): Color(Colors().lightBodyBg))
        .ipad()
    }
    
    private func clearStatesWithAction(valueState: inout Bool) {
        valueState.toggle()
        showStudentMainFromAttachment = false
    }
}
