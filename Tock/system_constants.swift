//
//  wake_ups.swift
//  Tock
//
//  Created by Kevin Turner on 7/3/16.
//  Copyright © 2016 Kevin Turner. All rights reserved.
//

enum wakeUpTypes: String
{
    case wakeUpTypeNews = "News"
    case wakeUpTypeCal = "Calendar"
    case wakeUpTypeWeather = "Weather"
    case wakeUpTypePocket = "Pocket"
    case wakeUpTypeTwitter = "Twitter"
    case wakeUpTypeTransit = "Transit"
}


enum  newsTypes: String {
    case arsTechnica = "arstechnica"
    case bbcNews = "bbcnews"
    case bbcSport = "bbcsport"
    case bloomBerg = "bloomberg"
    case buzzfeed = "buzzFeed"
    case cnbc = "cnbc"
    case cnn = "cnn"
    case engadget = "engadget"
    case entertainmentWeekly = "entertainmentweekly"
    case espn = "espn"
    case googleNews = "googlenews"
    case hackerNews = "hackernews"
    case independent = "independent"
    case mashable = "mashable"
    case recode = "recode"
    case reddit = "redditrall"
    case reuters = "reuters"
    case techCrunch = "techcrunch"
    case theGuardian = "theguardianuk"
    case theHuffingtonPost = "thehuffingtonpost"
    case theNYT = "thenewyorktimes"
    case TNW = "thenextweb"
    case theVerge = "theverge"
    case wsj = "the wallstreetjournal"
    case washingtonPost = "thewashingtonpost"
}



enum settingsTypes: Int {
    case button
    case toggle
    case numberAdjust
    case checkmark
}

enum actionTypes: String {
    case removed = "Removed"
    case added = "Added"
}

enum locationSelection : Int {
    case home
    case work
}

let locationKey = "location"
let wakeUpsKey = "wake_ups"
let wakeUpTimeKey = "wake_up_time"
let onboardedKey = "onboarded"
let locationStringKey = "location_string"

let fromLocationKey = "from_location"
let toLocationKey = "to_location"
let fromLocationNameKey = "from_name"
let toLocationNameKey = "to_name"

let newsSourcesKey = "news_sources"

let numArticlesKey = "num_articles_key"
let numSentSumKey = "num_sent_sum_key"



