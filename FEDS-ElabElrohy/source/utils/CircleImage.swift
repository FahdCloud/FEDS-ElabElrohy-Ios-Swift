//
//  CircleImage.swift
//  FEDS-Center-Dev-IOS
//
//  Created by Omar Pakr on 25/03/2024.
//

import SwiftUI

// Define your custom circle image view
struct CircleImage: View {
   var logo : String
    var width : CGFloat
    var height : CGFloat
    var bgColor : Color
    var offestY : CGFloat
    
    var body: some View {
        Image(logo)
            .resizable()
            .background(bgColor)
            .frame(width: width, height: height) // Adjust to match your design
            .clipShape(Circle())
            .overlay(Circle().stroke(Color.white, lineWidth: 4)) // Border for the circle
            .shadow(radius: 10)
            .offset(y: offestY) // Adjust this offset to move the image down
    }
}
