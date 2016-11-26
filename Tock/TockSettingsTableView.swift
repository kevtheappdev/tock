//
//  TockSettingsTableView.swift
//  Tock
//
//  Created by Kevin Turner on 7/15/16.
//  Copyright © 2016 Kevin Turner. All rights reserved.
//

import UIKit

import GoogleMaps
import GooglePlaces
import GooglePlacePicker



class TockSettingsTableView: UITableView, UITableViewDelegate, UITableViewDataSource, TockEventsMangerDelegate, TockLocationManagerDelegate, GMSAutocompleteViewControllerDelegate{
    /**
     * Called when a non-retryable error occurred when retrieving autocomplete predictions or place
     * details. A non-retryable error is defined as one that is unlikely to be fixed by immediately
     * retrying the operation.
     * <p>
     * Only the following values of |GMSPlacesErrorCode| are retryable:
     * <ul>
     * <li>kGMSPlacesNetworkError
     * <li>kGMSPlacesServerError
     * <li>kGMSPlacesInternalError
     * </ul>
     * All other error codes are non-retryable.
     * @param viewController The |GMSAutocompleteViewController| that generated the event.
     * @param error The |NSError| that was returned.
     */
    public func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
        print("It did not go well: \(error)")
    }

    
    let allNews: [newsTypes] = [.arsTechnica, .bbcNews, .bbcSport, .bloomBerg, .buzzfeed, .cnbc, .cnn, .engadget, .entertainmentWeekly, .espn, .googleNews, .hackerNews, .independent, .mashable, .recode, .reddit, .reuters, .techCrunch, .theGuardian, .theHuffingtonPost, .theNYT, .TNW, .theVerge, .wsj]
    var settings: [(name: String, type: settingsTypes, image: UIImage?)]!
    var selectionDelegate: TockSettingsSelectionDelegate?
    let wuManager = WakeUpManager()
    var typeAdded = false
    var locationManager:TockLocationManager!
    var currentLocation: String?
    var homeSelected = false
    var workSelected = false
    let uDefaults = UserDefaults.standard
    var locationType: locationSelection!
    var selectedIndexes = Array<Int>()
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.delegate = self
        self.dataSource = self
        
    }
    
    fileprivate var wakeup: wakeUpTypes!
    
    fileprivate var usersNews: [newsTypes]?
    
    var myNews: [newsTypes] {
        get {
            return usersNews!
        }
        
        set {
           usersNews = newValue
            if usersNews != nil {
            for news in usersNews! {
               let index = self.allNews.index(of: news)!
               selectedIndexes.append(index)
            }
                if usersNews!.count > 0{
                    self.selectionDelegate?.buttonEnabled(true)
                }
            }
            
            print("selected indexes: \(selectedIndexes)")
            
        }
    }
    
    var wakeupType: wakeUpTypes{
        get {
            return wakeup
        }
        
        set {
            self.wakeup = newValue
         
             self.typeAdded = evaluateAdded()
            
            
            
            self.settings = configsForType(newValue)
            self.reloadData()
        }
    }
    
    
    fileprivate func evaluateAdded()-> Bool
    {
        return wuManager.wakeUpExists(self.wakeupType)
    }
    
    fileprivate func configsForType(_ type: wakeUpTypes) -> [(name: String, type: settingsTypes, image: UIImage?)]?{
        switch type {
        case .wakeUpTypeCal:
            var calTuple:(name: String, type: settingsTypes, image: UIImage?) =  (name: "Grant access to Calendar", type: .button, image: #imageLiteral(resourceName: "calendar.png"))
            if typeAdded{
                calTuple.name = "Calendar Access Granted"
            }
            return [calTuple]
        case .wakeUpTypeWeather:
            var weatherTuple:(name: String, type: settingsTypes, image: UIImage?) = (name: "Use Current Location", type: .button, image: #imageLiteral(resourceName: "location2.png"))
            if typeAdded {
                weatherTuple.name = self.currentLocation!
            }
            return [weatherTuple]
        case .wakeUpTypeNews:
            let sources = newsSources()
            var options: [(name: String, type: settingsTypes, image: UIImage?)] = [(name: "Number of articles to read", type: .numberAdjust, image: nil), (name: "Number of sentences in summary", type: .numberAdjust, image: nil)]
            options += sources
            
            return sources
        case .wakeUpTypePocket:
            return [(name: "Login with Pocket", type: .button, image: UIImage(named:"pocket")), (name: "Number of articles to read", type: settingsTypes.numberAdjust, image: nil)]
        case .wakeUpTypeTransit:
            var fromTuple: (name: String, type: settingsTypes, image: UIImage?) = (name: "Select home location", type: .button, image: UIImage(named:"home3"))
            var toTuple: (name: String, type: settingsTypes, image: UIImage?) = (name: "Select work/school location", .button, image: UIImage(named:"office"))
            if self.homeSelected || self.typeAdded{
                fromTuple.name = uDefaults.value(forKey: fromLocationNameKey) as! String
            }
            
            if self.workSelected || self.typeAdded {
                 toTuple.name = uDefaults.value(forKey: toLocationNameKey) as! String
            }
            
            return [fromTuple, toTuple]
        case .wakeUpTypeTwitter:
            var twitterTuple:(name: String, type: settingsTypes, image: UIImage?) = (name: "Login with Twitter", type: .button, image: UIImage(named:"twitter"))
            if typeAdded {
                twitterTuple.name = "Logged In"
            }
            return [twitterTuple, (name: "Number of tweets to read", type: .numberAdjust, image: nil)]

        }
    }
    
    func newsSources() -> Array<(name: String, type: settingsTypes, image: UIImage?)>
    {
        var sources = Array<(name: String, type: settingsTypes, image: UIImage?)>()
        
        for news in allNews {
            switch news {
            case .arsTechnica:
                sources.append((name: "Ars Technica", type: .checkmark, image: UIImage(named:"arstechnica-m")))
                break
            case .bbcNews:
                sources.append((name: "BBC News", type: .checkmark, image: UIImage(named:"bbcnews-m")))
                break
            case .bbcSport:
                sources.append((name: "BBC Sports", type: .checkmark, image: UIImage(named:"bbcsport-m")))
                break
            case .bloomBerg:
                sources.append((name: "Bloomberg", type: .checkmark, image: UIImage(named:"bloomberg-m")))
                break
            case .buzzfeed:
                sources.append((name: "Buzzfeed", type: .checkmark, image: UIImage(named:"buzzfeed-m")))
                break
            case .cnbc:
                sources.append((name: "CNBC", type: .checkmark, image: UIImage(named:"cnbc-m")))
                break
            case .cnn:
                sources.append((name: "CNN", type: .checkmark, image: UIImage(named:"cnn-m")))
                break
            case .engadget:
                sources.append((name: "Engadget", type: .checkmark, image: UIImage(named:"engadget-m")))
                break
            case .entertainmentWeekly:
                sources.append((name: "Entertainment Weekly", type: .checkmark, image: UIImage(named:"entertainmentweekly-m")))
               break
            case .espn:
                sources.append((name: "ESPN", type: .checkmark, image: UIImage(named:"espn-m")))
                    break
            case .googleNews:
                sources.append((name: "Goolge News", type: .checkmark, image: UIImage(named:"googlenews-m")))
                break
            case .hackerNews:
                sources.append((name: "Hacker News", type: .checkmark, image: UIImage(named:"hackernews-m")))
                break
            case .independent:
                sources.append((name: "Independent", type: .checkmark, image: UIImage(named:"independent-m")))
                break
            case .mashable:
                sources.append((name: "Mashable", type: .checkmark, image: UIImage(named:"mashable-m")))
                break
            case .recode:
                sources.append((name: "Recode", type: .checkmark, image: UIImage(named:"recode-m")))
                break
            case .reddit:
                sources.append((name: "Reddit/r/all", type: .checkmark, image: UIImage(named:"redditrall-m")))
                break
            case .reuters:
                sources.append((name: "Reuters", type: .checkmark, image: UIImage(named:"reuters-m")))
              break
            case .techCrunch:
                sources.append((name: "Techcrunch", type: .checkmark, image: UIImage(named:"techcrunch-m")))
                break
            case .theGuardian:
                sources.append((name: "The Guardian", type: .checkmark, image: UIImage(named:"theguardianuk-m")))
                break
            case .theHuffingtonPost:
                sources.append((name: "The Huffington Post", type: .checkmark, image: UIImage(named:"thehuffingtonpost-m")))
                break
            case .theNYT:
                sources.append((name: "The New York Times", type: .checkmark, image: UIImage(named:"thenewyorktimes-m")))
               break
            case .TNW:
                sources.append((name: "The Next Web", type: .checkmark, image: UIImage(named:"thenextweb-m")))
                break
            case .theVerge:
                sources.append((name: "The Verge", type: .checkmark, image: UIImage(named:"theverge-m")))
                break
            case .wsj:
                sources.append((name: "The Wall Street Journal", type: .checkmark, image: UIImage(named:"thewallstreetjournal-m")))
                break
//            case .washingtonPost:
//                sources.append((name: "The Washington Post", type: .button, image: UIImage(named:"thewashingtonpost-m")))
//                break
    
            }
        }
        
        return sources
    }
    
    
 
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//         self.wakeup == .wakeUpTypeNews{
//            return settings.count-2
//        }
        
        return settings.count
     
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch self.wakeupType {
        case .wakeUpTypeCal:
            requestCalendarAcces()
            break
        case .wakeUpTypeWeather:
            if (indexPath as NSIndexPath).row == 0 && !typeAdded{
                getCurrentLocation()
            }
            break
        case .wakeUpTypeTwitter:
            if (indexPath as NSIndexPath).row == 0 && !typeAdded{
              
            }
            break
        case .wakeUpTypePocket:
            if (indexPath as NSIndexPath).row == 0 && !typeAdded {
              
            }
            break
        case .wakeUpTypeTransit:
            if (indexPath as NSIndexPath).row == 0 && !typeAdded {
                pickHomeLocation()
            } else {
                pickWorkLocation()
            }
            break
        case .wakeUpTypeNews:
            if (indexPath as NSIndexPath).section == 0 {
                if !self.selectedIndexes.contains((indexPath as NSIndexPath).row) {
              
                
                    wuManager.addToQueue(.wakeUpTypeNews)
                    
                    self.selectedIndexes.append((indexPath as NSIndexPath).row)
                    self.postAddFlow(.wakeUpTypeNews)
                    saveNewsSource(newsTypes(rawValue: self.allNews[(indexPath as NSIndexPath).row].rawValue)!)
                } else {
                    let index = self.selectedIndexes.index(of: (indexPath as NSIndexPath).row)
                    self.selectedIndexes.remove(at: index!)
                    deleteNewsSource(newsTypes(rawValue: self.allNews[(indexPath as NSIndexPath).row].rawValue)!)
                    if self.selectedIndexes.count == 0 {
                        self.postRemoveFlow(.wakeUpTypeNews)
                    }
                    
                    self.reloadData()
                }
                
            }
            break
  
        }
    }
    
    
    func saveNewsSource(_ source: newsTypes){
        let newsSources = uDefaults.value(forKey: newsSourcesKey) as? [String]
        if var allNews = newsSources {
            allNews.append(source.rawValue)
            uDefaults.setValue(allNews, forKey: newsSourcesKey)
        } else {
            uDefaults.setValue([source.rawValue], forKey: newsSourcesKey)
        }
        
    }
    
    
    func deleteNewsSource(_ source: newsTypes){
        let newsSources = uDefaults.value(forKey: newsSourcesKey) as? [String]
        if var allNews = newsSources {
            let index = allNews.index(of: source.rawValue)
            if let i = index {
                allNews.remove(at: i)
                uDefaults.setValue(allNews, forKey: newsSourcesKey)
            }
        }
    }
    
    func postRemoveFlow(_ wake: wakeUpTypes){
        self.selectionDelegate?.buttonEnabled(false)
        self.typeAdded = false
        wuManager.addToRemoveQueue(.wakeUpTypeNews)
    }
    
    
    func pickHomeLocation(){
        self.selectionDelegate?.presentLocationPicker()
        self.locationType = .home
    }
    
    
    func pickWorkLocation(){
        self.selectionDelegate?.presentLocationPicker()
        self.locationType = .work
    }
    
    
    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace){
        print("Place name: ", place.name)
        print("Place address: ", place.formattedAddress ?? "Failed!")
        //print("Place attributions: ", place.attributions)
        
        
        switch locationType! {
            case  .work:
                self.workSelected = true
                uDefaults.setValue(place.name, forKey: toLocationNameKey)
                uDefaults.setValue(place.placeID, forKey: toLocationKey)
            break
            case .home:
                self.homeSelected = true
                uDefaults.setValue(place.placeID, forKey: fromLocationKey)
                uDefaults.setValue(place.name, forKey: fromLocationNameKey)
            break
        }
        
        self.settings = configsForType(.wakeUpTypeTransit)
        DispatchQueue.main.async(execute: {() in
            self.reloadData()
        })
        
        if homeSelected && workSelected {
            wuManager.addToQueue(.wakeUpTypeTransit)
            self.postAddFlow(.wakeUpTypeTransit)
        }
        
        
        viewController.dismiss(animated: true, completion: nil)
    }
    
    func viewController(viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: NSError) {
//         TODO: handle the error.
        print("Error: ", error.description)

        viewController.dismiss(animated: true, completion: nil)
    }
    
//     User canceled the operation.
    func wasCancelled(_ viewController: GMSAutocompleteViewController) {
         viewController.dismiss(animated: true, completion: nil)

    }
    
//     Turn the network activity indicator on and off again.
    func didRequestAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }
    
    func didUpdateAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }

    
 
    
    
    func numberChanged(_ sender: AnyObject){
        let tag = sender.tag
        let numberPicker = sender as! nuberAdjuster
        switch self.wakeupType {
        case .wakeUpTypeNews:
            if tag == 0 {
                self.uDefaults.set(numberPicker.count, forKey: numArticlesKey)
            } else if tag == 1 {
                self.uDefaults.set(numberPicker.count, forKey: numSentSumKey)
            }
        default:
            break
        }
    }
    
    
    

    
 


    func getCurrentLocation(){
        locationManager = TockLocationManager()
        locationManager.delegate = self
        locationManager.startLocating()

    }
    
    func requestCalendarAcces(){
            let tockEventsManager = TockEventsManager()
            tockEventsManager.delegate = self
            tockEventsManager.requestCalendarAccess()
    }
    
    
    func locationFound(_ location: Location, inCity: String?) {
        
        
        let locationString = String(format: "lat=%.7f&lon=%.7f", location.lat, location.long)
        print("location string found: \(locationString) with loc: \(location.lat)")
        let userdefaults = UserDefaults.standard
        userdefaults.set(locationString, forKey: locationKey)
        userdefaults.set(inCity, forKey: locationStringKey)
        
        
   
        
        if !typeAdded {
            wuManager.addToQueue(.wakeUpTypeWeather)
            self.currentLocation = inCity
            postAddFlow(.wakeUpTypeWeather)
        }
        
        locationManager.stopLocating()
    }
    
    func locationFailed(_ error: NSError) {
        print(error)
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if self.wakeupType == .wakeUpTypeNews  && (indexPath as NSIndexPath).section == 1{
            return 100
        } else {
         return 67
        }
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
//        if self.wakeupType == .wakeUpTypeNews {
//            return 2
//        }
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        if self.wakeupType == .wakeUpTypeNews {
//            return 25
//        }
//        
        return 0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let sectionLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.frame.size.width, height: 25))
        sectionLabel.textColor = UIColor(red: 1, green: 0.4393680155, blue: 0.001996452746, alpha: 1)
        sectionLabel.textAlignment = .center
        
        sectionLabel.font = UIFont(name: "AvenirNext-Regular", size: 15)
        
        if section == 0 && self.wakeupType == .wakeUpTypeNews{
            sectionLabel.text = "Options"
        } else {
            sectionLabel.text = "News Sources"
        }
        
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: self.frame.size.width, height: 25))
        headerView.backgroundColor = UIColor.clear
        headerView.addSubview(sectionLabel)
        headerView.layer.cornerRadius = 10
        headerView.backgroundColor = UIColor.white
       
            return headerView
        
    }
    
    func latlongFailed() {
        print("the lat and long could not be retreived at this time")
    }

    

    func calendarAccess(_ granted: Bool) {
        
        
        if granted && !typeAdded{
            print("access granted")
            wuManager.addToQueue(.wakeUpTypeCal)
            postAddFlow(.wakeUpTypeCal)
        } 
        
        
 
    }
    
    func postAddFlow(_ type: wakeUpTypes){
        self.selectionDelegate?.buttonEnabled(true)
        self.typeAdded = true
        self.settings = configsForType(type)
        DispatchQueue.main.async(execute: {() in
          self.reloadData()
        })
    }

    
    
   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "config") as! SettingsCell

        var setting = settings[(indexPath as NSIndexPath).row]
        if self.wakeupType == .wakeUpTypeNews {
          
            
            
            if self.selectedIndexes.contains((indexPath as NSIndexPath).row) && (indexPath as NSIndexPath).section == 0{
                cell.makeAViewVisible()
            } else {
                cell.makeAViewInvisible()
            }
            
            
            if (indexPath as NSIndexPath).section == 0 {
                setting = settings[(indexPath as NSIndexPath).row]
            } else {
                let optioncell = tableView.dequeueReusableCell(withIdentifier: "number") as! NumberAdjusterCell
                optioncell.row = (indexPath as NSIndexPath).row
                
                optioncell.setTitle(setting.name)
                return optioncell
            }
        }
        
        
        
        cell.leftOffsetvalue = -100
        cell.setType(setting.type, withName: setting.name, andImage: setting.image)
        cell.selectionStyle = .none
        return cell
    }
    
    
    
    
}
