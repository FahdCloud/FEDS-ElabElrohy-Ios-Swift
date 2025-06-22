//
//  HtmlView.swift
//  FPLS-Dev
//
//  Created by Omar pakr on 15/11/2023.
//

import SwiftUI
import RichText

struct HtmlView: View {
    var text : String
    var body: some View {
       
            ScrollView {
                RichText(html: text)
                    .fontType(.customName("Noto Sans"))
                    .customCSS("""
                            @font-face {
                                   font-family: 'Noto Sans';
                                   src: url("NotoSans-Regular.ttf") format('truetype');
                                       }
                           """)
                    .lineHeight(.infinity)
//                    .frame(height: 60)
              
            }
            .padding()
        }
    
}

#Preview {
    HtmlView(text: "")
}
