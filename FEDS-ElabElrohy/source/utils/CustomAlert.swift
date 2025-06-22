//
//  CustomAlert.swift
//  FEDS-Center-Dev-IOS
//
//  Created by Omar Pakr on 12/03/2024.
//

import SwiftUI

struct CustomAlertView: View {
    let status : Bool
    let image: Image
    let title: String
    let message: String
    let isDark = UserDefaultss().restoreBool(key: "isDark")

    @State private var messageHeight: CGFloat = 0

    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment:.center) {
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color.white)
                    .overlay(alignment: .center, content: {
                        VStack {
                            Spacer()
                            Text(message)
                                .font(
                                    Font.custom(Fonts().getFontBold(), size: 18)
                                        .weight(.bold)
                                )
                                .padding()
                                .multilineTextAlignment(.center)
                                .lineLimit(8)
                                .fixedSize(horizontal: false, vertical: true)
                                .background(GeometryReader { geo in
                                    Color.clear.preference(key: MessageHeightKey.self, value: geo.size.height)
                                })
                    
                            Text(NSLocalizedString("close", comment: ""))
                                    .font(.title3)
                                    .foregroundColor(.white)
                                    .padding(.vertical, 8)
                                    .padding(.horizontal, 16)
                                    .background(Color.red)
                                    .cornerRadius(10)
                                    .padding(.bottom, 20)

                                    
                        }
                    })
                    .onPreferenceChange(MessageHeightKey.self) { value in
                        messageHeight = value
                    }
                    .overlay(alignment: .top, content: {
                        RoundedRectangle(cornerRadius: 10)
                            .fill(status ?   Color.green : Color.red)
                            .frame(height: 100)
                            .overlay(
                                HStack(spacing:50){
                                    Text(title)
                                        .foregroundColor(Color.white)
                                        .font (
                                            Font.custom(Fonts().getFontBold(), size: 24)
                                                .weight(.bold)
                                        )
                                        .lineLimit(2)
                                        .multilineTextAlignment(.center)
                                    
                                    image
                                        .resizable()
                                        .frame(width: 80, height: 80, alignment: .center)
                                }
                            )
                    }
                    )
                    .edgesIgnoringSafeArea(.all)
                    .frame(height: messageHeight + 200) // Add some extra padding
                    .transition(.move(edge: .bottom))
                    .animation(.spring())
            }
            .frame(width: geometry.size.width, height: geometry.size.height)
            .position(x: geometry.size.width / 2, y: geometry.size.height / 2-50)
            .background(Color.clear)
            .shadow(color: isDark ? .white : .black.opacity(0.25), radius: 4, x: 0, y: 1)
        }
    }
}

struct MessageHeightKey: PreferenceKey {
    static var defaultValue: CGFloat = 0
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}
