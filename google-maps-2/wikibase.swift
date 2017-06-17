//
//  wikibase.swift
//  VocalTextEdit
//
//  Created by Cody Jameson on 6/4/17.
//  Copyright © 2017 BigNerdRanch. All rights reserved.
//

import UIKit
import Foundation
import AVFoundation

class wikibase {
    
    //static let speechSynthesizer = NSSpeechSynthesizer()
    static let speechSynthesizer = AVSpeechSynthesizer()
    static var myUtterance = AVSpeechUtterance(string: "")
    
    
    static func getWikiBody(data: Data?) -> String{
        var bodyString = String()
        
        
        do{
            let myJson = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as AnyObject
            
            if let rates = myJson["query"] as? NSDictionary
            {
                
                
                
                if let thevalue = rates["pages"] as? NSDictionary
                {
                    let pageId = thevalue.allKeys[0]
                    if pageId as! String != "-1"{
                    if let pages = thevalue[pageId] as? NSDictionary
                    {
                        bodyString = pages["extract"] as! String
                    }
                    }
                }
            }
        }
        catch{}
        
        return bodyString
        
    }


    static func searchWikipedia(titles: String) -> String {

        let url = URL(string: "https://en.wikipedia.org/w/api.php?action=query&prop=extracts&format=json&exintro=&titles=\(titles)")
        if url != nil{
               let myCompletionHandler: (Data?, URLResponse?, Error?) -> Void = { (data, response, error) in
            if error != nil
            {
                print ("ERROR in searchWikipedia function")
            }
            else
            {
                
                if data != nil
                {
                    let dirtyBody = self.getWikiBody(data: data)
                    
                    myUtterance = AVSpeechUtterance(string: Helper.removeHtmlTags(data: dirtyBody))
                    myUtterance.rate = 0.4
                    self.speechSynthesizer.stopSpeaking(at: AVSpeechBoundary.immediate)
                    self.speechSynthesizer.speak(myUtterance)
                }
                
            }
            
        }
            let task = URLSession.shared.dataTask(with: url!, completionHandler: myCompletionHandler)
            task.resume()

        }
        else{
        
            myUtterance = AVSpeechUtterance(string: Helper.removeHtmlTags(data: "Unable to speak upon that entity"))
            myUtterance.rate = 0.4
            self.speechSynthesizer.stopSpeaking(at: AVSpeechBoundary.immediate)
            self.speechSynthesizer.speak(myUtterance)
            
        }
        
        
        
        
        return "Search Complete"
        
    }

    static func stopSpeech() -> String{
        self.speechSynthesizer.stopSpeaking(at: AVSpeechBoundary.immediate)
        return "speech stopped"
    }
    
    
}
