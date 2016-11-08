//
//  TockTableView.swift
//  Tock
//
//  Created by Kevin Turner on 7/13/16.
//  Copyright © 2016 Kevin Turner. All rights reserved.
//

import UIKit


enum displayType: Int {
    case all
    case mine
}

class TockTableView: UITableView, UITableViewDelegate, UITableViewDataSource {
    fileprivate var wakeUps:[wakeUpTypes]!
    fileprivate var myWakeUps:[wakeUpTypes]?
    internal var selectionDelegate: TockTableViewSelectionDelegate?
    var type: displayType = .all
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.delegate = self
        self.dataSource = self
    }
    
    func setTockDataSourceTypes(_ types: [wakeUpTypes]){
  
        self.wakeUps = types
        self.reloadData()
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        if type == .all && self.myWakeUps != nil{
            return 2
        } else {
            return 1
        }
    }
    
//    func numberOfSections(in tableView: UITableView) -> Int {
//      
//    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 && type == .all{
            if let mine = self.myWakeUps {
                return mine.count
            } else {
                return self.wakeUps.count
            }
        } else {
            return self.wakeUps.count
        }
    }

    

//    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let sectionLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.frame.size.width, height: 25))
        sectionLabel.textColor = UIColor(red: 1, green: 0.4393680155, blue: 0.001996452746, alpha: 1)
        sectionLabel.textAlignment = .center
    
        sectionLabel.font = UIFont.systemFont(ofSize: 15)
        
        if section == 0 && self.myWakeUps != nil{
            sectionLabel.text = "My Services"
        } else {
            sectionLabel.text = "All Services"
        }
        
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: self.frame.size.width, height: 25))
        headerView.backgroundColor = UIColor.clear
        headerView.addSubview(sectionLabel)
        headerView.layer.cornerRadius = 10
        headerView.backgroundColor = UIColor.white
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 25
    }
    
    
    
    
    func setMyWakeUps(_ wakes: [wakeUpTypes]) {
        if wakes.count == 0 {
            self.myWakeUps = nil
        } else {
            self.myWakeUps = wakes
        }
        reloadData()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Selected: \((indexPath as NSIndexPath).row)")
        print("my wakeups \(self.myWakeUps)")
        var type:wakeUpTypes
        if (indexPath as NSIndexPath).section == 0 && self.myWakeUps != nil {
            type = myWakeUps![(indexPath as NSIndexPath).row]
        } else {
            type = wakeUps![(indexPath as NSIndexPath).row]
        }
        self.selectionDelegate?.typeSelected(type)
    }
    
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tock") as! TockTableViewCell
        if (indexPath as NSIndexPath).section == 0 && self.myWakeUps != nil {
            cell.setCellType(myWakeUps![(indexPath as NSIndexPath).row])
        } else {
            cell.setCellType(wakeUps[(indexPath as NSIndexPath).row])
        }
        cell.selectionStyle = .none
        return cell
    }

}
