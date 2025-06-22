//
//  ExamWebView.swift
//  FEDS-Dev-Ver-One
//
//  Created by Omar Pakr on 03/10/2024.
//

import SwiftUI
import WebKit

//https://feds-dev-v10.fahd-cloud.com/external-platform/educational-student-exam;userLoginSessionToken=89f2013d-f9bb-4223-1f98-08dce2f3b22a;studentExamToken=6d1b6462-3e63-4421-f287-08dce3a61b75

@available(iOS 16.0, *)
struct ExamWebView: View {
    @StateObject var genralVm : GeneralVm = GeneralVm()
    @StateObject private var detector = ScreenRecordingDetector()
    @State private var showingAlert = false
    @State private var webView = WKWebView()
    @State var showMoreFromOnlineReservationDoc : Bool = false
    let userLoginSessionToken = UserDefaultss().restoreString(key: "userLoginSessionToken")
    let studentExamToken = UserDefaultss().restoreString(key: "studentExamToken")

    
    var body: some View {
        let mediaUrl : String = genralVm.constants.BASE_URL + "/external-platform/educational-student-exam;" + "userLoginSessionToken" + userLoginSessionToken + "studentExamToken" + studentExamToken
        
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
            .fullScreenCover(isPresented: $showMoreFromOnlineReservationDoc, content: {
                CoursesInfoTapView()
                    .environmentObject(ScreenshotDetector())
                    .environmentObject(ScreenRecordingDetector())
                
            })
            .navigationBarItems(leading: CustomBackButton(){
                clearStatesWithAction(valueState: &showMoreFromOnlineReservationDoc)
            })
        }
        .onDisappear {
            clearStatesWithAction(valueState: &genralVm.dissapearView)
        }
        
    }
    private func clearStatesWithAction(valueState: inout Bool) {
        valueState.toggle()
        showMoreFromOnlineReservationDoc = false
    }
}
