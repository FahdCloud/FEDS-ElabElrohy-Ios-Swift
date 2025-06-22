
import SwiftUI
import WebKit

@available(iOS 16.0, *)
struct CertificatsWebView: View {
    @StateObject var genralVm : GeneralVm = GeneralVm()
    @StateObject private var detector = ScreenRecordingDetector()
    @State private var showingAlert = false
    @State private var webView = WKWebView()
    @State private var showMyStudentMainFromCertificatsView : Bool = false
    let userLoginSessionToken = UserDefaultss().restoreString(key: "userLoginSessionToken")
    let userToken = UserDefaultss().restoreString(key: "userToken")

    
    var body: some View {
        let mediaUrl : String = genralVm.constants.BASE_URL + "/external-platform/educational-certificats;" + "userStudentToken=" + userToken + ";userLoginSessionToken=" + userLoginSessionToken
        
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
            .fullScreenCover(isPresented: $showMyStudentMainFromCertificatsView, content: {
                StudentMainTabView()
            })
            .navigationBarItems(leading: CustomBackButton(){
                clearStatesWithAction(valueState: &showMyStudentMainFromCertificatsView)
            })
        }
        .onDisappear {
            clearStatesWithAction(valueState: &genralVm.dissapearView)
        }
        
    }
    private func clearStatesWithAction(valueState: inout Bool) {
        valueState.toggle()
        showMyStudentMainFromCertificatsView = false
    }
}
