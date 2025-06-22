
import SwiftUI

@available(iOS 16.0, *)
struct NewsDetailsView: View {
    
    @State var newsDetails = NewsArticlesDatum()
    @StateObject var genralVm : GeneralVm = GeneralVm()

    @State private var showNewsFromNewsDetails : Bool = false
    @State private var showMedia : Bool = false
    @State private var showVideoIcon : Bool = false
    @State private var mediaUrl : String = ""
    
    @EnvironmentObject var screenshotDetector: ScreenshotDetector
    @EnvironmentObject var screenRecordingDetector: ScreenRecordingDetector
    @StateObject private var detector = ScreenRecordingDetector()
    
    var body: some View {
        
        NavigationView {
            ScrollView {
                VStack {
                    ZStack{
                        CustomImageUrl(defaultImage: "default_news",
                                       url: newsDetails.storageFileData?.thumbnailImageUrl ?? "",
                                       width: .infinity, height: 300, corenerRaduis: 0){
                            if Validation.IsValidContent(text: mediaUrl, length: 6){
                                clearStatesWithAction(valueState: &showMedia)
                            }
                        }
                        if showVideoIcon {
                            Image("video_icon")
                                .resizable()
                                .frame(width: 50,height: 50)
                        }
                    }
                    .onTapGesture {
                        if Validation.IsValidContent(text: mediaUrl, length: 6){
                            clearStatesWithAction(valueState: &showMedia)
                        }
                    }
                    .sheet(isPresented: $showMedia, content: {
                        WebView(url: URL(string: mediaUrl)!, detector: detector)
                            .onChange(of: detector.isScreenRecording) { isRecording in
                                if isRecording {
                                    exit(0)
                                }else{
                                    
                                }
                            }
                        
                            .edgesIgnoringSafeArea(.all)
                        
                    })
                    
                    Text(newsDetails.newsArticleTitle ?? "")
                        .font(Font.custom(Fonts().getFontBold(), size: 20))
                        .fontWeight(.bold)
                        .foregroundColor(genralVm.isDark ? Color(Colors().darkCardText) : Color(Colors().lightCardText))
                        .frame(maxWidth: .infinity,alignment:.leading)
                        .multilineTextAlignment(.leading)
                        .lineLimit(10)
                        .padding(.horizontal, 10)
                    
                    
                    HtmlView(text: newsDetails.newsArticleContent ?? "")
                        .padding(.vertical, 10)
                        .padding(.horizontal, 10)
                    
                }
                .ipad()
                .onAppear(perform: {
                    
                    if let data = UserDefaults.standard.data(forKey: "newsItem") {
                        do {
                            let decoder = JSONDecoder()
                            let news = try decoder.decode(NewsArticlesDatum.self, from: data)
                            self.newsDetails = news
                            
                        }catch {
                            Helper.traceCrach(error: error, userToken: "")
                        }
                        
                        mediaUrl = newsDetails.storageFileData?.watchViewUrl ?? ""
                        let mediaType = newsDetails.storageFileData?.storageFileMediaTypeToken!
                        if mediaType == genralVm.constants.MEDIA_TYPE_VIDEO {
                            showVideoIcon = true
                        }
                    }
                })
                
                .onDisappear {
                    clearStatesWithAction(valueState: &genralVm.dissapearView)
                }
            }
            .background(genralVm.isDark ? Color(Colors().darkBodyBg): Color(Colors().lightBodyBg))
            .navigationBarItems(leading: CustomBackButton(){
                clearStatesWithAction(valueState: &showNewsFromNewsDetails)
            })
            .fullScreenCover(isPresented: $showNewsFromNewsDetails, content: {
                NewsView()
            })
            .navigationTitle(NSLocalizedString("newsDetails", comment: ""))
        }
        
    }
    private func clearStatesWithAction(valueState: inout Bool) {
        valueState.toggle()
        showNewsFromNewsDetails = false
        showMedia = false
        showVideoIcon = false
        UserDefaultss().removeObject(forKey: "newsItem")
    }
}
