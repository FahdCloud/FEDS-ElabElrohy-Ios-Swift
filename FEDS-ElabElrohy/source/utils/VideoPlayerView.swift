//
//  VideoPlayerView.swift
//  FPLS-Dev
//
//  Created by Omar pakr on 01/11/2023.
//

import Foundation
import AVFoundation
import SwiftUI
import _AVKit_SwiftUI

struct VideoPlayerView: View {
    let videoURL: URL
    @State var player = AVPlayer()
    @State var showRecordingPage : Bool = false
    @EnvironmentObject var screenshotDetector: ScreenshotDetector
    @EnvironmentObject var screenRecordingDetector: ScreenRecordingDetector

    var body: some View {
        
        VideoPlayer(player: player)
            .onAppear() {
                player = AVPlayer(url: videoURL)
            }
        
//        
//        VideoPlayer(player: AVPlayer(url: videoURL)) {
//            // You can add additional video player controls and UI here.
//        }
//        .onAppear() {
//            // Automatically start playing the video when the view appears.
//            AVPlayer.sharedQueuePlayer.play()
//        }
//        .onDisappear() {
//            // Pause the video when the view disappears (optional).
//            AVPlayer.sharedQueuePlayer.pause()
//        }
        
        .onReceive(screenshotDetector.screenshotTaken) {
            exit(0)
        }
        .onReceive(screenRecordingDetector.$isScreenRecording) { isRecording in
            showRecordingPage = isRecording
        }
        .fullScreenCover(isPresented: $showRecordingPage, content: {
                ScreenRecordView()
                 })
    }
}

extension AVPlayer {
    static var sharedQueuePlayer: AVPlayer = {
        let player = AVPlayer()
        return player
    }()
}
