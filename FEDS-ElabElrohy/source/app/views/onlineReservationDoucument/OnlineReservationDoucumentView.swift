//
//  OnlineReservationDoucumentView.swift
//  FEDS-Center-Dev-IOS
//
//  Created by Omar Pakr on 14/05/2024.
//

import SwiftUI
import WebKit

@available(iOS 16.0, *)
struct OnlineReservationDoucumentView: View {
    @StateObject var genralVm : GeneralVm = GeneralVm()
    @StateObject private var detector = ScreenRecordingDetector()
    @State private var showingAlert = false
    @State private var webView = WKWebView()
    @State var showMoreFromOnlineReservationDoc : Bool = false
    let userLoginSessionToken = UserDefaultss().restoreString(key: "userLoginSessionToken")

    
    var body: some View {
        let mediaUrl : String = genralVm.constants.BASE_URL + "/halper/reservation;userLoginSessionToken=" + userLoginSessionToken
        
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
                StudentMainTabView()
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
