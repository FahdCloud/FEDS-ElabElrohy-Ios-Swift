//
//  LoadingView.swift
//  GP-SpotIn
//
//  Created by Omar pakr on 19/03/2023.
//

import SwiftUI

struct LoadingView: View {
    var placHolder : String
    @State var animate : Bool = false
    let isDark = UserDefaultss().restoreBool(key: "isDark")
    
    var body: some View {
        
        VStack(spacing: 28) {
            Circle()
                .stroke(AngularGradient(gradient: .init(colors: [Color.primary,Color.primary.opacity(0)]), center: .center))
                .frame(width: 80,height: 80)
                .rotationEffect(.init(degrees: animate ?  360 : 0 ))
                .foregroundColor(isDark ? Color(Colors().darkBodyText): Color(Colors().lightBodyText))
            
            Image(Constants().PROJECT_LOGO)
                .resizable()
                .frame(width: 150,height: 150)
                .cornerRadius(75, corners: .allCorners)
            
            Text(placHolder)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
                .foregroundColor(isDark ? Color(Colors().darkBodyText): Color(Colors().lightBodyText))
                .font(
                    Font.custom(Fonts().getFontBold(), size: 20).weight(.bold))
                .lineSpacing(5)
        }
        .ignoresSafeArea(.all)
        .padding(.vertical,25)
        .padding(.horizontal,35)
        .cornerRadius(20)
        .frame(maxWidth: .infinity,maxHeight: .infinity)
        .background(isDark ? Color(Colors().darkBodyLoadingBg): Color(Colors().lightBodyLoadingBg))
        
        .onAppear {
            withAnimation(Animation.linear(duration: 1.5).repeatForever(autoreverses: true)) {
                animate.toggle()
            }
        }
    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView(placHolder: "Loading")
    }
}


