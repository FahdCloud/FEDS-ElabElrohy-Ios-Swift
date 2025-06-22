//
//  imageview.swift
//  FPLS-Dev
//
//

import SwiftUI

struct ImageViewHandler: View {
    let url : String
    var width : CGFloat = 30
    var height : CGFloat = 30
    var showImager :Bool = false
    @State var showImage : Bool = false
    let isDark = UserDefaultss().restoreBool(key: "isDark")

    var body: some View {
        AsyncImage(url: URL(string : url )) { phase in
            
            if let image = phase.image {
                
                image
                    .resizable()
                    .frame(width: width,height: height)
//                    .padding(10)
                    .frame(width: width, height: height, alignment: .center)
                    .cornerRadius(12)
                    .shadow(color: .black.opacity(0.25), radius: 2, x: 0, y: 1)
                    .onTapGesture {
                        if showImager {
                            showImage.toggle()
                        }
                    }
                
            } else if phase.error != nil {
                Image("picture")
                    .resizable()
                    .frame(width: width,height: height)
                    .padding(10)
                    .frame(width: width, height: height, alignment: .center)
                    .cornerRadius(12)
                    .shadow(color: .black.opacity(0.25), radius: 2, x: 0, y: 1)
            } else {
                Image("picture")
                    .resizable()
                    .frame(width: width,height: height)
                    .padding(10)
                    .frame(width: width, height: height, alignment: .center)
                    .cornerRadius(12)
                    .shadow(color: .black.opacity(0.25), radius: 2, x: 0, y: 1)
            }
        }
        .sheet(isPresented: $showImage, content: {
            CustomImageUrl(url: self.url,width: .infinity,height: .infinity)
        })
        
    }
}

struct ImageviewHandler_Previews: PreviewProvider {
    static var previews: some View {
        CustomImageUrl(url: "")
    }
}
