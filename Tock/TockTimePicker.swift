//
//  TockTimePicker.swift
//  Tock
//
//  Created by Kevin Turner on 6/17/16.
//  Copyright © 2016 Kevin Turner. All rights reserved.
//

import UIKit

class TockTimePicker: UIControl {
    let hourCircle = CAShapeLayer()
    let selectButton = CAShapeLayer()
    let centerCircle = CALayer()
    var previousLocation = CGPoint()
    var rotateLayer: CALayer!
    var circRadius = 0.0
    var lastAngle = -1.0
    var time = 390.0
    let dayMinutes = 60.0*24.0
    var buttonTapped = false
    var delegate: TimePickerDelegate?
    let rLayer = CALayer()
    let threeoclock = CATextLayer()
    let twelveoclock = CATextLayer()
    let sixoclock = CATextLayer()
    let nineoclock = CATextLayer()
    let timeLabel = CATextLayer()
    let gradient = CAGradientLayer()
    let selectKnob = CALayer()
    var currentAngle: CGFloat!
    var isPM = false
    var hasToggled = false
    var hours: Int = 0
    var minutes: Int = 0


    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        print("init")
        currentAngle = 0
        print(frame)
    }
    
    
    override func layoutSublayers(of layer: CALayer) {


        print("layout subviews")
        print(frame.height)
        print(bounds.height)
        let radius = (frame.width-125)/2
        
        let innerRadius = radius - 28
        
        
        
        
        
        gradient.frame = bounds
        gradient.colors = [UIColor(red: 1, green: 0.4393680155, blue: 0.001996452746, alpha: 1).cgColor, UIColor(red: 1, green: 0.7662689211, blue: 0.3382564307, alpha: 1).cgColor]
        
        
        
        hourCircle.bounds = CGRect(x: 0, y: 0, width: bounds.width, height: bounds.width)
        
        
        
        let outerPath = UIBezierPath(roundedRect: CGRect(x: bounds.midX - radius, y: bounds.midY - radius, width: radius * 2, height: radius * 2), cornerRadius: radius)
        
        
        
        
        
        
        hourCircle.path = outerPath.cgPath
        
        hourCircle.position = CGPoint(x:  bounds.size.width/2, y:  bounds.size.height/2)
        
        hourCircle.strokeColor = UIColor.blue.cgColor
        hourCircle.fillRule = kCAFillRuleEvenOdd
        
        gradient.mask = hourCircle
        
        layer.addSublayer(gradient)
        
        
        
        centerCircle.bounds = CGRect(x: 0, y: 0, width: innerRadius * 2, height: innerRadius * 2)
        centerCircle.position = CGPoint(x: bounds.size.width/2, y: bounds.size.height/2)
        centerCircle.cornerRadius = innerRadius
        centerCircle.backgroundColor = UIColor.black.cgColor
        
        layer.addSublayer(centerCircle)
        
        
        circRadius = Double(radius)
        print("circRadius:\(radius)")
        
        
        
        rLayer.bounds = bounds
        rLayer.position = CGPoint(x: bounds.size.width/2, y: bounds.size.height/2)
        rLayer.backgroundColor = UIColor.clear.cgColor
        
        
        
        rotateLayer = rLayer
        
        
        
        selectKnob.bounds = CGRect(x: 0, y: 0, width: 50, height: 50)
        selectKnob.cornerRadius = 25
        let selectPosition = Trig.findPoint(forAngle: 0.0, radius: Double(radius-15))
        let newX = selectPosition.x + bounds.midX
        let newY = selectPosition.y + bounds.midY
        var position = CGPoint(x: newX, y: newY)
        selectKnob.position = position
        selectKnob.backgroundColor = UIColor.white.cgColor
        
        
        rLayer.addSublayer(selectKnob)
        layer.addSublayer(rLayer)
        
        
        
        
        
        //Setup text elements
        
        twelveoclock.bounds = CGRect(x: 0, y: 0, width: 50, height: 50)
        twelveoclock.string = "12"
        
        let twelvePos =  Trig.findPoint(forAngle: (90*M_PI/180), radius: Double(radius+30))
        let tX = twelvePos.x + bounds.midX
        let tY = twelvePos.y + bounds.midY
        position = CGPoint(x: tX, y: tY)
        twelveoclock.position = position
        //twelveoclock.backgroundColor =  UIColor.red().cgColor
        twelveoclock.alignmentMode = kCAAlignmentCenter
        twelveoclock.font = UIFont(name: "AvenirNext-Regular", size: 15)
        twelveoclock.contentsScale = UIScreen.main.scale
        layer.addSublayer(twelveoclock)
        
        
        threeoclock.bounds = CGRect(x: 0, y: 0, width: 50, height: 50)
        threeoclock.string = "3"
        threeoclock.font = UIFont(name: "AvenirNext-Regular", size: 15)
        //threeoclock.backgroundColor = UIColor.red().cgColor
        
        threeoclock.alignmentMode = kCAAlignmentCenter
        
        let threePos = Trig.findPoint(forAngle: 0, radius: Double(radius+30))
        let thX = threePos.x + bounds.midX
        let thY = threePos.y + bounds.midY
        position = CGPoint(x: thX, y: thY)
        
        threeoclock.position = position
        threeoclock.contentsScale = UIScreen.main.scale
        
        layer.addSublayer(threeoclock)
        
        
        sixoclock.bounds = CGRect(x: 0, y: 0, width: 50, height: 50)
        sixoclock.string = "6"
        sixoclock.font = UIFont(name: "AvenirNext-Regular", size: 15)
        //sixoclock.backgroundColor = UIColor.red().cgColor
        sixoclock.alignmentMode = kCAAlignmentCenter
        sixoclock.contentsScale = UIScreen.main.scale
        
        let sixPos = Trig.findPoint(forAngle: (270*M_PI/180), radius: Double(radius+30))
        let sX = sixPos.x + bounds.midX
        let sY = sixPos.y + bounds.midY
        position = CGPoint(x: sX, y: sY)
        
        sixoclock.position = position
        layer.addSublayer(sixoclock)
        
        
        nineoclock.bounds = CGRect(x: 0, y: 0, width: 50, height: 50)
        nineoclock.string = "9"
        nineoclock.font = UIFont(name: "AvenirNext-Regular", size: 15)
        //nineoclock.backgroundColor = UIColor.red().cgColor
        nineoclock.alignmentMode = kCAAlignmentCenter
        
        let ninePos = Trig.findPoint(forAngle: M_PI, radius: Double(radius+30))
        let nX = ninePos.x + bounds.midX
        let nY = ninePos.y + bounds.midY
        position = CGPoint(x: nX, y: nY)
        
        nineoclock.position = position
        nineoclock.contentsScale = UIScreen.main.scale
        layer.addSublayer(nineoclock)
        
        
       
        timeLabel.alignmentMode = kCAAlignmentCenter
        timeLabel.font = UIFont(name: "AvenirNext-Regular", size: 15)
        timeLabel.bounds = CGRect(x: 0, y: 0, width: 175, height: 50)
       
        
         let screenWidth = UIScreen.main.bounds.width
        print("The width is \(screenWidth)")
        if screenWidth < 375 {
             timeLabel.fontSize = 30
            
        }
        
          timeLabel.position = CGPoint(x: bounds.midX, y: bounds.midY)
        timeLabel.contentsScale = UIScreen.main.scale
        layer.addSublayer(timeLabel)

    }
    
    
    
    
    
    
    override func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        print("tracking begins")
        previousLocation = touch.location(in: self)
        print(time)
        
        
        let center = CGPoint(x: bounds.midX, y: bounds.midY)
        
        
        let distance = Double(previousLocation.x)-Double(center.x)
        
        let height = Double(previousLocation.y)-Double(center.y)
        
        
        let radius = Trig.findRadius(distance, y: height)
        
        
        
        
        
        
        if(radius <= circRadius+30 && radius >= circRadius-30){
            return true
        }
        
        
        return false

    }
    
    override func continueTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        if(!buttonTapped){
            
            let location = touch.location(in: self)
            print("tracking continues: \(location)")
            
            
            
            
            let center = CGPoint(x: bounds.midX, y: bounds.midY)
            
            
            let x = Double(location.x)-Double(center.x)
            let y = Double(location.y)-Double(center.y)
            
            var angle = Trig.findAngle(x, y: y)
            
            
            
            if angle < 0 {
                angle += 2 * M_PI
            }
            
            print("angle returned from Trig: \(angle)")
            
            var calcAngle = angle + (M_PI/2)
            
            if calcAngle > (2*M_PI) {
                calcAngle = calcAngle - (2*M_PI)
            }
            
            
            
            
            
            time = ((calcAngle / (M_PI * 2) * 144) * 5)
            
            
            
            
            
            
            let hours = Int(time/60)
            let minutes = Int(time.truncatingRemainder(dividingBy: 60))
            print("hours is \(hours) and minutes is: \(minutes)")
            
            
            
            
            
            if hours == 0 && hasToggled == false {
                print("passed 12")
                hasToggled = true
                togglePM()
            } else if hours != 0 {
                hasToggled = false
            }
            
     
            
            
            
            if isPM {
                print("it is pm")
                time = time + 720
            }
            
            
          rotateKnob(toAngle: angle)
            
            if Double(minutes).truncatingRemainder(dividingBy: 5) == 0 {
                self.sendActions(for: .valueChanged)
                
                lastAngle = angle
                self.hours = hours
                self.minutes = minutes
                
            }
            
            print(time)
            
            
        } else {
            return false
        }
        
        return true

    }
    
    
  
    
    
    func rotateKnob(toAngle angle: Double){
        //self.sendActions(for: .valueChanged)
        CATransaction.begin()
        //CATransaction.setDisableActions(true)
        CATransaction.setAnimationDuration(0.01)
        rotateLayer.transform = CATransform3DRotate(CATransform3DIdentity, CGFloat(angle), 0, 0, 1)
        CATransaction.commit()
    }
    
    func togglePM(){
        isPM = isPM ? false : true
        print("the value of isPM is: \(isPM)")
    }
    

    
    func doneButton(){
        print("done button called")
        if let delegate = self.delegate {
            delegate.buttonTapped()
        }
    }
    
    
    override func sendActions(for controlEvents: UIControlEvents) {
        print("sending actions...")
        super.sendActions(for: .valueChanged)
        
        let totalMinutes = time
        var timePostFix = "AM"
        var hours = Int(totalMinutes)/60
        print("current hours is \(hours)")
        if(hours >= 12){
            timePostFix = "PM"
            print("greater than 12 \(hours)")
            hours = hours - 12
            print("no greater than 12 \(hours)")
        }
        
        
        if(hours == 0){
            hours = 12
        }
        
        
        
        
        print("hours: \(hours) totalMinutes: \(totalMinutes)")
        let minutes = Int(totalMinutes.truncatingRemainder(dividingBy: 60))
        print("minutes: \(minutes)")
        
        
        var timeText = "\(hours):\(minutes)"
        if(minutes < 10){
            timeText = "\(hours):0\(minutes)"
        }
        
        
        print("time text in sendActions: \(timeText)")
        
        self.timeLabel.string = timeText + " " + timePostFix
        

    }
  
    
    
    
    func setTime(){
        
        let calendar = Calendar(identifier: Calendar.Identifier.gregorian)
        
        
        let userDefaults = UserDefaults.standard
        let wakeUpDate = userDefaults.object( forKey: "wake_up_time") as? Date
        
        
        if let wakeup = wakeUpDate {
            
            let currentComponents = (calendar as NSCalendar).components([.hour, .minute], from: wakeup)
            
            var hour = currentComponents.hour
            let minutes = currentComponents.minute
            
            
            var postFix = "AM"
            
            let totalMin = (hour!*60) + minutes!
            time = Double(totalMin)
            print("time for angle func : \(time)")
            if hour! > 12 {
                hour = hour! - 12
                postFix = "PM"
                self.isPM = true
            }
            
          
            
            var angle = angleForValue(time)

            print("calculated angle is: \(angle)")
            angle = ((M_PI * 2) - angle) + M_PI
            
            if lastAngle != -1.0 {
                angle = -lastAngle
            }
            rotateKnob(toAngle: -angle)
            
//            let defaults = UserDefaults.standard()
//            let angle = defaults.object(forKey: "last_angle") as? Double
//            if let uAngle = angle {
//                rotateKnob(toAngle: uAngle)
//            } else {
//                rotateKnob(toAngle: 0)
//            }
            var minuteString = String(describing: minutes!)
            if minutes == 0 {
                minuteString += "0"
            } else if minutes!/10 < 1 {
                minuteString = "0" + minuteString
            }
            
            if hours == 0 {
                hours = 12
            }
            let str = String(describing: hour!) + ":" + minuteString + " " + postFix
            print("str: \(str)")
            self.timeLabel.string = str
        } else {
            KTUtility.setDate(6, minutes: 30)
            setTime()
        }
        
    }
    
    
    func angleForValue(_ value: Double) -> Double{
       let ratio =  (value + (3*60)) / (144*5)
        print("calculated ratio is: \(ratio)")
       return (ratio * M_PI * 2)
    }
    
    
    override func endTracking(_ touch: UITouch?, with event: UIEvent?) {
        print("touches ended")
        var hours = self.hours
        if isPM {
            hours = hours + 12
        }
        KTUtility.setDate(hours, minutes: self.minutes)
        print("endTracking:")
        print("hours: \(self.hours) minutes: \(self.minutes)")
        
        KTUtility.scheduleNotification()

    }
    
   
 

}
