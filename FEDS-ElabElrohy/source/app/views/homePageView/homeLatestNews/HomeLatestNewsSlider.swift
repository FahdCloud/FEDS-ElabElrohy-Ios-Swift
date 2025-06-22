//
//  TopNewsViewSlider.swift
//  FEDS-Center-Dev
//
//  Created by Omar pakr on 19/12/2023.
//

import SwiftUI

struct HomeLatestNewsSlider: View {
    @StateObject var newsVm : NewsVm = NewsVm()

    let isDark = UserDefaultss().restoreBool(key: "isDark")

    var body: some View {
        GeometryReader { geometry in
            HomeNewsSliderImageCarouselView(numberOfImages:newsVm.newsData.count) {
                ForEach(newsVm.newsData,id:\.newsArticleToken) { news in
                    ZStack(alignment:.bottom) {
                        
                        CustomImageUrl(url: news.storageFileData?.thumbnailImageUrl ?? "",width: geometry.size.width,height: geometry.size.height)
                            .clipped()
                        
                        HStack(spacing:40) {
                            VStack {
                                Text(news.newsArticleTitle ?? "")
                                    .font(
                                        Font.custom(Fonts().getFontBold(), size: 20)
                                            .weight(.bold)
                                    )
                                    .multilineTextAlignment(.center)
                                    .lineLimit(4)
                                    .foregroundColor(isDark ? Color(Colors().darkCardText): Color(Colors().lightCardText))
                                    .padding(.horizontal, 6)
                                    .padding(.vertical, 10)
                                    .frame(width: geometry.size.width, height: .infinity, alignment: .center)
                            }
                            .frame(maxWidth:.infinity)
                            .frame(height:.infinity)
                            .background(isDark ? Color(Colors().darkCardBgText): Color(Colors().lightCardBgText))
                          }
                        .frame(maxHeight:.infinity , alignment:.bottom)
                        .frame(width: geometry.size.width)
                        
                    }
                }
                   
            }
            
        }
        .frame(height: 300, alignment: .center)
        .onAppear(perform: {
            newsVm.getNews(isSlider: true)
        })
        .refreshable {
            newsVm.getNews(isSlider: true)
        }
    }
}
