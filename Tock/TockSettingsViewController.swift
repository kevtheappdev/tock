//
//  TockSettingsViewController.swift
//  Tock
//
//  Created by Kevin Turner on 12/2/16.
//  Copyright © 2016 Kevin Turner. All rights reserved.
//

import UIKit
import MessageUI

struct settingsObject {
    let title : String
    let icon : UIImage
}

enum settingsType {
    case sound
    case voice
    case snooze
}

class TockSettingsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIViewControllerTransitioningDelegate, MFMailComposeViewControllerDelegate {
    @IBOutlet weak var tableView: UITableView!
    
    let settings = [settingsObject(title: "Sound", icon: #imageLiteral(resourceName: "volume-medium.png")), settingsObject(title: "Speech", icon: #imageLiteral(resourceName: "mic")), settingsObject(title: "Snooze", icon: #imageLiteral(resourceName: "sleepy"))]
    let help = ["Contact"]
    let about = ["Designed and developed by Kevin Turner", "@kevinturner62", "Icon Design by Daniel Davis", "@ionicgeneration"]
    let types : [settingsType] = [.sound, .voice, .snooze]
    var selectedType : settingsType?
    var selectedIndex : Int?
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        // Do any additional setup after loading the view.
        
        
        let gradient = CAGradientLayer()
        gradient.frame = view.frame
        gradient.colors = [UIColor(red: 1, green: 0.4393680155, blue: 0.001996452746, alpha: 1).cgColor, UIColor(red: 1, green: 0.7662689211, blue: 0.3382564307, alpha: 1).cgColor]
        
        self.view.layer.insertSublayer(gradient, below: self.tableView.layer)
    }
    
    
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return settings.count
        } else if section == 2{
            return about.count
        } else {
            return help.count
        }
    }
    
   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "config") as! SettingsTableViewCell
            let setting = settings[indexPath.row]
            cell.cellWithSetting(setting: setting)
            cell.selectionStyle = .none
            return cell
            
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "about") as! AboutTableViewCell
            if indexPath.section == 1 {
                cell.aboutlabel.text = help[indexPath.row]
            } else {
                cell.aboutlabel.text = about[indexPath.row]
            }
            return cell
        }
    
    }
    
    @IBAction func swipedRight(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        //        if wakeUps.count == 0 {
        //            return nil
        //        }
        
        let sectionLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 25))
        sectionLabel.textColor = UIColor(red: 1, green: 0.4393680155, blue: 0.001996452746, alpha: 1)
        sectionLabel.textAlignment = .center
        
        sectionLabel.font = UIFont(name: "AvenirNext-Regular", size: 15)
     
        if section == 0 {
            sectionLabel.text = "General"
        } else if section == 2{
            sectionLabel.text = "About"
        } else {
            sectionLabel.text = "Help"
        }
        
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
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            self.selectedIndex = indexPath.row
            DispatchQueue.main.async(execute: {() in
                self.performSegue(withIdentifier: "settingsDetail", sender: self)
            })
            
        } else if indexPath.section == 1 {
            if MFMailComposeViewController.canSendMail() {
                let mailComposer = MFMailComposeViewController()
                mailComposer.setToRecipients(["kevin.turnerapps@gmail.com"] )
                mailComposer.mailComposeDelegate = self
                self.present(mailComposer, animated: true, completion: nil)
            } else {
                let alert = UIAlertController(title: "Mail not availible", message: "Unable to bring up Mail View for contact", preferredStyle: .alert)
                self.present(alert, animated: true, completion: nil)
            }
        } else if indexPath.section == 2 && indexPath.row == 1 {
            let twitterURl = URL(string: "twitter://user?screen_name=kevinturner62")!
    
                UIApplication.shared.open(twitterURl, options: [:], completionHandler: nil)
         
        } else if indexPath.section == 2 &&  indexPath.row == 3 {
            let twitterURl = URL(string: "twitter://user?screen_name=IonicGeneration")!
            
            UIApplication.shared.open(twitterURl, options: [:], completionHandler: nil)
            
        }
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func backButtonPressed(_ sender: Any) {
         self.dismiss(animated: true, completion: nil)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "settingsDetail" {
            let destination = segue.destination as! SettingsDetailViewController
           // destination.setType(type:types[self.selectedIndex!])
            destination.type = types[selectedIndex!]
            destination.transitioningDelegate = self
        }
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return ConfigureTransition()
    }

    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return UnwindConfigureTransition()
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
