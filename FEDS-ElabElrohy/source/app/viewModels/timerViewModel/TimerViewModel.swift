//
//  TimerViewModel.swift
//  FEDS-Center-Dev-IOS
//
//  Created by Mrwan on 24/06/2024.
//

import Foundation
import Combine

class TimerViewModel: ObservableObject {
    @Published var formattedTime: String = ""
    private var milliseconds = UserDefaultss().restoreInt(key: "remainingTimeinMilliseconds")
    private var timer: AnyCancellable?
    
    init() {
        formattedTime = convertMillisecondsToDHMS(milliseconds)
    }
    
    func startTimer() {
        timer?.cancel()
        timer = Timer.publish(every: 1.0, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] _ in
                guard let self = self else { return }
                self.milliseconds -= 1000
                self.formattedTime = convertMillisecondsToDHMS(self.milliseconds)
                
                if self.milliseconds <= 0 {
                    self.timer?.cancel()
                    self.formattedTime = "00:00:00:00"
                }
            }
    }
    
    private func convertMillisecondsToDHMS(_ milliseconds: Int) -> String {
        let seconds = milliseconds / 1000
        let minutes = seconds / 60
        let hours = minutes / 60
        let days = hours / 24
        
        let remainingSeconds = seconds % 60
        let remainingMinutes = minutes % 60
        let remainingHours = hours % 24
        
        return String(format: "%02d:%02d:%02d:%02d", days, remainingHours, remainingMinutes, remainingSeconds)
    }
}
