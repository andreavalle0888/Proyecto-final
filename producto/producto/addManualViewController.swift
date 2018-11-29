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
    var meses = ["Enero","Febrero","Marzo","Abril","Mayo","Junio","Julio","Agosto","Septiembre","Octubre","Noviembre","Diciembre"]
    var diasdelmes =  [31,28,31,30,31,30,31,31,30,31,30,31]
    var m: String  = ""
    var month: String = ""
    var dm: Int = 0 // Se puede borrar
    var year: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
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
        
        
        /*Definiciòn del tiempo antes de la notificasión
         var firstDateComponents = Date()
         var secondDateComponents = DateComponents()
         
         firstDateComponents.timeZone = TimeZone(abbreviation: "UTC")
         
         secondDateComponents.day = Int(strDate)
         secondDateComponents.month = Int(m)
         secondDateComponents.year = Int(year)
         
         secondDateComponents.timeZone = TimeZone(abbreviation: "UTC")
         
         var firstDate = Calendar(identifier: Calendar.Identifier.gregorian).date(from: firstDateComponents)
         var secondDate = Calendar(identifier: Calendar.Identifier.gregorian).date(from: secondDateComponents)
         
         print(firstDate!)
         print(secondDate!)
         
         if (firstDate?.compare(secondDate!) == .orderedAscending) {
         
         print("firstDate < secondDate")
         
         } else if (firstDate?.compare(secondDate!) == .orderedDescending) {
         
         print("firstDate > secondDate")
         
         } else if (firstDate?.compare(secondDate!) == .orderedSame) {
         
         print("firstDate = secondDate")
         
         }*/
        
        //Notificasión
        let content = UNMutableNotificationContent()
        content.title = "¡¡Tienes un evento!!"
        content.body = "Body"
        content.sound = UNNotificationSound.default                  //cambiar dm   TimeInterval(dm)
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        let request = UNNotificationRequest(identifier: "testIdentifier", content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
        
    }
    
    func getDatePicker() {
        var dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "Month"
        m = dateFormatter.string(from: pickerOutlet.date)
        month = meses[Int(m)!-1]
        dm = diasdelmes[Int(m)!-1] //da los dias del mes escogido, quizas no sirva
        dateFormatter.dateFormat = "dd"
        strDate = dateFormatter.string(from: pickerOutlet.date)
        dateFormatter.dateFormat = "yyyy"
        year = dateFormatter.string(from: pickerOutlet.date)
    }
}
