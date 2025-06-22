//
//  DisclousreLabel.swift
//  FPLS-Dev
//
//  Created by Omar pakr on 25/10/2023.
//

import SwiftUI

struct DisclosureLabel: View {
    
    let image : String
    let day : String
    let date : String
    let duration : String
    var body: some View {
        HStack (spacing : 0) {
            
            Text(day)
                .lineLimit(4)
                .frame(width: 100)
            
            Text(date)
                .lineLimit(4)
                .frame(width: 100)
            
            HStack {
                Image("clocc")
                
                Text(duration)
                    .frame(width: 70)
            
            }
            Image(image)
                .resizable()
                .frame(width: 20, height: 20)
        }
        .frame(alignment: .center)
    }
}
