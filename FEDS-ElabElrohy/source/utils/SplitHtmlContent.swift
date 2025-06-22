//
//  SplitHtmlContent.swift
//  FEDS-Center-Dev-IOS
//
//  Created by Omar pakr on 28/02/2024.
//

import Foundation
class SplitHtmlContent {
    static func parseHTML(htmlString: String) -> (text: String, imageUrls: [String]) {
        var text = htmlString
        var imageUrls: [String] = []
        
        // Regular expression to find image tags
        let imageTagRegex = "<img[^>]+src\\s*=\\s*['\"]([^'\"]+)['\"][^>]*>"
        
        // Find and extract image URLs
        if let regex = try? NSRegularExpression(pattern: imageTagRegex, options: []) {
            let nsString = htmlString as NSString
            let results = regex.matches(in: htmlString, options: [], range: NSRange(location: 0, length: nsString.length))
            
            for result in results {
                if result.range.location != NSNotFound, result.range.length > 1 {
                    let imageUrl = nsString.substring(with: result.range(at: 1))
                    imageUrls.append(imageUrl)
                }
            }
            
            // Remove image tags from the text
            text = regex.stringByReplacingMatches(in: htmlString, options: [], range: NSRange(location: 0, length: nsString.length), withTemplate: "")
        }
        
        // Strip remaining HTML tags (optional, if you want pure text)
        let tagRegex = "<[^>]+>"
        if let regex = try? NSRegularExpression(pattern: tagRegex, options: []) {
            let range = NSRange(location: 0, length: text.utf16.count)
            text = regex.stringByReplacingMatches(in: text, options: [], range: range, withTemplate: "")
        }
        
        return (text.trimmingCharacters(in: .whitespacesAndNewlines), imageUrls)
    }
    
}
