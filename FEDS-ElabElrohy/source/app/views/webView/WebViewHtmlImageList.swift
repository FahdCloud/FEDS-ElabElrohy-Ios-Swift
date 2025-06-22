//
//  WebViewImageList.swift
//  FEDS-Dev-Ver-One
//
//  Created by Omar Pakr on 08/10/2024.
//


import SwiftUI
import WebKit

struct WebViewHtmlImageList: UIViewControllerRepresentable {
    var imageUrls: [String] // List of image URLs
    var detector: ScreenRecordingDetector
    var onDismiss: (() -> Void)? // Optional closure to call on dismiss
    
    func makeUIViewController(context: Context) -> WebviewImageListController {
        let webviewController = WebviewImageListController()
        webviewController.detector = detector
        
        // Clear the cache before loading the request
        clearCache()
        
        // Generate HTML content from image URLs
        let htmlContent = generateHTML(from: imageUrls)
        webviewController.loadHTMLContent(htmlContent)
        webviewController.onDismiss = onDismiss
        
        return webviewController
    }
    
    func clearCache() {
        let dataStore = WKWebsiteDataStore.default()
        let dataTypes = WKWebsiteDataStore.allWebsiteDataTypes()
        let date = Date(timeIntervalSince1970: 0)
        
        dataStore.removeData(ofTypes: dataTypes, modifiedSince: date) {
            // Cache cleared
        }
    }
    
    func updateUIViewController(_ webviewController: WebviewImageListController, context: Context) {
        // You may implement this if you want to update the content dynamically
    }
    
    private func generateHTML(from imageUrls: [String]) -> String {
        let htmlImages = imageUrls.map { "<img src='\($0)' style='width: 100%;'/>" }.joined()
        return "<html><body>\(htmlImages)</body></html>"
    }
}

class WebviewImageListController: UIViewController, WKNavigationDelegate {
    lazy var webview: WKWebView = WKWebView()
    var detector: ScreenRecordingDetector?
    lazy var progressbar: UIProgressView = UIProgressView()
    var onDismiss: (() -> Void)?
    
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
        setupWebView()
        setupProgressBar()
        setupObservers()
    }
    
    func loadHTMLContent(_ html: String) {
        let request = URLRequest(url: URL(string: "about:blank")!) // Load a blank page first
        webview.load(request) // Load the blank page to ensure the webview is ready
        webview.loadHTMLString(html, baseURL: nil) // Then load your HTML content
    }
    
    private func setupWebView() {
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
    }
    
    private func setupProgressBar() {
        self.webview.addSubview(self.progressbar)
        setProgressBarPosition()
        
        webview.scrollView.addObserver(self, forKeyPath: "contentOffset", options: .new, context: nil)
        self.progressbar.progress = 0.1
        webview.addObserver(self, forKeyPath: "estimatedProgress", options: .new, context: nil)
    }
    
    private func setupObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(handleScreenshot), name: UIApplication.userDidTakeScreenshotNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(screenCaptureDidChange), name: UIScreen.capturedDidChangeNotification, object: nil)
    }
    
    @objc func handleScreenshot() {
        exit(0)
    }
    
    @objc func screenCaptureDidChange(notification: Notification) {
        DispatchQueue.main.async {
            self.detector?.isScreenRecording = UIScreen.main.isCaptured
        }
    }
    
    private func setProgressBarPosition() {
        self.progressbar.translatesAutoresizingMaskIntoConstraints = false
        self.webview.removeConstraints(self.webview.constraints)
        self.webview.addConstraints([
            self.progressbar.topAnchor.constraint(equalTo: self.webview.topAnchor, constant: self.webview.scrollView.contentOffset.y * -1),
            self.progressbar.leadingAnchor.constraint(equalTo: self.webview.leadingAnchor),
            self.progressbar.trailingAnchor.constraint(equalTo: self.webview.trailingAnchor),
        ])
    }
    
    // MARK: - Web view progress
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey: Any]?, context: UnsafeMutableRawPointer?) {
        switch keyPath {
        case "estimatedProgress":
            if self.webview.estimatedProgress >= 1.0 {
                UIView.animate(withDuration: 0.3, animations: {
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
