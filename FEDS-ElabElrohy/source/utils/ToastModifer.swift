//
//  ToastModifer.swift
//  FEDS-Center-Dev
//
//  Created by Omar Pakr on 18/02/2024.
//

import SwiftUI

struct Toasting : ViewModifier {
    let message: String
    let isShowing: Bool
    let duration: TimeInterval = 2 // Duration in seconds

    func body(content: Content) -> some View {
        ZStack {
            content
            if isShowing {
                VStack {
                    Spacer()
                    Text(message)
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.black)
                        .cornerRadius(10)
                        .shadow(radius: 5)
                        .transition(.move(edge: .bottom))
                        .animation(.easeInOut(duration: 0.3), value: isShowing)
                }
                .padding()
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
                        withAnimation {
                            // Implement logic to change isShowing state to false after the duration
                        }
                    }
                }
            }
        }
    }
}

extension View {
    func toast(message: String, isShowing: Bool) -> some View {
        self.modifier(Toasting(message: message, isShowing: isShowing))
    }
}
