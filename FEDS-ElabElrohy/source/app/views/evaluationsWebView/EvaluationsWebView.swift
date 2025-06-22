//
//  EvaluationsWebView.swift
//  FEDS-Dev-Ver-Two
//
//  Created by Omar Pakr on 29/12/2024.
//

import SwiftUI
import WebKit

//https://feds-dev-v11.fahd-cloud.com/external-platform/educational-student-group-evaluations;userStudentToken=6d2d0544-214d-4c0a-eaa9-08dd1908b986;userLoginSessionToken=da52f0d2-3c02-459c-7341-08dd27f575c6

@available(iOS 16.0, *)
struct EvaluationsWebView: View {
    @StateObject var genralVm : GeneralVm = GeneralVm()
    @StateObject private var detector = ScreenRecordingDetector()
    @State private var showingAlert = false
    @State private var webView = WKWebView()
    @State private var showMyStudentMainFromEvaluationsView : Bool = false
    let userLoginSessionToken = UserDefaultss().restoreString(key: "userLoginSessionToken")
    let userToken = UserDefaultss().restoreString(key: "userToken")

    
    var body: some View {
        let mediaUrl : String = genralVm.constants.BASE_URL + "/external-platform/educational-student-group-evaluations;" + "userStudentToken=" + userToken + ";userLoginSessionToken=" + userLoginSessionToken
        
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
            .fullScreenCover(isPresented: $showMyStudentMainFromEvaluationsView, content: {
                StudentMainTabView()
            })
            .navigationBarItems(leading: CustomBackButton(){
                clearStatesWithAction(valueState: &showMyStudentMainFromEvaluationsView)
            })
        }
        .onDisappear {
            clearStatesWithAction(valueState: &genralVm.dissapearView)
        }
        
    }
    private func clearStatesWithAction(valueState: inout Bool) {
        valueState.toggle()
        showMyStudentMainFromEvaluationsView = false
    }
}

