//
//  SocialMediaView.swift
//  FPLS-Dev
//
//  Created by Omar pakr on 01/12/2023.
//

import Foundation
import SwiftUI

struct SocialMediaView: View {
    let items: [SocialMediaItem] // Array of your models

    var body: some View {
        VStack {
            ForEach(0..<items.count, id: \.self) { index in
                // You may need to adjust the `spacing` value or the logic for rows/columns based on your design.
                let isLastRow = index == items.count / 3 // Check if this is the last row
                let itemCount = isLastRow ? items.count % 3 : 3 // Number of items in the row
                
                HStack(spacing: 20) {
                    ForEach(0..<itemCount, id: \.self) { itemIndex in
                        let globalIndex = index * 3 + itemIndex // Calculate the index in the flat array
                        let item = items[globalIndex]
                        
                        // Conditionally show the link if `isHaveLink` is true
                        if item.isHaveLink, let link = item.link {
                            Link(destination: URL(string: link)!) {
                                SocialMediaItemView(item: item)
                            }
                        } else {
                            SocialMediaItemView(item: item)
                        }
                    }
                }
            }
        }
        .padding(.top, 40)
    }
}

struct SocialMediaItemView: View {
    let item: SocialMediaItem

    var body: some View {
        VStack {
            Image(item.imageName)
                .resizable()
                .frame(width: 60, height: 60)
          
        }
    }
}
