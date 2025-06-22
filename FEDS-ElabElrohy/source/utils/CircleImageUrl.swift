//
//  CircleImageUrl.swift
//  FEDS-Center-Dev-IOS
//
//  Created by Omar Pakr on 26/03/2024.
//

import SwiftUI

struct CircleImageUrl: View {
     var imageUrl : String
     var width : CGFloat
     var height : CGFloat
     var bgColor : Color
     var offestY : CGFloat
    
     
     var body: some View {
         CustomImageUrl(url: imageUrl, width:width, height:height)
             .background(bgColor)
             .clipShape(Circle())
             .overlay(Circle().stroke(Color.white, lineWidth: 4)) // Border for the circle
             .shadow(radius: 10)
             .offset(y: offestY) // Adjust this offset to move the image down
     }
 }
