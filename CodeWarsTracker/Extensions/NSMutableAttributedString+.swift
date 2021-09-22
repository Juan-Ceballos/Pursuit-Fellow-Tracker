//
//  NSMutableAttributedString+.swift
//  CodeWarsTracker
//
//  Created by Bienbenido Angeles on 9/21/21.
//

import UIKit

extension NSMutableAttributedString {
    var fontSize:CGFloat { return UIFont.preferredFont(forTextStyle: .body).pointSize }
    var boldFont:UIFont { return UIFont.boldSystemFont(ofSize: fontSize) }
    var normalFont:UIFont { return UIFont.systemFont(ofSize: fontSize)}
    
    func bold(_ value:String) -> NSMutableAttributedString {
        
        let attributes:[NSAttributedString.Key : Any] = [
            .font : boldFont
        ]
        
        self.append(NSAttributedString(string: value, attributes:attributes))
        return self
    }
    
    func bold(_ value: NSMutableAttributedString) -> NSMutableAttributedString {
        let attributes:[NSAttributedString.Key : Any] = [
            .font : boldFont
        ]
        guard let strRange = NSRange(value.string) else { return value }
        self.addAttributes(attributes, range: strRange)
        
        self.append(self)
        return self
    }
    
    func normal(_ value:String) -> NSMutableAttributedString {
        
        let attributes:[NSAttributedString.Key : Any] = [
            .font : normalFont,
        ]
        
        self.append(NSAttributedString(string: value, attributes:attributes))
        return self
    }
    /* Other styling methods */
    func orangeHighlight(_ value:String) -> NSMutableAttributedString {
        
        let attributes:[NSAttributedString.Key : Any] = [
            .font :  normalFont,
            .foregroundColor : UIColor.white,
            .backgroundColor : UIColor.orange
        ]
        
        self.append(NSAttributedString(string: value, attributes:attributes))
        return self
    }
    
    func blackHighlight(_ value:String) -> NSMutableAttributedString {
        
        let attributes:[NSAttributedString.Key : Any] = [
            .font :  normalFont,
            .foregroundColor : UIColor.white,
            .backgroundColor : UIColor.black
            
        ]
        
        self.append(NSAttributedString(string: value, attributes:attributes))
        return self
    }
    
    func underlined(_ value:String) -> NSMutableAttributedString {
        
        let attributes:[NSAttributedString.Key : Any] = [
            .font :  normalFont,
            .underlineStyle : NSUnderlineStyle.single.rawValue
            
        ]
        
        self.append(NSAttributedString(string: value, attributes:attributes))
        return self
    }
    
    @discardableResult
    func setAsLink(textToFind:String, linkURL:String) -> Bool {
        
        let foundRange = self.mutableString.range(of: textToFind)
        if foundRange.location != NSNotFound {
            self.addAttribute(.link, value: linkURL, range: foundRange)
            return true
        }
        return false
    }
    
    func list(listStrings:[NSMutableAttributedString], bullet: String? = nil) -> NSMutableAttributedString {
        var tempListString = listStrings
        var attributes : [NSAttributedString.Key : Any] = [
            .font: UIFont.preferredFont(forTextStyle: .body),
        ]
        
        let paragraphStyle = NSMutableParagraphStyle()
        
        
        if let bullet = bullet {
            paragraphStyle.headIndent = (bullet as NSString).size(withAttributes: attributes).width
            attributes[.paragraphStyle] = paragraphStyle
            let joinedString = tempListString.joined(separator: "\n\n", attributes: attributes)
            //let list = NSMutableAttributedString(string: joinedString, attributes: attributes)
            self.append(joinedString)
            return self
        } else {
            let bullet = 1
            paragraphStyle.headIndent = (String(bullet) as NSString).size(withAttributes: attributes).width
            attributes[.paragraphStyle] = paragraphStyle
            let joinedString = tempListString.joined(separator: "\n\n", attributes: attributes)
            //let list = NSMutableAttributedString(string: joinedString, attributes: attributes)
            self.append(joinedString)
            return self
        }
    }
    
}

extension Array where Element == NSMutableAttributedString {
    mutating func joined(separator: String, attributes: [NSAttributedString.Key : Any]) -> NSMutableAttributedString {
        let initialNSMutAtrStr = NSMutableAttributedString()
        //let seperatorNSMutAtrStr = NSMutableAttributedString(string: separator)
        for (index,element) in self.enumerated(){
            var tempNSMutAtrStr = NSMutableAttributedString(string: element.string + separator, attributes: attributes)
            if index == self.count-1{
                tempNSMutAtrStr = NSMutableAttributedString(string: element.string, attributes: attributes)
            }
            initialNSMutAtrStr.append(tempNSMutAtrStr)
        }
        
        return initialNSMutAtrStr
    }
}
