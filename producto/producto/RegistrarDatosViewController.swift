//
//  RegistrarDatosViewController.swift
//  producto
//
//  Created by macbook on 23/11/18.
//  Copyright © 2018 potato. All rights reserved.
//

import UIKit

class RegistrarDatosViewController: UIViewController {
    
    var dateRegist: daySelected!
    var dateCollectionR = [daySelected]()
    var monthStr = [String]()
    var daysForMonth = [String]()
    
    @IBOutlet weak var mesRegisting: UILabel!
    @IBOutlet weak var diaRegisting: UILabel!
    @IBOutlet weak var descriptionRegisting: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mesRegisting.text = dateRegist.month
        
        diaRegisting.text = dateRegist.day
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
//        dismiss(animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let viewCalendar = segue.destination as? ViewController
    }
    
    func dateNotify() {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .full
        dateFormatter.timeStyle = .none
        
        dateFormatter.locale = Locale(identifier: "es_MX")
        
        print(dateFormatter.string(from: date))
        
        var dateEventComponents = DateComponents()
        
        dateEventComponents.day = Int(dateRegist.day)
        dateEventComponents.month = Int(dateRegist.month)
        dateEventComponents.year = Int(dateRegist.year)
        dateEventComponents.hour = 12
        
        dateEventComponents.timeZone = TimeZone(identifier: "UTC")
        var dateEvent = Calendar(identifier: Calendar.Identifier.gregorian).date(from: dateEventComponents)
        
        print(dateEvent!)
        
        var monthEvent: Int = 3
        var monthToday: Int = 10
        
        if 2019 > 2018 {
            var yearsTo = (2019 - 2018)
            var monthsTo = monthEvent + (yearsTo * 12) - monthToday
            
            if monthsTo > 12 {
                var monthsExcess = (monthsTo % 12)
                var monthsForYear = monthsTo - monthsExcess
                var daysTo = (monthsTo / 12) * 365
                
                
            } else if 03 < 10 {
                
            }
        }
        
//        var dateTodayComponets = DateComponents()
//
//        dateFormatter.dateFormat = "dd"
//        dateTodayComponets.day = Int(dateFormatter.string(from: date))
//
//        dateFormatter.dateFormat = "Month"
//        dateTodayComponets.month = Int(dateFormatter.string(from: date))
//
//        dateFormatter.dateFormat = "yyyy"
//        dateTodayComponets.year = Int(dateFormatter.string(from: date))
//
//        dateTodayComponets.timeZone = TimeZone(identifier: "UTC")
//        var dateTodayCalendar = Calendar(identifier: Calendar.Identifier.gregorian).date(from: dateTodayComponets)
//
//        print(Float((dateTodayCalendar?.compare(dateEvent!))!.rawValue))
    }
}
