//
//  RoundedCorner.swift
//  FEDS-Center-Dev-IOS
//
//  Created by Omar Pakr on 30/03/2024.
//

import SwiftUI


struct RoundedCorner: Shape {
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}
