//
//  RegistrarDatosViewController.swift
//  producto
//
//  Created by macbook on 23/11/18.
//  Copyright © 2018 potato. All rights reserved.
//

import UIKit

class RegistrarDatosViewController: UIViewController {
    
    var dia: String!
    var mes: String!
    var año: String!
    var dateRegist: daySelected!
    var dateCollectionR = [daySelected]()
    
    @IBOutlet weak var mesRegisting: UILabel!
    @IBOutlet weak var diaRegisting: UILabel!
    @IBOutlet weak var descriptionRegisting: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mesRegisting.text = mes
        
        diaRegisting.text = dia
    }
    
    @IBAction func saveEvent(_ sender: UIButton) {
        let registD = UserDefaults.standard
        
        dateRegist = daySelected(day: dia, month: mes, year: año, description: descriptionRegisting.text!)
        
        if let listEvents = registD.value(forKey: "dateEvents") as? Data{
            let temp = try? PropertyListDecoder().decode(Array<daySelected>.self, from: listEvents)
            
            dateCollectionR = temp!
        }
        
        dateCollectionR.append(dateRegist)
        
        registD.set(try? PropertyListEncoder().encode(dateCollectionR), forKey: "dateEvents")
        
        print(dateCollectionR)
        
//        isEvent = true
        
        
        
        performSegue(withIdentifier: "toCalendar", sender: nil)
//        dismiss(animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let viewCalendar = segue.destination as? ViewController
    }
    
    func dateNotify() {
        let date = Date()
    }
}
