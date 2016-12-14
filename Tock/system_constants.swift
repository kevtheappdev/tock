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
    case wakeUpTypeTransit = "Transit"
    case wakeUpTypeReminder = "Reminders"
}


enum  newsTypes: String {
    case arsTechnica = "ars-technica"
    case bbcNews = "bbc-news"
    case bbcSport = "bbc-sport"
    case bloomBerg = "bloomberg"
    case buzzfeed = "buzzfeed"
    case cnbc = "cnbc"
    case cnn = "cnn"
    case engadget = "engadget"
    case entertainmentWeekly = "entertainment-weekly"
    case espn = "espn"
    case googleNews = "google-news"
    case hackerNews = "hacker-news"
    case independent = "independent"
    case mashable = "mashable"
    case recode = "recode"
    //case reddit = "reddit-r-all"
    case reuters = "reuters"
    case techCrunch = "techcrunch"
    case theGuardian = "theguardianuk"
    case theHuffingtonPost = "thehuffingtonpost"
    case theNYT = "thenewyorktimes"
    case TNW = "thenextweb"
    case theVerge = "the-verge"
    case wsj = "the-wall-street-journal"
    case none = ""
    //case washingtonPost = "the-washington-post"
}



enum settingsTypes: Int {
    case button
    case toggle
    case segmentedControl
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

let alarmSoundKey = "alarm_sound"
let speechSpeedKey = "speech_speed"
let snoozeTimeKey = "snooze_time"
let autoGreetignKey = "auto_greeting"

let unitsKey = "unitsKey"
let incompRemindKey = "incomp_remind"

let calendarsKey = "selected_calendars"
let launchTimesKey = "launch_times"

let fromLocationKey = "from_location"
let toLocationKey = "to_location"
let fromLocationNameKey = "from_name"
let toLocationNameKey = "to_name"
let isOnKey = "on_key"
let newsSourcesKey = "news_sources"

let numArticlesKey = "num_articles_key"
let numSentSumKey = "num_sent_sum_key"

let months = ["January", "February", "March", "April", "May", "June", "July", "August","September", "October", "November", "December"]


func newsNameForType(type: newsTypes) -> String{
    switch type {
    case .arsTechnica:
        return "ArsTechnica"
    case .bbcNews:
        return "BBC News"
    case .bbcSport:
        return "BBC Sports"
    case .bloomBerg:
        return "Bllomberg"
    case .buzzfeed:
        return "BuzzFeed"
    case .cnbc:
        return "CNBC"
    case .cnn:
        return "CNN"
    case .engadget:
        return "Engadget"
    case .entertainmentWeekly:
        return "Entertainment Weekly"
    case .espn:
        return "ESPN"
    case .googleNews:
        return "Google News"
    case .hackerNews:
        return "Hacker News"
    case .independent:
        return "The Independet"
    case .mashable:
        return "Mashable"
    case .recode:
        return "Recode"
//    case .reddit:
//        return "Reddit r/all"
    case .reuters:
        return "Reuters"
    case .techCrunch:
        return "TechCrunch"
    case .theGuardian:
        return "The Guardian"
    case .theHuffingtonPost:
        return "The Huffington Post"
    case .theNYT:
        return "The New York Times"
    case .TNW:
        return "The Next Web"
    case .theVerge:
        return "The Verge"
//    case .washingtonPost:
//        return "The Washington Post"
    case .wsj:
        return "The Wall Street Journal"
    case .none:
        return "News"
    }
}



