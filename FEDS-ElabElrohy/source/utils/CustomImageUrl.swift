

import SwiftUI

struct CustomImageUrl: View {
    var defaultImage: String = "picture"
    let url: String
    var width: CGFloat = 30
    var height: CGFloat = 30
    var corenerRaduis: CGFloat = 10
    var showImager: Bool = false
    @State var showImage: Bool = false
    var onClick: (() -> Void)?
    let isDark = UserDefaultss().restoreBool(key: "isDark")

    var body: some View {
        Button(action: {
        self.onClick?()
        }) {
            if (Validation.IsValidContent(text: url, length: 10)){
                AsyncImage(url: URL(string: url)) { phase in
                    switch phase {
                    case .success(let image):
                        image
                            .resizable()
                            .frame(width: width, height: height)
                            .clipShape(RoundedRectangle(cornerRadius: corenerRaduis))
                            .shadow(color: .black.opacity(0.25), radius: 2, x: 0, y: 3)
                        
                    case .failure(_):
                        Image(defaultImage)
                            .resizable()
                            .frame(width: width, height: height)
                            .clipShape(RoundedRectangle(cornerRadius: corenerRaduis))
                            .shadow(color: .black.opacity(0.25), radius: 2, x: 0, y: 3)
                        
                    case .empty:
                        ProgressView()
                            .frame(width: width, height: height)
                        
                    @unknown default:
                        EmptyView()
                    }
                }
            }else{
                Image(defaultImage)
                    .resizable()
                    .frame(width: width, height: height)
                    .clipShape(RoundedRectangle(cornerRadius: corenerRaduis))
                    .shadow(color: .black.opacity(0.25), radius: 2, x: 0, y: 3)
       
            }
            
        }
        // if you want to show image
        .sheet(isPresented: $showImage) {
            CustomImageUrl(url: self.url, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height, showImager: false)
        }
        .buttonStyle(PlainButtonStyle()) // Use PlainButtonStyle to remove button styling
        
    }
        
}
