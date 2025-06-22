//
//  isIpad.swift
//  FPLS-Dev
//
//  Created by Omar pakr on 22/11/2023.
//

import Foundation
import SwiftUI

extension View {
    @ViewBuilder func ipad() -> some View  {
        if UIDevice.current.userInterfaceIdiom == .pad {
            self.navigationViewStyle(.stack)
        } else {
            self
        }
    }
}
