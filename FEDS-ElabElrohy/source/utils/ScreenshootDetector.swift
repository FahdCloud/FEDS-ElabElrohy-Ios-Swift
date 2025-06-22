//
//  ScreenshootDetector.swift
//  FPLS-Dev
//
//  Created by Omar pakr on 23/11/2023.
//

import Foundation
import Combine
import UIKit

class ScreenshotDetector: ObservableObject {
    var screenshotTaken = PassthroughSubject<Void, Never>()

    init() {
        NotificationCenter.default.addObserver(self, selector: #selector(screenshotTakenAction), name: UIApplication.userDidTakeScreenshotNotification, object: nil)
    }

    @objc private func screenshotTakenAction() {
        screenshotTaken.send()
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}
