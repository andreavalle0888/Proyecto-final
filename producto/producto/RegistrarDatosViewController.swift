//
//  RegistrarDatosViewController.swift
//  producto
//
//  Created by macbook on 23/11/18.
//  Copyright © 2018 potato. All rights reserved.
//

import UIKit
import UserNotifications

class RegistrarDatosViewController: UIViewController {
    
    var dateRegist: daySelected!
    var dateCollectionR = [daySelected]()
    var monthStr = [String]()
    var daysPerMonth = [Int]()
    var monthEvent: Int!
    var daysToEvent: Int!
    var dayEvent: Int!
    var isEvent: Bool = false
    
    @IBOutlet weak var mesRegisting: UILabel!
    @IBOutlet weak var diaRegisting: UILabel!
    @IBOutlet weak var descriptionRegisting: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mesRegisting.text = dateRegist.month
        
        diaRegisting.text = dateRegist.day
        
        if isEvent == true {
            let content = UNMutableNotificationContent()
            content.title = "Tienes un evento el día de hoy"
            content.body = "ES HOY!!!"
            content.sound = UNNotificationSound.default
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: Double(daysToEvent * 86400), repeats: false)
            let request = UNNotificationRequest(identifier: "evento", content: content, trigger: trigger)
            UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
            
            let content1 = UNMutableNotificationContent()
            content1.title = "Tienes un evento"
            content1.body = "Programado para el día: \(dayEvent)"
            content1.sound = UNNotificationSound.default
            let trigger1 = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)
            let request1 = UNNotificationRequest(identifier: "ahora", content: content1, trigger: trigger1)
            UNUserNotificationCenter.current().add(request1, withCompletionHandler: nil)
            
            print("hola")
            
            isEvent = false
        }
    }
    
    @IBAction func saveEvent(_ sender: UIButton) {
        let registD = UserDefaults.standard
        
        dateRegist.description = descriptionRegisting.text!
        
        if let listEvents = registD.value(forKey: "dateEvents") as? Data{
            let temp = try? PropertyListDecoder().decode(Array<daySelected>.self, from: listEvents)
            
            dateCollectionR = temp!
        }
        
        dateCollectionR.append(dateRegist)
        
        registD.set(try? PropertyListEncoder().encode(dateCollectionR), forKey: "dateEvents")
        
        print(dateCollectionR)
        
        dateNotify()
        
        performSegue(withIdentifier: "toCalendar", sender: nil)
    }
    
    func dateNotify() {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .full
        dateFormatter.timeStyle = .none
        dateFormatter.locale = Locale(identifier: "es_MX")
        
        dateFormatter.dateFormat = "yyyy"
        let yearCurrent = Int(dateFormatter.string(from: date))!
        print(yearCurrent)
        
        dateFormatter.dateFormat = "MM"
        var monthCurrent = Int(dateFormatter.string(from: date))!
        print(monthCurrent)
        
        dateFormatter.dateFormat = "dd"
        let dayCurrent = Int(dateFormatter.string(from: date))!
        print(dayCurrent)
        
        let yearEvent = Int(dateRegist.year)!
        dayEvent = Int(dateRegist.day)!
        
        daysToEvent = daysPerMonth[monthCurrent - 1] + dayEvent - dayCurrent
        
        if  yearEvent == yearCurrent {
            if monthCurrent == monthEvent{
                daysToEvent -= daysPerMonth[monthCurrent - 1]
            } else if monthCurrent == monthEvent - 1 {
            } else {
                for i in monthCurrent...(monthEvent - 2){
                    daysToEvent += daysPerMonth[i]
                }
            }
            print(daysToEvent)
        } else {
            let yearsToEvent = yearEvent - yearCurrent - 1
            daysToEvent += (yearsToEvent * 365)
            if monthCurrent != 12 {
                for i in monthCurrent...11{
                    daysToEvent += daysPerMonth[i]
                }
            } else if monthEvent != 1 {
                for i in 1...(monthEvent - 1){
                    daysToEvent += daysPerMonth[i - 1];
                }
            }
            print(daysToEvent)
            
            isEvent = true
            
            viewDidLoad()
        }
    }
}
