//
//  ScreenRecordDetector.swift
//  FPLS-Dev
//
//  Created by Omar pakr on 23/11/2023.
//

import Foundation
import Combine
import UIKit

class ScreenRecordingDetector: ObservableObject {
    @Published var isScreenRecording: Bool = false

    private var timer: Timer?

    init() {
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] _ in
            DispatchQueue.main.async {
                self?.isScreenRecording = UIScreen.main.isCaptured
            }
        }
    }

    deinit {
        timer?.invalidate()
    }
}
