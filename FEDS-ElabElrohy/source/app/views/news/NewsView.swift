
import SwiftUI


@available(iOS 16.0, *)
struct NewsView: View {
    @StateObject var newsVm : NewsVm = NewsVm()
    @StateObject var genralVm : GeneralVm = GeneralVm()

    @State private var showNewsDetailsFromNews : Bool = false
    @State private var showStudenMainFromNews : Bool = false
    @State private var newsDetails = NewsArticlesDatum()

    @State private var toast: Toast? = nil
    
    
    private let adaptiveColumns = [
        GridItem(.fixed(100))
    ]
    var body: some View {
        
        NavigationView {
            VStack {
                if newsVm.noData {
                    NoContent(message: newsVm.msg)
                    
                } else {
                    VStack {
                        ScrollView {
                            LazyVGrid(columns: adaptiveColumns,spacing: 10) {
                                ForEach(newsVm.newsData,id: \.newsArticleToken) { news in
                                    CardBottomTxtWithBgImageUrl(
                                        defaultImage: "default_news",
                                        imageUrl: news.storageFileData?.thumbnailImageUrl ?? "",
                                        nameTitle: news.newsArticleTitle ?? "") {
                                            clearStatesWithAction(valueState: &showNewsDetailsFromNews)
                                            do {
                                                let data = try JSONEncoder().encode(news)
                                                UserDefaults.standard.set(data, forKey: "newsItem")
                                            } catch {
                                                toast = Helper.showToast(style: .error, message: NSLocalizedString("message_error_in_fetching_data", comment: ""))
                                            }
                                        }
                                    
                                        .padding(.vertical, 12)
                                }
                                
                                if newsVm.currentPage < newsVm.totalPages {
                                    Text(NSLocalizedString("fetchMoreData", comment: ""))
                                        .onAppear {
                                            newsVm.currentPage += 1
                                            newsVm.paginated = true
                                            newsVm.getNews(isSlider: false)
                                        }
                                    
                                }
                            }
                            
                        }
                        .refreshable {
                            newsVm.currentPage = 1
                            newsVm.paginated = false
                            newsVm.getNews(isSlider: false)
                        }
                    }
                }
            }
            
            .overlay(
                newsVm.isLoading ?
                GeometryReader { geometry in
                    ZStack {
                        LoadingView(placHolder: NSLocalizedString("loading", comment: ""))
                            .frame(width: geometry.size.width, height: geometry.size.height)
                            .transition(.scale)
                    } } : nil
            )
            
            .fullScreenCover(isPresented: $showStudenMainFromNews, content: {
                StudentMainTabView()
                   
            })
            .fullScreenCover(isPresented: $showNewsDetailsFromNews, content: {
                NewsDetailsView()
                    .environmentObject(ScreenshotDetector())
                    .environmentObject(ScreenRecordingDetector())
            })
            .fullScreenCover(isPresented: $newsVm.showLogOut, content: {
                RegistrationView()
            })
            
            
            .navigationBarTitle(NSLocalizedString("news", comment: ""), displayMode: .inline)
            .navigationBarItems(leading: CustomBackButton(){
               clearStatesWithAction(valueState: &showStudenMainFromNews)
            }
            )
            .navigationBarBackButtonHidden(true)
            
        }
        .onAppear {
            newsVm.paginated = false
            newsVm.getNews(isSlider: false)
        }
        
        .onDisappear(perform: {
            clearStatesWithAction(valueState: &genralVm.dissapearView)
        })
        .background(genralVm.isDark ? Color(Colors().darkBodyBg): Color(Colors().lightBodyBg))

        .ipad()
        
    }
    private func clearStatesWithAction(valueState: inout Bool) {
        valueState.toggle()
        showNewsDetailsFromNews = false
        showStudenMainFromNews = false
    }
}

