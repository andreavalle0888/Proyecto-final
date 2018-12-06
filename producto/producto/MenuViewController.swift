//
//  MenuViewController.swift
//  producto
//
//  Created by Macbook on 12/6/18.
//  Copyright © 2018 potato. All rights reserved.
//

import UIKit
import UserNotifications

class MenuViewController: UIViewController {
    
    var once: Bool!

    override func viewDidLoad() {
        super.viewDidLoad()
        let registDate = UserDefaults.standard
        
//        once = true
//        registDate.set(once, forKey: "isFirst")
        
        once = registDate.bool(forKey: "isFirst")
        
        if once == true {
            let content = UNMutableNotificationContent()
            content.title = "Bienvenido a SAJA-Agend"
            content.body = "Ahora cada vez que crees un evento recibirás notificaciones"
            content.sound = UNNotificationSound.default
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)
            let request = UNNotificationRequest(identifier: "testIdentifier", content: content, trigger: trigger)
            UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
            
//            return
            
            once = false
            registDate.set(once, forKey: "isFirst")
        }
    }
    
}
