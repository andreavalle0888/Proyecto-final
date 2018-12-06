//
//  addManualViewController.swift
//  producto
//
//  Created by macbook on 11/26/18.
//  Copyright © 2018 potato. All rights reserved.
//

import UIKit
import UserNotifications

class addManualViewController: UIViewController {

    
    @IBOutlet weak var actividad: UITextField!
    @IBOutlet weak var pickerOutlet: UIDatePicker!
    
    var dateRegist: daySelected!
    var dateCollectionR = [daySelected]()
    var strDate: String!
    var colorEvent: UIColor! = UIColor(hue: 1/5, saturation: 10, brightness: 0.7, alpha: 1.5)
    var meses = ["Enero","Febrero","Marzo","Abril","Mayo","Junio","Julio","Agosto","Septiembre","Octubre","Noviembre","Diciembre"]
    var month: String = ""
    var year: String!
    let daysPerMonth = [31,28,31,30,31,30,31,31,30,31,30,31]
    var monthEvent: Int!
    var yearEvent: Int!
    var dayEvent: Int!
    var daysToEvent: Int!
    var isEvent: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pickerOutlet.setValue(colorEvent, forKeyPath: "textColor")
        
        if isEvent {
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
            
            isEvent = false
        }
    }
    
    @IBAction func pickerAction(_ sender: UIDatePicker) {
        getDatePicker()
    }
    
    @IBAction func guardar(_ sender: UIButton) {
        
        getDatePicker()
        
        let registD = UserDefaults.standard
        
        guard strDate != nil else { return }
        
        dateRegist = daySelected(day: strDate, month: month, year: year, description: actividad.text!)
        
        if let listEvents = registD.value(forKey: "dateEvents") as? Data{
            let temp = try? PropertyListDecoder().decode(Array<daySelected>.self, from: listEvents)
            
            dateCollectionR = temp!
        }
        
        dateCollectionR.append(dateRegist)
        
        registD.set(try? PropertyListEncoder().encode(dateCollectionR), forKey: "dateEvents")
        
        print("Ya se registró") //Agregar alerta
        
        print(dateCollectionR)
        
        dateNotify()
        
        dismiss(animated: true, completion: nil)
        
    }
    
    func getDatePicker() {
        var dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "Month"
        var m = dateFormatter.string(from: pickerOutlet.date)
        month = meses[Int(m)!-1]
        monthEvent = Int(month)
        dateFormatter.dateFormat = "dd"
        strDate = dateFormatter.string(from: pickerOutlet.date)
        dayEvent = Int(strDate)
        dateFormatter.dateFormat = "yyyy"
        year = dateFormatter.string(from: pickerOutlet.date)
        yearEvent = Int(year)
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
        let monthCurrent = Int(dateFormatter.string(from: date))!
        print(monthCurrent)
        
        dateFormatter.dateFormat = "dd"
        let dayCurrent = Int(dateFormatter.string(from: date))!
        print(dayCurrent)
        
        yearEvent = Int(dateRegist.year)!
        print(yearEvent)
        dayEvent = Int(dateRegist.day)!
        print(monthEvent)
        print(dayEvent)
        
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
