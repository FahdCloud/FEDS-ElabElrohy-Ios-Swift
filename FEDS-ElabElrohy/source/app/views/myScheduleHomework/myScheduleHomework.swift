//
//  StudentHomework.swift
//  FEDS-Center-Dev-IOS
//
//  Created by Omar Pakr on 20/03/2024.
//

import SwiftUI
import WebKit

@available(iOS 16.0, *)
struct myScheduleHomework: View {
    @StateObject var genralVm : GeneralVm = GeneralVm()
    @StateObject private var detector = ScreenRecordingDetector()
    
    @State private var showingAlert = false
    @State private var webView = WKWebView()
    @State var backFromMyScheduleHW : Bool = false
    let userLoginSessionToken = UserDefaultss().restoreString(key: "userLoginSessionToken")
    let educationalGroupScheduleTimeToken = UserDefaultss().restoreString(key: "educationalGroupScheduleTimeToken")
    
    
    var body: some View {
        let mediaUrl : String = genralVm.constants.BASE_URL + "/external-platform/educational-student-exam/all-exams;userLoginSessionToken=" + userLoginSessionToken + ";" + "moduleExamTypeToken=" + genralVm.constants.MODULE_EXAM_TYPE_TOKEN_HW
        + ";" + "educationalGroupScheduleTimeToken=" + educationalGroupScheduleTimeToken
        
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
           
            .navigationTitle(
                Text(NSLocalizedString("myHw", comment: ""))
                    .foregroundColor(Color.gray)
                    .font(
                        Font.custom(Fonts().getFontBold(), size: 20)
                            .weight(.bold)
                    )
            )
            .navigationBarItems(leading: CustomBackButton(){
                clearStatesWithAction(valueState: &backFromMyScheduleHW)
            })
        }
        .fullScreenCover(isPresented: $backFromMyScheduleHW, content: {
            StudentMainTabView()
                .environmentObject(ScreenshotDetector())
                .environmentObject(ScreenRecordingDetector())
        })
        .onDisappear {
            clearStatesWithAction(valueState: &genralVm.dissapearView)
            backFromMyScheduleHW = false
        }
    }
    private func clearStatesWithAction(valueState: inout Bool) {
        valueState.toggle()
        backFromMyScheduleHW = false
    }
}
