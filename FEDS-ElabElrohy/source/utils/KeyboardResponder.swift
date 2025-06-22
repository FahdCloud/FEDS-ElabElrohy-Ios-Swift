//
//  KeboardUp.swift
//  FEDS-Center-Dev-IOS
//
//  Created by Omar Pakr on 16/05/2024.
//

import SwiftUI
import Combine

class KeyboardResponder: ObservableObject {
    @Published var currentHeight: CGFloat = 0
    private var cancellable: AnyCancellable?
    
    init() {
        cancellable = NotificationCenter.default
            .publisher(for: UIResponder.keyboardWillChangeFrameNotification)
            .merge(with: NotificationCenter.default.publisher(for: UIResponder.keyboardWillHideNotification))
            .compactMap { notification in
                guard let userInfo = notification.userInfo else { return nil }
                
                let endFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect) ?? .zero
                
                if notification.name == UIResponder.keyboardWillHideNotification {
                    return CGFloat(0)
                } else {
                    return endFrame.height
                }
            }
            .assign(to: \.currentHeight, on: self)
    }
    
    deinit {
        cancellable?.cancel()
    }
}
