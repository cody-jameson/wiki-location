//
//  helpers.swift
//  VocalTextEdit
//
//  Created by Cody Jameson on 6/3/17.
//  xw
//
import UIKit
import Foundation

class Helper{
    
    static func removeHtmlTags(data: String) -> String {
        var regrexedString = String()
        do {
            let regex =  "<[^>]+>"
            let expr = try NSRegularExpression(pattern: regex, options: NSRegularExpression.Options.caseInsensitive)
            let replacement = expr.stringByReplacingMatches(in: data, options: [], range: NSMakeRange(0, data.characters.count), withTemplate: "")
            
            regrexedString = replacement
            
  
        } catch {
            print("There was an error with the regrex function")
        }
        return regrexedString
    }
    
    static func replaceSpacesWithUnderscore(string: String) -> String{
        let replaced = (string as NSString).replacingOccurrences(of: " ", with: "_")
        return replaced
    }
   

}
