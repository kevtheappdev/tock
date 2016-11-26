//
//  TockAlarmViewController.swift
//  Tock
//
//  Created by Kevin Turner on 7/9/16.
//  Copyright © 2016 Kevin Turner. All rights reserved.
//

import UIKit
import AVFoundation

class TockAlarmViewController: UIViewController, TockWakeUpDelegate, AVAudioPlayerDelegate {
    
    @IBOutlet weak var infoStackView: UIStackView!
    let wuManager = WakeUpManager()
    var wakeUps:[wakeUpTypes: TockWakeUp]?
    let userDefaults = UserDefaults.standard
    var wakeUpDate: Date!
    var fetchedTotal = 0
      var player: AVAudioPlayer?
    

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        infoStackView.alpha = 0.0
        UIDevice.current.isProximityMonitoringEnabled = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        fadeInInstructions()
        self.wakeUps = wuManager.getWakeUps()
      
        setAlarm()
    }
    
    
    func setAlarm(){
       let date = KTUtility.getDate()
        self.wakeUpDate = date
       print("the date to wake up at is \(date)")
       //let fetchDate = KTUtility.makeFetchDate(date)
       // print("date is \(date) and fetch date \(fetchDate)")
     
        let fetchDate = KTUtility.makeFetchDate(date)
        
        
        
        let currentDate = Date()
        let unixDate = currentDate.timeIntervalSince1970
        let unixWakeDate = date.timeIntervalSince1970
        
        let interval = unixWakeDate - unixDate
        
        print("The interval to wakeup is \(interval)")
        playWakeUpNoise()

       Timer.scheduledTimer(timeInterval: interval, target: self, selector: #selector(TockAlarmViewController.fetchData), userInfo: nil, repeats: false)
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
            wakeUp()
        }
    }
    
    
    @objc func wakeUp(){
        player?.play()
        player?.delegate = self
    }
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        self.performSegue(withIdentifier: "beep", sender: self)
    }
    
    func playWakeUpNoise(){
        
        let url = Bundle.main.url(forResource: "alarm", withExtension: "wav")!
      
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
       self.dismiss(animated: true, completion: nil)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print("before segue there are: \(wakeUps?.count)")
        let destinationVC = segue.destination as! TockBeepViewController
        destinationVC.wakeUps = self.wakeUps
    }
}
