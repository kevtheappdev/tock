//
//  NewsItem.swift
//  Tock
//
//  Created by Kevin Turner on 11/23/16.
//  Copyright © 2016 Kevin Turner. All rights reserved.
//

import UIKit

struct NewsItem {
    var headline: String
    var description: String
    var image: UIImage?
    var url: URL?
    var source: String
    
    //Call only to force creation news item in case of network failure
    static func empytNews() -> [NewsItem]
    {
        return [NewsItem(headline: "News Unavailible", description: "" , image: nil, url: nil, source: "")]
    }
}
