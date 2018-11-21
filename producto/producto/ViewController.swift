//
//  ViewController.swift
//  producto
//
//  Created by macbook on 21/11/18.
//  Copyright © 2018 potato. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate,UICollectionViewDataSource{
    

    @IBOutlet weak var Calendario: UICollectionView!
    @IBOutlet weak var labelmeses: UILabel!
    
    let Meses = ["Enero","Febrero","Marzo","Abril","Mayo","Junio","Julio","Agosto","Septiembre","Octubre","Noviembre", "Diciembre"]
    let diasmes = ["Lunes","Martes","Miercoles","Jueves","Viernes"]
    let diasdelmes =  [31,28,31,30,31,30,31,31,30,31,30,31]
    var currentMes = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
      currentMes = Meses[month]
        labelmeses.text = "\(currentMes)\(year)"
        
    }

    @IBAction func siguiente(_ sender: Any) {
    }
  
    @IBAction func atras(_ sender: Any) {
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return diasdelmes[month]
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Calendario", for: indexPath)as! FechasCollectionViewCell
        cell.backgroundColor = UIColor.clear
        cell.fechalabel.text = "\(indexPath.row + 1)"
        return cell
        
    }
    
    
}

