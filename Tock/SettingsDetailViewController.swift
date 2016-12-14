//
//  SettingsDetailViewController.swift
//  Tock
//
//  Created by Kevin Turner on 12/2/16.
//  Copyright © 2016 Kevin Turner. All rights reserved.
//

import UIKit




struct soundType {
    let soundName : String
    let fileName : String
}

struct voiceType {
    let speedName : String
    let speedValue : Double
}

struct snoozeType {
    let snoozeName : String
    let snoozeValue : Int
}

class SettingsDetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, SwitchCellDelegate {

    @IBOutlet weak var settingsTypeLabel: UILabel!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    let uDefaults = UserDefaults.standard
    
    var type : settingsType!
    
    let sounds = [soundType(soundName: "Buzzer", fileName: "alarm"), soundType(soundName: "Siren", fileName: "siren"), soundType(soundName: "Fog Horn",fileName: "fogHorn")]
    let soundHeaders = ["Alarm Sounds"]
    
    let voiceSpeeds = [voiceType(speedName: "Slow", speedValue: 0.3), voiceType(speedName: "Medium", speedValue: 0.5), voiceType(speedName: "Fast", speedValue: 0.8)]
    let greetingOptions = ["Play Greeting Automatically"]
    let voiceHeaders = ["Choose Speech Speed", "Greeting"]
    var greetingBool = true
    
    let snoozeTimes = [snoozeType(snoozeName: "5 minutes", snoozeValue: 5), snoozeType(snoozeName: "10 minutes", snoozeValue: 10), snoozeType(snoozeName: "15 minutes", snoozeValue: 15)]
    let snoozeHeaders = ["Choose Snooze Time Amount"]
    
    
    
    var selectedIndex = 0
    var headers : [String] = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let gradient = CAGradientLayer()
        gradient.frame = view.frame
        gradient.colors = [UIColor(red: 1, green: 0.4393680155, blue: 0.001996452746, alpha: 1).cgColor, UIColor(red: 1, green: 0.7662689211, blue: 0.3382564307, alpha: 1).cgColor]
        
        self.view.layer.insertSublayer(gradient, below: self.tableView.layer)
        
        switch type! {
        case .sound:
            headers = soundHeaders
            self.settingsTypeLabel.text = "Sound"
            let fileName = uDefaults.value(forKey: alarmSoundKey) as? String
            if fileName != nil {
                var i = 0
                for sound in sounds {
                    if sound.fileName == fileName {
                        self.selectedIndex = i
                        break
                    }
                    i += 1
                }
                
            } else {
                uDefaults.set(sounds[0].fileName, forKey: alarmSoundKey)
            }
            break
        case .voice:
            headers = voiceHeaders
            settingsTypeLabel.text = "Voice"
            let defaultSpeed = uDefaults.value(forKey: speechSpeedKey) as? Double
            if defaultSpeed != nil {
                var i = 0;
                for speed in voiceSpeeds {
                    if speed.speedValue == defaultSpeed! {
                        self.selectedIndex = i
                        break
                    }
                    
                    i += 1
                }
                let greetingPlay = uDefaults.value(forKey: autoGreetignKey) as? Bool
                if greetingPlay != nil {
                    self.greetingBool = greetingPlay!
                } else {
                    uDefaults.setValue(true, forKey: autoGreetignKey)
                }
                
            } else {
                uDefaults.set(0.5, forKey: speechSpeedKey)
            }
            break
        case .snooze:
            headers = snoozeHeaders
            settingsTypeLabel.text = "Snooze"
            let defaultSnooze = uDefaults.value(forKey: snoozeTimeKey) as? Int
            if defaultSnooze != nil {
                var i = 0;
                for time in snoozeTimes {
                    if time.snoozeValue == defaultSnooze {
                        self.selectedIndex = i
                        break
                    }
                    
                    i += 1
                }
            }
            break

        }
        
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        // Do any additional setup after loading the view.
  
     }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            switch type! {
            case .sound:
                return sounds.count
            case .voice:
                return voiceSpeeds.count
            case .snooze:
                return snoozeTimes.count
            }
        } else {
            switch type! {
            case .voice:
                return greetingOptions.count
            default:
                return 0
            }
        }
        
    }
    
    @IBAction func swipedRight(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return headers.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        //        if wakeUps.count == 0 {
        //            return nil
        //        }
        
        let sectionLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 25))
        sectionLabel.textColor = UIColor(red: 1, green: 0.4393680155, blue: 0.001996452746, alpha: 1)
        sectionLabel.textAlignment = .center
        
        sectionLabel.font = UIFont(name: "AvenirNext-Regular", size: 15)
        
        sectionLabel.text = headers[section]
        
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 25))
        headerView.backgroundColor = UIColor.clear
        headerView.addSubview(sectionLabel)
        headerView.layer.cornerRadius = 10
        headerView.backgroundColor = UIColor.white
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 25
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0{
        let cell = tableView.dequeueReusableCell(withIdentifier: "config") as! DetailSettingsTableViewCell
        if indexPath.row == self.selectedIndex {
            cell.check(enabled: true)
        } else {
            cell.check(enabled: false)
        }
        switch type! {
        case .sound:
            let soundSetting = sounds[indexPath.row]
            cell.setLabel(with: soundSetting.soundName)
       
            break
        case .voice:
            let voiceSetting = voiceSpeeds[indexPath.row]
            cell.setLabel(with: voiceSetting.speedName)
         
            break
        case .snooze:
            let snoozeSetting = snoozeTimes[indexPath.row]
            cell.setLabel(with: snoozeSetting.snoozeName)
            break
        }
            
        return cell
        } else {
            switch type!{
            case .voice:
                let greetingOption = tableView.dequeueReusableCell(withIdentifier: "switch") as! SwitchTableViewCell
                greetingOption.delegate = self
                greetingOption.setName(name: self.greetingOptions[indexPath.row], andTag: indexPath.row, isOn: self.greetingBool)
                return greetingOption
               
            default:
                return UITableViewCell()
            
            }
        }
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            self.selectedIndex = indexPath.row
            self.tableView.reloadData()
            switch self.type! {
            case .sound:
                uDefaults.set(sounds[indexPath.row].fileName, forKey: alarmSoundKey)
                break
            case .voice:
                uDefaults.set(voiceSpeeds[indexPath.row].speedValue, forKey: speechSpeedKey)
                break
            case .snooze:
                uDefaults.set(snoozeTimes[indexPath.row].snoozeValue, forKey: snoozeTimeKey)
                break
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func switchChanged(tag: Int, on: Bool) {
        switch self.type! {
        case .voice:
            uDefaults.setValue(on, forKey: autoGreetignKey)
            break
        default:
            break
        }
    }
    
    @IBAction func backButtonPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
