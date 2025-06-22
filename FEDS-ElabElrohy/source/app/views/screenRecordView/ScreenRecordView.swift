//
//  ScreenRecordView.swift
//  FEDS-Center-Dev
//
//  Created by Omar Pakr on 10/02/2024.
//

import SwiftUI

struct ScreenRecordView : View {
    var body: some View {
        VStack {
            Image("empty_data")
                .resizable()
                .frame(width: 200,height: 200,alignment: .center)
            
            Text(NSLocalizedString("message_screen_recording_detected", comment: ""))
                .font(
                  Font.custom(Fonts().getFontBold(), size: 18)
                    .weight(.bold)
                )
                .multilineTextAlignment(.center)
                .foregroundColor(Color(red: 0.26, green: 0.25, blue: 0.69))
                .frame(width: 176, height: 66, alignment: .top)
        }
    }
}
