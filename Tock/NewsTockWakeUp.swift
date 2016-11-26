//
//  NewsTockWakeUp.swift
//  Tock
//
//  Created by Kevin Turner on 7/14/16.
//  Copyright © 2016 Kevin Turner. All rights reserved.
//

import Foundation
import UIKit

class NewsTockWakeUp: TockWakeUp, KTRequesterDelegate {
    let baseApiURL = "https://newsapi.org/v1/articles?apiKey=d81a4d8b7cec49c0b1272494d5967451&source="
    let requester = KTRequester()
    var sources:[newsTypes] = []
    var sentences:[String] = []
    let newsQueue = Queue<NewsItem>()
    var newsItems = Array<Array<NewsItem>>()
   
    
    init(){
        super.init(name: "News")
        let userDefaults = UserDefaults.standard
        let stringSources = userDefaults.object(forKey: newsSourcesKey) as! [String]
        for source in stringSources {
            sources.append(newsTypes(rawValue: source)!)
        }
    }
    
    
    override func fetchData() {
        requester.delegate = self
        let lastIndex = sources.count - 1
        var index = 0
        for source in sources {
            var type = requestType.regular
            if lastIndex == index {
                type = .last
                print("THe last request to make is \(source.rawValue)")
            } else {
                type = .regular
                print("The regular request to make \(source.rawValue)")
            }
            
            let url = URL(string: baseApiURL + source.rawValue)
           
            requester.makeRequest(url!, type: type)
            index += 1
        }
        
      
    }
    
    
    
    func requestCompleted(_ data: Data, type: requestType) {
        
                let dic = jsonDic(data)
                print("dic \(dic)")
            if dic != nil  {
                let source = dic!["source"] as! String
                print("the source is \(source) and the type is \(type)")
                let name = newsNameForType(type: newsTypes(rawValue: source)!)
                self.sentences.append("From \(name)")
               var sourceArticles = Array<NewsItem>()
                let articles = dic!["articles"] as? NSArray
                if articles != nil {
                    var i = 0;
                    for article in articles! {
                        if i >= 5 {
                            break
                        }
                        let dicArticle = article as! NSDictionary
                        let articleURL = dicArticle["url"] as! String
                        let title = dicArticle["title"] as! String
                        let imageURLString = dicArticle["urlToImage"] as! String
                        let imageUrl = URL(string: imageURLString)
                       
                        
                         let imageData = try? Data(contentsOf: imageUrl!)
                        var image = UIImage()
                        if let imageD = imageData {
                            image = UIImage(data: imageD)!
                        } else {
                            image = #imageLiteral(resourceName: "newspaper.png")
                        }
                        self.sentences.append(title + ", ")
                        let description = dicArticle["description"] as! String
                        let newsItem = NewsItem(headline: title, description: description, image: image, url: URL(string: articleURL)!, source: source)
                        //newsQueue.queue(item: newsItem)
                        print("The image url is \(imageURLString)")
                       
                        //requester.downloadRequest(url: imageUrl!)
                        
                       sourceArticles.append(newsItem)
                       
                        
                        i += 1
                    }
                    
                    newsItems.append(sourceArticles)
                    
                    
            }
        }
        
        if type == .last
        {
            self.delegate?.finishedDataFetch()
        }
        
        print("request completed: \(sentences)")
    }
    
    func jsonDic(_ data: Data) -> NSDictionary? {
        do {
            let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
             return json as? NSDictionary
        } catch let jsonError as NSError {
            print("json error: \(jsonError.localizedDescription)")
            return nil
        }
        
       
    }
    
    
    override func stringsToVerbalize() -> [String] {
        print(sentences)
        return sentences
    }
    
    func requestFailed(_ error: NSError) {
        
    }
}
