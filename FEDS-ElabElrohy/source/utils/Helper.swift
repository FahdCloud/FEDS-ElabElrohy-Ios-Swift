//
//  Helper.swift
//  FPLS-Dev
//
//  Created by Omar pakr on 26/07/2023.
//


import Foundation
import UIKit
import SystemConfiguration
import CoreLocation
import AVKit
//import FirebaseCrashlytics
import SwiftUI
import SDWebImage
import QRCode

class Helper{
    
    var lang = Locale.current.language.languageCode!.identifier
    let UUID = UIDevice.current.identifierForVendor?.uuidString
    static let toolBarColor = Helper.hexStringToUIColor(hex: "#")
    static var toast: Toast? = nil
    static var lang = Locale.current.language.languageCode!.identifier
    
    
    let container: UIView = UIView()
    let loadingView: UIView = UIView()
    let loading = UIActivityIndicatorView()
    
    
    
    @available(iOS 13.0, *)
    public static func showActivityIndicator(parentView: UIView, container: UIView, loadingView: UIView, loading: UIActivityIndicatorView) {
        container.frame = parentView.frame
        container.center = parentView.center
        container.backgroundColor = .black
        container.alpha = 0.6
        
        loadingView.frame = CGRect(x: 0, y: 0, width: 80, height: 80)
        loadingView.center = parentView.center
        loadingView.backgroundColor = .gray
        loadingView.clipsToBounds = true
        loadingView.layer.cornerRadius = 10
        
        loading.frame = CGRect(x: 0.0, y: 0.0, width: 40.0, height: 40.0)
        loading.center = CGPoint(x: loadingView.frame.size.width / 2,
                                 y: loadingView.frame.size.height / 2)
        loading.style = .large
        
        loadingView.addSubview(loading)
        container.addSubview(loadingView)
        parentView.addSubview(container)
        
        loading.startAnimating()
    }
    
    
    
    public static func appendMultiStrings(words: String) -> String{
        do {
          let newWord =   "\u{202B}\(words)\u{202C}"
            return newWord
        } catch {
            print("Error converting color: \(error.localizedDescription)")
            return words
        }
        
        
    }
    
    public static func sanitizeInput(_ input: String, maxLength : Int = 12) -> String {
       
              var sanitized = ""
              var count = 0

        for character in input {
                  if character.isNumber {
                      sanitized.insert(character, at: sanitized.startIndex)
                      count += 1
                      if count % 4 == 0 && count < maxLength {
                          sanitized.insert("-", at: sanitized.startIndex)
                      }
                      if count >= maxLength {
                          break
                      }
                  }
              }

              return sanitized
          }
    
    
    
    public static func removeUserDefaultsAndCashes(){
        do {
            // Clear UserDefaults
            let fcmToken = UserDefaultss().restoreString(key: "fcmToken")
            if let bundleID = Bundle.main.bundleIdentifier {
                UserDefaults.standard.removePersistentDomain(forName: bundleID)
            }
            // Clear URLCache
            URLCache.shared.removeAllCachedResponses()
            
            UserDefaults.standard.set(fcmToken, forKey: "fcmToken")

        } catch {
            print("Error converting color: \(error.localizedDescription)")
        }
        
        
    }
    
    public static func convertColorToUIColor(swiftUIColor: Color) -> UIColor {
        do {
            let color = try UIColor(swiftUIColor)
            return color
        } catch {
            print("Error converting color: \(error.localizedDescription)")
            return .white
        }
        
        
    }
    
    public static func hideActivityIndicator(parentView: UIView, container: UIView, loadingView: UIView, loading: UIActivityIndicatorView) {
        loading.stopAnimating()
        container.removeFromSuperview()
    }
    
    //Convert a color in hex to a UIColor
    public static func hexStringToUIColor (hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.count) != 6) {
            return UIColor.gray
        }
        
        var rgbValue:UInt64 = 0
        Scanner(string: cString).scanHexInt64(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
    func draw(_ rect: CGRect) {
        let path = UIBezierPath()
        path.move(to: CGPoint.zero)
        path.addLine(to: CGPoint(x: 320.0, y: 0.0))
        path.addLine(to: CGPoint(x: 320.0, y: 50.0))
        path.addQuadCurve(to: CGPoint(x: 0.0, y: 50.0), controlPoint: CGPoint(x: 160.0, y: 90.0))
        path.close()
        
        UIColor.red.setFill()
        
        path.fill()
    }
    
    func sizeThatFits(_ size: CGSize) -> CGSize {
        return UIImage(named: "wave")?.size ?? CGSize.zero
    }
    
    public static func showToast(style : ToastStyle , message : String) -> Toast? {
        toast = Toast(style: style, message: message,width: 300)
        return toast
    }
    
        
    public static func formateDouble ( rate : Double) -> String {
        let formattedString = String(format: "%.1f", rate)
        let formattedStrin = DateTime.replaceCharcaterInTime(language: self.lang, value: formattedString)
        
        return formattedStrin
    }
    
    
    
    public static func hexStringToUIColorWithOpacity (hex:String , alpha : CGFloat) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.count) != 6) {
            return UIColor.gray
        }
        
        var rgbValue:UInt64 = 0
        Scanner(string: cString).scanHexInt64(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: alpha
        )
    }
    
    
    
    public static func traceCrach(error : Error , userToken : String){
        //        let crash = Crashlytics.crashlytics()
        //        crash.setCrashlyticsCollectionEnabled(true)
        //        crash.record(error: error)
        //        crash.log(error.localizedDescription)
        //        crash.setUserID(userToken)
    }
    
    public static func checkContent(content : String ) -> Bool {
        if content == ""  {
            return true
        } else {
            return false
        }
    }
    
    
    public static func enToAr(number: String)->String{
        var result = ""
        for num in number {
            if num == "0" {
                result.append("٠")
            } else if num == "1" {
                result.append("١")
            } else if num == "2" {
                result.append("٢")
            } else if num == "3" {
                result.append("٣")
            } else if num == "4" {
                result.append("٤")
            } else if num == "5" {
                result.append("٥")
            } else if num == "6" {
                result.append("٦")
            } else if num == "7" {
                result.append("٧")
            } else if num == "8" {
                result.append("٨")
            } else if num == "9" {
                result.append("٩")
            } else {
                result.append(num)
            }
        }
        return result
    }
    
    public static func arToEn(number: String)->String{
        var result = ""
        for num in number {
            if num == "٠" {
                result.append("0")
            } else if num == "١" {
                result.append("1")
            } else if num == "٢" {
                result.append("2")
            } else if num == "٣" {
                result.append("3")
            } else if num == "٤" {
                result.append("4")
            } else if num == "٥" {
                result.append("5")
            } else if num == "٦" {
                result.append("6")
            } else if num == "٧" {
                result.append("7")
            } else if num == "٨" {
                result.append("8")
            } else if num == "٩" {
                result.append("9")
            } else {
                result.append(num)
            }
        }
        return result
    }
    
    
    public static func convArTime(number: String)->String{
        var result = ""
        for num in number {
            if num == "0" {
                result.append("٠")
            } else if num == "1" {
                result.append("١")
            } else if num == "2" {
                result.append("٢")
            } else if num == "3" {
                result.append("٣")
            } else if num == "4" {
                result.append("٤")
            } else if num == "5" {
                result.append("٥")
            } else if num == "6" {
                result.append("٦")
            } else if num == "7" {
                result.append("٧")
            } else if num == "8" {
                result.append("٨")
            } else if num == "9" {
                result.append("٩")
            }else if num == "A" {
                
            } else {
                result.append(num)
            }
        }
        return result
    }
    
    public static func isConnectedToNetwork() -> Bool {
        
        var zeroAddress = sockaddr_in(sin_len: 0, sin_family: 0, sin_port: 0, sin_addr: in_addr(s_addr: 0), sin_zero: (0, 0, 0, 0, 0, 0, 0, 0))
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
                SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
            }
        }
        
        var flags: SCNetworkReachabilityFlags = SCNetworkReachabilityFlags(rawValue: 0)
        if SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) == false {
            return false
        }
        
        // Working for Cellular and WIFI
        let isReachable = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
        let needsConnection = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
        let ret = (isReachable && !needsConnection)
        
        return ret
    }
    
    public static func UIColorFromHex(rgbValue:UInt32, alpha:Double=1.0)->UIColor {
        let red = CGFloat((rgbValue & 0xFF0000) >> 16)/256.0
        let green = CGFloat((rgbValue & 0xFF00) >> 8)/256.0
        let blue = CGFloat(rgbValue & 0xFF)/256.0
        return UIColor(red:red, green:green, blue:blue, alpha:CGFloat(alpha))
    }
    
    public static func deg2rad(deg:Double) -> Double {
        return deg * .pi / 180
    }
    
    public static func rad2deg(rad:Double) -> Double {
        return rad * 180.0 / .pi
    }
    
    public static func distance(lat1:Double, lon1:Double, lat2:Double, lon2:Double , unit : String) -> Double {
        let theta = lon1 - lon2
        var dist = sin(deg2rad(deg: lat1)) * sin(deg2rad(deg: lat2)) + cos(deg2rad(deg: lat1)) * cos(deg2rad(deg: lat2)) * cos(deg2rad(deg: theta))
        dist = acos(dist)
        dist = rad2deg(rad: dist)
        dist = dist * 60 * 1.1515
        if (unit == "K") {
            dist = dist * 1.609344
        }
        else if (unit == "N") {
            dist = dist * 0.8684
        }
        print(dist)
        return dist
    }
    
    public static func calculateDistance3(fromLat:Double, fromLong:Double, toLat:Double, toLong:Double ) -> Double  {
        
        let coordinate₀ = CLLocation(latitude: fromLat, longitude: fromLong)
        let coordinate₁ = CLLocation(latitude: toLat, longitude: toLong)
        
        let distanceInMeters = coordinate₀.distance(from: coordinate₁)
        
        return distanceInMeters
    }
    
    public static func calculateDistance(fromLong:Double, fromLat:Double, toLong:Double,toLat :Double ) -> Double  {
        let d2r : Double = .pi / 180
        print("The value is d2r  \(d2r)")
        let dLong : Double  = (toLong - fromLong) * d2r
        print("The value is dLong  \(dLong)")
        
        let dLat : Double = (toLat - fromLat) * d2r
        print("The value is dLat  \(dLat)")
        
        let a : Double = pow(sin(dLat / 2.0), 2) + cos(fromLat * d2r)
        * cos(toLat * d2r) * pow(sin(dLong / 2.0), 2)
        
        print("The value is a  \(a)")
        
        
        let c : Double  = 2 * atan2(sqrt(a), sqrt(1 - a))
        print("The value is c  \(c)")
        
        let d : Double  = 6367000 * c
        
        print("The value is d  \(d)")
        
        return round(d)
    }
    
    
    
    
    public static func calculateDistance2 ( fromLat:Double, fromLong:Double, toLat:Double, toLong:Double ) -> Double  {
        let  d2r  : Double = .pi / 180;
        let  dLong  : Double = (toLong - fromLong) * d2r;
        let  dLat  : Double = (toLat - fromLat) * d2r;
        let  a  : Double  = pow(sin(dLat / 2.0), 2) + cos(fromLat * d2r)
        * cos(toLat * d2r) * pow(sin(dLong / 2.0), 2);
        let  c  : Double = 2 * atan2(sqrt(a), sqrt(1 - a));
        let  d  : Double = 6367000 * c;
        return round(d);
    }
    
    public static func rounded(number : Double,toPlaces places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (number * divisor).rounded() / divisor
    }
    
    public static func secondsToHoursMinuteAndSecond(timeInSec : Double) -> String {
        let hours = Int(timeInSec) / 3600
        let minutes = (Int(timeInSec) % 3600) / 60
        let second = (Int(timeInSec) % 3600) % 60
        return String(format: "%02i:%02i:%02i", hours,minutes,second)
    }
    
    
    public static func createThumbnailOfVideoFromFileURL(videoURL: URL) -> UIImage? {
        let asset = AVAsset(url: videoURL )
        let assetImgGenerate = AVAssetImageGenerator(asset: asset)
        assetImgGenerate.appliesPreferredTrackTransform = true
        let time = CMTimeMakeWithSeconds(Float64(1), preferredTimescale: 100)
        do {
            let img = try assetImgGenerate.copyCGImage(at: time, actualTime: nil)
            let thumbnail = UIImage(cgImage: img)
            return thumbnail
        } catch {
            return UIImage(named: "man")
        }
    }
    
    
    static  func generateQRCode(from string: String) -> UIImage? {
        let data = string.data(using: String.Encoding.nonLossyASCII)
        
        if let filter = CIFilter(name: "CIQRCodeGenerator") {
            filter.setValue(data, forKey: "inputMessage")
            let transform = CGAffineTransform(scaleX: 3, y: 3)
            
            if let output = filter.outputImage?.transformed(by: transform) {
                return UIImage(ciImage: output)
            }
        }
        
        return nil
    }
    
    public static func generateBarcode(code: String) -> UIImage? {
        let data = code.data(using: String.Encoding.nonLossyASCII)
        if let filter = CIFilter(name: "CICode128BarcodeGenerator") {
            filter.setValue(data, forKey: "inputMessage")
            let transform = CGAffineTransform(scaleX: 3, y: 3)
            
            if let output = filter.outputImage?.transformed(by: transform) {
                return UIImage(ciImage: output)
            }
        }
        
        return nil
    }
    
  
    // Function to convert HTML to plain text (excluding images)
    public static  func convertHTMLToString(_ html: String?) -> String {
            // Check if the HTML string is empty or nil
            guard let html = html, !html.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
                return ""
            }

            let htmlWithoutImages = removeImageTags(from: html)

            // Catch errors in HTML to AttributedString conversion
            guard let data = htmlWithoutImages.data(using: .utf8) else {
                print("Invalid data from HTML string")
                return ""
            }
            
            do {
                let attributedString = try NSAttributedString(
                    data: data,
                    options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding: String.Encoding.utf8.rawValue],
                    documentAttributes: nil
                )
                return attributedString.string
            } catch {
                print("Error parsing HTML to AttributedString: \(error.localizedDescription)")
                return ""
            }
        }

        // Function to remove image tags from the HTML string
    public static   func removeImageTags(from html: String) -> String {
            let pattern = "<img[^>]+>"
            if let regex = try? NSRegularExpression(pattern: pattern, options: .caseInsensitive) {
                let range = NSRange(location: 0, length: html.utf16.count)
                let modifiedHTML = regex.stringByReplacingMatches(in: html, options: [], range: range, withTemplate: "")
                return modifiedHTML
            }
            return html
        }

        // Function to extract image URLs from the HTML string
    public static   func extractImageURLs(from html: String) -> [String] {
            var imageUrls = [String]()
            
            let pattern = "<img[^>]src=\"([^\"]+)\"[^>]>"
            if let regex = try? NSRegularExpression(pattern: pattern, options: .caseInsensitive) {
                let matches = regex.matches(in: html, options: [], range: NSRange(html.startIndex..., in: html))
                
                for match in matches {
                    if let range = Range(match.range(at: 1), in: html) {
                        let url = String(html[range])
                        imageUrls.append(url)
                    }
                }
            }
            
            return imageUrls
        }
    
    
    static func getPreviewItem(withName name: String) -> NSURL{
        
        //  Code to diplay file from the app bundle
        let file = name.components(separatedBy: ".")
        let path = Bundle.main.path(forResource: file.first!, ofType: file.last!)
        let url = NSURL(fileURLWithPath: path!)
        
        return url
    }
    
    static func downloadfile(completion: @escaping (_ success: Bool,_ fileLocation: URL?) -> Void){
        
        let itemUrl = URL(string: "https://api-medical-center-management-dev-v1.0.premcoprecast.com//_ServicesReservationsMedia/20211201171824PMr689790.pdf")
        
        // then lets create your document folder url
        let documentsDirectoryURL =  FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        
        // lets create your destination file url
        let destinationUrl = documentsDirectoryURL.appendingPathComponent("filename.pdf")
        
        // to check if it exists before downloading it
        if FileManager.default.fileExists(atPath: destinationUrl.path) {
            debugPrint("The file already exists at path")
            completion(true, destinationUrl)
            
            // if the file doesn't exist
        } else {
            
            // you can use NSURLSession.sharedSession to download the data asynchronously
            URLSession.shared.downloadTask(with: itemUrl!, completionHandler: { (location, response, error) -> Void in
                guard let tempLocation = location, error == nil else { return }
                do {
                    // after downloading your file you need to move it to your destination url
                    try FileManager.default.moveItem(at: tempLocation, to: destinationUrl)
                    print("File moved to documents folder")
                    completion(true, destinationUrl)
                } catch let error as NSError {
                    print(error.localizedDescription)
                    completion(false, nil)
                }
            }).resume()
        }
    }
    
    
    public static func generateThumbnail(videoURL: URL,completion: @escaping (UIImage?) -> Void) {
        DispatchQueue.global().async {
            let asset = AVAsset(url: videoURL )
            let imageGenerator = AVAssetImageGenerator(asset: asset)
            let time = CMTime(seconds: 0.0, preferredTimescale: 600)
            let times = [NSValue(time: time)]
            imageGenerator.generateCGImagesAsynchronously(forTimes: times, completionHandler: { _, image, _, _, _ in
                if let image = image {
                    completion(UIImage(cgImage: image))
                } else {
                    completion(nil)
                }
            })
        }
    }
    
    public static func getThumbnailFrom(path: URL) -> UIImage? {
        
        do {
            
            let asset = AVURLAsset(url: path , options: nil)
            let imgGenerator = AVAssetImageGenerator(asset: asset)
            imgGenerator.appliesPreferredTrackTransform = true
            let cgImage = try imgGenerator.copyCGImage(at: CMTimeMake(value: 0, timescale: 5), actualTime: .none)
            let thumbnail = UIImage(cgImage: cgImage)
            
            return thumbnail
            
        } catch let error {
            
            print("*** Error generating thumbnail: \(error.localizedDescription)")
            return UIImage(named: "man")
            
        }
        
    }
    
    public static func makePhoneCall(phoneNumber: String) {
        guard let url = URL(string: "tel://\(phoneNumber.replacingOccurrences(of: " ", with: ""))"),
              UIApplication.shared.canOpenURL(url) else {
            // Show an alert or toast to inform the user that the call could not be made
            return
        }
        
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
    
    public static func downloadFileReq(url :String){
        let url = url
        let fileName = Constants().REQUIREMNETNAME
        
        savePdfReq(urlString: url, fileName: fileName)
        
    }
    
    public static  func savePdfReq(urlString:String, fileName:String) {
        DispatchQueue.main.async {
            let url = URL(string: urlString)
            let pdfData = try? Data.init(contentsOf: url!)
            let resourceDocPath = (FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)).last! as URL
            let pdfNameFromUrl = fileName
            let actualPath = resourceDocPath.appendingPathComponent(pdfNameFromUrl)
            do {
                try pdfData?.write(to: actualPath, options: .atomic)
                
            } catch {
                
            }
        }
    }
    
    public static func downloadFile(url :String){
        let url = url
        let fileName = Constants().TREATMENTNAME
        
        savePdf(urlString: url, fileName: fileName)
        
    }
    
    public static  func savePdf(urlString:String, fileName:String) {
        DispatchQueue.main.async {
            let url = URL(string: urlString)
            let pdfData = try? Data.init(contentsOf: url!)
            let resourceDocPath = (FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)).last! as URL
            let pdfNameFromUrl = fileName
            let actualPath = resourceDocPath.appendingPathComponent(pdfNameFromUrl)
            do {
                try pdfData?.write(to: actualPath, options: .atomic)
                
            } catch {
                
            }
        }
    }
    
    public func openSettings(){
        guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {
            return
        }
        
        if UIApplication.shared.canOpenURL(settingsUrl) {
            UIApplication.shared.open(settingsUrl, completionHandler: { (success) in
                print("Settings opened: \(success)") // Prints true
            })
        }
    }
}

extension UIView {
    
    public func round(corners: UIRectCorner, cornerRadius: Double) {
        
        let size = CGSize(width: cornerRadius, height: cornerRadius)
        let bezierPath = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: size)
        let shapeLayer = CAShapeLayer()
        shapeLayer.frame = self.bounds
        shapeLayer.path = bezierPath.cgPath
        self.layer.mask = shapeLayer
    }
    func rotate(_ toValue: CGFloat, duration: CFTimeInterval = 0.2) {
        let animation = CABasicAnimation(keyPath: "transform.rotation")
        
        animation.toValue = toValue
        animation.duration = duration
        animation.isRemovedOnCompletion = false
        animation.fillMode = CAMediaTimingFillMode.forwards
        
        self.layer.add(animation, forKey: nil)
    }
    
    
    
}

extension String{
    var isContainsLetters : Bool{
        let letters = CharacterSet.letters
        return self.rangeOfCharacter(from: letters) != nil
    }
    public func toBase64() -> String? {
        guard let data = data(using: String.Encoding.utf8) else {
            return nil
        }
        return data.base64EncodedString(options: Data.Base64EncodingOptions(rawValue: 0))
    }
    
    public static func isValidpassword() -> Bool{
        let regex = "^(?=.*?\\p{Lu})(?=.*?\\p{Ll})(?=.*?\\d)(?=.*?[`~!@#$%^&*()\\-_=+\\\\|\\[{\\]};:'\",<.>/?]).*$"
        let passwordtesting = NSPredicate(format: "SELF MATCHES %@", regex)
        return passwordtesting.evaluate(with: self)
    }
    
    public func toString() -> String? {
        return NumberFormatter().number(from: self)?.stringValue
    }
    
    
    var localized: String {
        if let _ = UserDefaults.standard.string(forKey: Constants().PREFERD_LANGUAGE) {} else {
            // we set a default, just in case
            UserDefaults.standard.set(Constants().APP_IOS_LANGUAGE_AR, forKey: Constants().PREFERD_LANGUAGE)
            UserDefaults.standard.synchronize()
        }
        
        let lang = UserDefaults.standard.string(forKey: Constants().PREFERD_LANGUAGE)
        
        let path = Bundle.main.path(forResource: lang, ofType: "lproj")
        let bundle = Bundle(path: path!)
        
        return NSLocalizedString(self, tableName: nil, bundle: bundle!, value: "", comment: "")
    }
    
    
    
}


extension UIViewController{
    func detectScreenShotAndScreenVideo(){
        
        // NotificationCenter.default.addObserver(self, selector: #selector(self.didTakeScreen(notification:)), name: UIApplication.userDidTakeScreenshotNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(screenRecord(notification:)), name: UIScreen.capturedDidChangeNotification, object: nil)
    }
    
    
    public func playVideo(path: String) throws{
        let player = AVPlayer(url: URL(string: path)!)
        
        let playerViewController = AVPlayerViewController()
        playerViewController.player = player
        
        present(playerViewController, animated: true) {
            player.play()
            self.detectScreenShotAndScreenVideo()
        }
    }
    
    @objc func didTakeScreen(notification : Notification){
        exit(-1)
    }
    
    @objc func screenRecord(notification : Notification){
        exit(-1)
    }
    
    
    
}

private var kAssociationKeyMaxLength: Int = 0

extension UITextField {
    
    @IBInspectable var maxLength: Int {
        get {
            if let length = objc_getAssociatedObject(self, &kAssociationKeyMaxLength) as? Int {
                return length
            } else {
                return Int.max
            }
        }
        set {
            objc_setAssociatedObject(self, &kAssociationKeyMaxLength, newValue, .OBJC_ASSOCIATION_RETAIN)
            self.addTarget(self, action: #selector(checkMaxLength), for: .editingChanged)
        }
    }
    
    //The method is used to cancel the check when use Chinese Pinyin input method.
    //Becuase the alphabet also appears in the textfield when inputting, we should cancel the check.
    public func isInputMethod() -> Bool {
        if let positionRange = self.markedTextRange {
            if let _ = self.position(from: positionRange.start, offset: 0) {
                return true
            }
        }
        return false
    }
    
    
    @objc func checkMaxLength(textField: UITextField) {
        
        guard !self.isInputMethod(), let prospectiveText = self.text,
              prospectiveText.count > maxLength
        else {
            return
        }
        
        let selection = selectedTextRange
        let maxCharIndex = prospectiveText.index(prospectiveText.startIndex, offsetBy: maxLength)
        text = prospectiveText.substring(to: maxCharIndex)
        selectedTextRange = selection
    }
}

extension UIApplication {
    class func tryURL(urlString: String) {
        guard let url = URL(string: urlString), UIApplication.shared.canOpenURL(url) else {
            // Handle the case where the URL cannot be opened or is empty
            print("Invalid URL")
            return
        }
        
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            UIApplication.shared.openURL(url)
        }
    }
    
    
}

extension CAShapeLayer {
    func drawRoundedRect(rect: CGRect, andColor color: UIColor, filled: Bool) {
        fillColor = filled ? color.cgColor : UIColor.white.cgColor
        strokeColor = color.cgColor
        path = UIBezierPath(roundedRect: rect, cornerRadius: 7).cgPath
    }
}

private var handle: UInt8 = 0;

extension UIBarButtonItem {
    private var badgeLayer: CAShapeLayer? {
        if let b: AnyObject = objc_getAssociatedObject(self, &handle) as AnyObject? {
            return b as? CAShapeLayer
        } else {
            return nil
        }
    }
    
    func setBadge(text: String?, withOffsetFromTopRight offset: CGPoint = CGPoint.zero, andColor color:UIColor = UIColor.red, andFilled filled: Bool = true, andFontSize fontSize: CGFloat = 11)
    {
        badgeLayer?.removeFromSuperlayer()
        
        if (text == nil || text == "") {
            return
        }
        
        addBadge(text: text!, withOffset: offset, andColor: color, andFilled: filled)
    }
    
    func addBadge(text: String, withOffset offset: CGPoint = CGPoint.zero, andColor color: UIColor = UIColor.red, andFilled filled: Bool = true, andFontSize fontSize: CGFloat = 11)
    {
        guard let view = self.value(forKey: "view") as? UIView else { return }
        
        var font = UIFont.systemFont(ofSize: fontSize)
        
        if #available(iOS 9.0, *) { font = UIFont.monospacedDigitSystemFont(ofSize: fontSize, weight: UIFont.Weight.regular) }
        let badgeSize = text.size(withAttributes: [NSAttributedString.Key.font: font])
        
        // Initialize Badge
        let badge = CAShapeLayer()
        
        let height = badgeSize.height;
        var width = badgeSize.width + 2 /* padding */
        
        //make sure we have at least a circle
        if (width < height) {
            width = height
        }
        
        //x position is offset from right-hand side
        let x = view.frame.width - width + offset.x
        
        let badgeFrame = CGRect(origin: CGPoint(x: x, y: offset.y), size: CGSize(width: width, height: height))
        
        badge.drawRoundedRect(rect: badgeFrame, andColor: color, filled: filled)
        view.layer.addSublayer(badge)
        
        // Initialiaze Badge's label
        let label = CATextLayer()
        if #available(iOS 16, *) {
            if Locale.current.language.languageCode?.identifier == Constants().APP_LANGUAGE_AR {
                label.string = Helper.enToAr(number:text)
            } else{
                label.string = Helper.arToEn(number:text)
            }
        } else {
            // Fallback on earlier versions
        }
        
        label.alignmentMode = CATextLayerAlignmentMode.center
        label.font = font
        label.fontSize = font.pointSize
        
        label.frame = badgeFrame
        label.foregroundColor = filled ? UIColor.white.cgColor : color.cgColor
        label.backgroundColor = UIColor.clear.cgColor
        label.contentsScale = UIScreen.main.scale
        badge.addSublayer(label)
        
        // Save Badge as UIBarButtonItem property
        objc_setAssociatedObject(self, &handle, badge, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
    }
    
    func removeBadge() {
        badgeLayer?.removeFromSuperlayer()
    }
}

extension UIImage {
    
    static func pathZigZagForCGRect(rect: CGRect) ->UIBezierPath
    {
        let width = rect.size.width
        let height = rect.size.height
        
        let zigZagWidth = CGFloat(7)
        let zigZagHeight = CGFloat(5)
        var yInitial = height-zigZagHeight
        
        var zigZagPath = UIBezierPath()
        zigZagPath.move(to: CGPoint(x:0, y:0))
        zigZagPath.addLine(to: CGPoint(x:0, y:yInitial))
        
        var slope = -1
        var x = CGFloat(0)
        var i = 0
        while x < width {
            x = zigZagWidth * CGFloat(i)
            let p = zigZagHeight * CGFloat(slope) - 5
            let y = yInitial + p
            let point = CGPoint(x: x, y: y)
            zigZagPath.addLine(to: point)
            slope = slope*(-1)
            i += 1
        }
        
        zigZagPath.addLine(to: CGPoint(x:width,y: 0))
        zigZagPath.addLine(to: CGPoint(x:0,y: 0))
        zigZagPath.close()
        return zigZagPath
    }
    
    
    static func zigZagImage(rect: CGRect,color:UIColor)->UIImage {
        
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 0)
        var ctx = UIGraphicsGetCurrentContext()!
        ctx.clear(CGRect(x: 0, y: 0, width: rect.size.width, height: rect.size.height))
        
        ctx.setFillColor(color.cgColor)
        let path = UIImage.pathZigZagForCGRect(rect: rect)
        ctx.addPath(path.cgPath)
        ctx.fillPath()
        //draw triangle
        
        let img = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        return img
    }
    
    
    
}

extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape( RoundedCorner(radius: radius, corners: corners) )
    }
}


