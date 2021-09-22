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
        let rangeOfString = 0..<value.string.count
        let range = NSRange(rangeOfString)
        value.addAttributes(attributes, range: range)
        
        self.append(value)
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
    
    func setAsLink(textToFind:String, linkURL:String) -> NSMutableAttributedString? {
        
        let foundRange = self.mutableString.range(of: textToFind)
        
        if foundRange.location != NSNotFound {
            self.addAttribute(.link, value: linkURL, range: foundRange)
            return self
        } else {
            return nil
        }
    }
    
    /*bullet point needs to be done creating arr of NSMutableAttributedString
     Ex:
     var listStrings = [
         "Log into your Codewars account and navigate to My Account",
         "Scroll down to the section that is titled: Webhooks.",
         "Copy and paste this following URL into the 'Payload url' box: https://codewars-tracker-be.herokuapp.com/codewars",
         "Click on the 'Update' button at the bottom of the page."
     ].map { str -> NSMutableAttributedString in
         bullet += 1
         return NSMutableAttributedString(string: String(bullet) + ". " + str)
     }
 */
    func list(listNSStrings:[NSMutableAttributedString]? = nil, listStrings:[String]? = nil , bullet: String? = nil) throws -> NSMutableAttributedString {
        var tempListString = listNSStrings
        var attributes : [NSAttributedString.Key : Any] = [
            .font: UIFont.preferredFont(forTextStyle: .body),
        ]
                
        let paragraphStyle = NSMutableParagraphStyle()
        
        if let listStrings = listStrings {
            let bullet = bullet != nil ? bullet! : "-"
            tempListString = listStrings.map{NSMutableAttributedString(string:bullet + " " + $0)}
            paragraphStyle.headIndent = (bullet as NSString).size(withAttributes: attributes).width
            attributes[.paragraphStyle] = paragraphStyle
            let joinedString = tempListString!.joined(separator: "\n\n", attributes: attributes)
            //let list = NSMutableAttributedString(string: joinedString, attributes: attributes)
            self.append(joinedString)
            return self
        } else if let listNSStrings = tempListString, bullet == nil{
            //func is default to list by numbers
            let bullet = listNSStrings.count
            paragraphStyle.headIndent = (String(bullet) as NSString).size(withAttributes: attributes).width
            attributes[.paragraphStyle] = paragraphStyle
            let joinedString = tempListString!.joined(separator: "\n\n", attributes: attributes)
            //let list = NSMutableAttributedString(string: joinedString, attributes: attributes)
            self.append(joinedString)
            //print(joinedString)
            return self
        } else {
            fatalError("If using an array of NSMutableAttributedString, do not include a bullet point and format it in beforehand via an array of strings. jump to def. of NSMutableAttributedString.list() for an example.")
        }
    }
    
}

extension Array where Element == NSMutableAttributedString {
    func joined(separator: String, attributes: [NSAttributedString.Key : Any]) -> NSMutableAttributedString {
        let initialNSMutAtrStr = NSMutableAttributedString()
        //let seperatorNSMutAtrStr = NSMutableAttributedString(string: separator)
        for (index,element) in self.enumerated(){
            let value = element
            let rangeOfString = 0..<value.string.count
            let range = NSRange(rangeOfString)
            value.addAttributes(attributes, range: range)
            let nsAtrStrSep = NSAttributedString(string: separator)
            
            if index != self.count-1{
                value.append(nsAtrStrSep)
            }
            initialNSMutAtrStr.append(value)
        }
        
        
        return initialNSMutAtrStr
    }
}
