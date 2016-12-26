//
//  TockAlarmViewController.swift
//  Tock
//
//  Created by Kevin Turner on 7/9/16.
//  Copyright © 2016 Kevin Turner. All rights reserved.
//

import UIKit
import AVFoundation

class TockAlarmViewController: GAITrackedViewController, TockWakeUpDelegate, AVAudioPlayerDelegate {
    
    @IBOutlet weak var infoStackView: UIStackView!
    let wuManager = WakeUpManager()
    var wakeUps:[wakeUpTypes: TockWakeUp]?
    let userDefaults = UserDefaults.standard
    var wakeUpDate: Date!
    var fetchedTotal = 0
      var player: AVAudioPlayer?
    var dataRetreived = false
    var timer: Timer!
    let pop = PopTransitionDelegate()
    weak var wakeVC : TockWakeViewController?
  
    @IBOutlet weak var bedsideModeButton: UIButton!
    @IBOutlet weak var doneButton: UIButton!


    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.screenName = "alarm"
        infoStackView.alpha = 0.0
        UIDevice.current.isProximityMonitoringEnabled = true
        UIApplication.shared.isIdleTimerDisabled = true
        try? AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback)
       
        
             setupGradients() 
        
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        fadeInInstructions()
        self.wakeUps = wuManager.getWakeUps()
        KTUtility.recordStartTime()
        KTUtility.scheduleNotification()
        setAlarm()
     
    }
    
    

    
    func setupGradients(){
        let gradient = CAGradientLayer()
        gradient.frame = CGRect(x: 0, y: 0, width: doneButton.bounds.width, height: bedsideModeButton.bounds.height)
        gradient.colors = [UIColor(red: 1, green: 0.4393680155, blue: 0.001996452746, alpha: 1).cgColor, UIColor(red: 1, green: 0.7662689211, blue: 0.3382564307, alpha: 1).cgColor]
        let newGradient = CAGradientLayer()
        newGradient.frame = CGRect(x: 0, y: 0, width: doneButton.bounds.width, height: bedsideModeButton.bounds.height)
        newGradient.colors = [UIColor(red: 1, green: 0.4393680155, blue: 0.001996452746, alpha: 1).cgColor, UIColor(red: 1, green: 0.7662689211, blue: 0.3382564307, alpha: 1).cgColor]
        bedsideModeButton.layer.addSublayer(gradient)
        bedsideModeButton.layer.masksToBounds = true
        doneButton.layer.addSublayer(newGradient)
        doneButton.layer.masksToBounds = true
    }
    
    

 
    
    func setAlarm(){
       let date = KTUtility.getDate()
        self.wakeUpDate = date
       print("the date to wake up at is \(date)")
       let fetchDate = KTUtility.makeFetchDate(date)
        print("date is \(date) and fetch date \(fetchDate)")
      
        let unixFetchDate = fetchDate.timeIntervalSince1970
        
        
        
        
        let currentDate = Date()
        let unixDate = currentDate.timeIntervalSince1970
        let unixWakeDate = date.timeIntervalSince1970
        
        let interval = unixWakeDate - unixDate
        let fetchInterval = unixFetchDate - unixDate
        
        if fetchInterval > 0 {
            Timer.scheduledTimer(timeInterval: fetchInterval, target: self, selector: #selector(TockAlarmViewController.fetchData), userInfo: nil, repeats: false)
        } else {
             fetchData()
        }
       
        timer = Timer.scheduledTimer(timeInterval: interval, target: self, selector: #selector(TockAlarmViewController.wakeUp), userInfo: nil, repeats: false)
        
        
        //print("fetch interval is \(fetchInterval)")
        print("The interval to wakeup is \(interval)")
       

    
    }
    
    
    @objc func fetchData(){
        if let wakeUps = self.wakeUps {
            for (_, wakeUp) in wakeUps {
                    wakeUp.delegate = self
                    wakeUp.fetchData()
            }
            
        }
    }
    
    
    func finishedDataFetch() {
        fetchedTotal += 1
        if fetchedTotal == self.wakeUps?.count {
            self.dataRetreived = true
            self.wakeVC?.setDataFetched(fetched: true)
        }
    }
    
    

    
    
    @objc func wakeUp(){
        presentChildVC()
        playWakeUpNoise()
        if let player = self.player {
            if !player.isPlaying {
                player.play()
                player.delegate = self
            }
        }
    }
    
    func presentChildVC(){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let childVC = storyboard.instantiateViewController(withIdentifier: "WakeUpVC") as! TockWakeViewController
        self.wakeVC = childVC
        childVC.shouldDisplayPlay = self.dataRetreived
        self.addChildViewController(childVC)
        childVC.didMove(toParentViewController: self)
        childVC.view.frame = self.view.frame
        self.view.addSubview(childVC.view)
        self.view.bringSubview(toFront: childVC.view)
    }
    
    

    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        let shouldPlayAuto = userDefaults.bool(forKey: autoGreetignKey)
        if self.dataRetreived && shouldPlayAuto {
            self.performSegue(withIdentifier: "beep", sender: self)
        } else {
            player.play()
        }
      
    }
    
    
    @IBAction func startBedsideMode(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let bedsideVC = storyboard.instantiateViewController(withIdentifier: "bedside")
        self.addChildViewController(bedsideVC)
        bedsideVC.didMove(toParentViewController: bedsideVC)
        bedsideVC.view.frame = self.view.frame
        self.view.addSubview(bedsideVC.view)
        self.view.bringSubview(toFront: bedsideVC.view)
    }
    
    func startReading(){
        print("start reading")
        self.player!.stop()
        self.performSegue(withIdentifier: "beep",  sender: self)
    }
    
    func snoozeNow(){
        self.player?.stop()
        self.player?.currentTime = 0
        let snoozeInterval = userDefaults.integer(forKey: snoozeTimeKey)
        var interval = 5.0 * 60
        if snoozeInterval != 0 {
             interval = Double(snoozeInterval * 60)
        } else {
            userDefaults.set(5.0, forKey: snoozeTimeKey)
        }
        
        timer = Timer.scheduledTimer(timeInterval: interval, target: self, selector: #selector(TockAlarmViewController.wakeUp), userInfo: nil, repeats: false)
    }
    
    
    
    func playWakeUpNoise(){
        var alarmToPlay = userDefaults.string(forKey: alarmSoundKey)
        if alarmToPlay == nil {
            alarmToPlay = "alarm"
            userDefaults.set(alarmToPlay, forKey: alarmSoundKey)
        }
        print("The alarm to be played is \(alarmToPlay)")
        let url = Bundle.main.url(forResource: alarmToPlay, withExtension: "wav")!
      
        do {
            player = try AVAudioPlayer(contentsOf: url)
            guard let player = player else { return }
            
            player.prepareToPlay()
           
        } catch let error {
            print("had a problem playing")
            print(error.localizedDescription)
        }
    }
    
    
    
    
    
    func fadeInInstructions(){
        UIView.animate(withDuration: 1.0, animations: {() in
           self.infoStackView.alpha = 1.0
        })
    }

    @IBAction func dissmiss(_ sender: AnyObject) {
        UIDevice.current.isProximityMonitoringEnabled = false
        self.timer.invalidate()
       self.dismiss(animated: true, completion: nil)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print("before segue there are: \(wakeUps?.count)")
        let destinationVC = segue.destination as! TockBeepViewController
        destinationVC.transitioningDelegate = self.pop
        destinationVC.wakeUps = self.wakeUps
    }
}
