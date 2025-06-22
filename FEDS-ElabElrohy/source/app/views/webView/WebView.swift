//
//  WebView.swift
//  FEDS-Center-Dev
//
//  Created by Omar Pakr on 10/02/2024.
//

import SwiftUI
import WebKit

struct WebView: UIViewControllerRepresentable {
    let url: URL
    var detector: ScreenRecordingDetector
    var onDismiss: (() -> Void)? // Add this line

    
    func makeUIViewController(context: Context) -> WebviewController {
        let webviewController = WebviewController()
        webviewController.detector = detector

        // Clear the cache before loading the request
        clearCache()

        let request = URLRequest(url: self.url, cachePolicy: .reloadIgnoringLocalCacheData)
        webviewController.webview.load(request)
        webviewController.onDismiss = onDismiss

        return webviewController
    }

    func clearCache() {
        let dataStore = WKWebsiteDataStore.default()

        // Define which data types to remove
        let dataTypes = WKWebsiteDataStore.allWebsiteDataTypes()

        // Get the date from which we want to remove the cache (e.g., from the beginning of time)
        let date = Date(timeIntervalSince1970: 0)

        // Clear the cache for all data types
        dataStore.removeData(ofTypes: dataTypes, modifiedSince: date) {
          
        }
    }

    func updateUIViewController(_ webviewController: WebviewController, context: Context) {
        //
    }
}

class WebviewController: UIViewController, WKNavigationDelegate {
    lazy var webview: WKWebView = WKWebView()
    var detector: ScreenRecordingDetector?
    lazy var progressbar: UIProgressView = UIProgressView()
    var onDismiss: (() -> Void)? // Add this line

    override func viewWillDisappear(_ animated: Bool) {
            super.viewWillDisappear(animated)
        DispatchQueue.main.async {
            self.onDismiss?()
        }
     
        }
    
    deinit {
        self.webview.removeObserver(self, forKeyPath: "estimatedProgress")
        self.webview.scrollView.removeObserver(self, forKeyPath: "contentOffset")
        NotificationCenter.default.removeObserver(self)

    }

    override func viewDidLoad() {
        super.viewDidLoad()
     
        NotificationCenter.default.addObserver(
             self,
             selector: #selector(handleScreenshot),
             name: UIApplication.userDidTakeScreenshotNotification,
             object: nil
         )
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(screenCaptureDidChange),
            name: UIScreen.capturedDidChangeNotification,
            object: nil
        )
        
     
      
        
        self.webview.navigationDelegate = self
        self.view.addSubview(self.webview)

        self.webview.frame = self.view.frame
        self.webview.translatesAutoresizingMaskIntoConstraints = false
        self.view.addConstraints([
            self.webview.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.webview.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            self.webview.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.webview.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
        ])

        self.webview.addSubview(self.progressbar)
        self.setProgressBarPosition()

        webview.scrollView.addObserver(self, forKeyPath: "contentOffset", options: .new, context: nil)

        self.progressbar.progress = 0.1
        webview.addObserver(self, forKeyPath: "estimatedProgress", options: .new, context: nil)
    }
   
  

    @objc func handleScreenshot() {
      exit(0)
    }
    
    @objc func screenCaptureDidChange(notification: Notification) {
          DispatchQueue.main.async {
              self.detector?.isScreenRecording = UIScreen.main.isCaptured
          }
      }
    
    func setProgressBarPosition() {
        self.progressbar.translatesAutoresizingMaskIntoConstraints = false
        self.webview.removeConstraints(self.webview.constraints)
        self.webview.addConstraints([
            self.progressbar.topAnchor.constraint(equalTo: self.webview.topAnchor, constant: self.webview.scrollView.contentOffset.y * -1),
            self.progressbar.leadingAnchor.constraint(equalTo: self.webview.leadingAnchor),
            self.progressbar.trailingAnchor.constraint(equalTo: self.webview.trailingAnchor),
        ])
    }

    // MARK: - Web view progress
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        switch keyPath {
        case "estimatedProgress":
            if self.webview.estimatedProgress >= 1.0 {
                UIView.animate(withDuration: 0.3, animations: { () in
                    self.progressbar.alpha = 0.0
                }, completion: { finished in
                    self.progressbar.setProgress(0.0, animated: false)
                })
            } else {
                self.progressbar.isHidden = false
                self.progressbar.alpha = 1.0
                progressbar.setProgress(Float(self.webview.estimatedProgress), animated: true)
            }

        case "contentOffset":
            self.setProgressBarPosition()

        default:
            super.observeValue(forKeyPath: keyPath, of: object, change: change, context: context)

        }
    }
}

