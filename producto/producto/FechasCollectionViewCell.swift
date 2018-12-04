//
//  FechasCollectionViewCell.swift
//  producto
//
//  Created by macbook on 21/11/18.
//  Copyright © 2018 potato. All rights reserved.
//

import UIKit

class FechasCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var circulo: UIView!
    @IBOutlet weak var fechalabel: UILabel!
    func dibujacirculo() {
        let centrocirculo = circulo.center
        let circuloPath = CGMutablePath()
        circuloPath.addArc(center: centrocirculo, radius: (circulo.bounds.width/2 - 5), startAngle:  -CGFloat.pi/2, endAngle: (2 * CGFloat.pi), clockwise: true)
        let circuloLayer = CAShapeLayer()
        circuloLayer.path = circuloPath
        circuloLayer.strokeColor = UIColor.blue.cgColor
        circuloLayer.lineWidth = 2
        circuloLayer.fillColor = UIColor.clear.cgColor
        
        let animacion = CABasicAnimation(keyPath: "strokeEnd")
        animacion.duration = 5
        animacion.fromValue = 0.0
        animacion.toValue = 1
        animacion.repeatCount = Float.greatestFiniteMagnitude
        
        circuloLayer.add(animacion, forKey: "strokeEndAnimation")
        circulo.layer.addSublayer(circuloLayer)
        circulo.layer.backgroundColor = UIColor.clear.cgColor
    }
}
