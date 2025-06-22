//
//  CoursesLevelWebView.swift
//  FEDS-Center-Dev-IOS
//
//  Created by Omar Pakr on 05/03/2024.
//

import SwiftUI
import WebKit
@available(iOS 16.0, *)
struct OnlineContentLevelWebView: View {
    @StateObject private var detector = ScreenRecordingDetector()
    @StateObject var genralVm : GeneralVm = GeneralVm()

    @State private var showingAlert = false
    @State private var webView = WKWebView()
    @State private var backFromOnlineContentLevelWebView : Bool = false
    
    @Environment(\.dismiss) var dismiss

 
    var body: some View {
        let mediaUrl : String = UserDefaultss().restoreString(key: "fileWatchViewUrl")
        
        NavigationView {
        VStack{
            WebView(url: URL(string: mediaUrl)!, detector: detector)
                .onChange(of: detector.isScreenRecording) { isRecording in
                    if isRecording {
                        showingAlert = true
                        exit(0)
                    }
                }
                .alert(isPresented: $showingAlert) {
                    Alert(
                        title: Text("Screen Recording Detected"),
                        message: Text("Screen recording is not allowed while using this part of the app."),
                        dismissButton: .default(Text("OK"))
                    )
                }
        }
//        .fullScreenCover(isPresented: $backFromOnlineContentLevelWebView, content: {
//            CoursesInfoTapView()
//            .environmentObject(ScreenshotDetector())
//            .environmentObject(ScreenRecordingDetector())
//            
//        })
        .navigationBarItems(leading:
                                HStack(spacing: 10){
            if self.genralVm.lang == genralVm.constants.APP_IOS_LANGUAGE_AR  {
                Image("arrow-right")
                    .resizable()
                    .frame(width: 30,height: 30)
                
            }else {
                Image("arrow-left")
                    .resizable()
                    .frame(width: 30,height: 30)
            }
            
            Text(NSLocalizedString("back", comment: ""))
                .foregroundColor(Color.gray)
                .font(
                    Font.custom(Fonts().getFontBold(), size: 20)
                        .weight(.bold)
                )
            
        }
            .onTapGesture(count: 2, perform: {
                dismiss()
            })
        )
        .onDisappear {
            UserDefaultss().removeObject(forKey:"fileWatchViewUrl")
        }
    }
       
    }
    
    private func clearStatesWithAction(valueState: inout Bool) {
        valueState.toggle()
        self.backFromOnlineContentLevelWebView = false
        
    }
}


