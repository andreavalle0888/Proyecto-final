//
//  Calendariovar.swift
//  producto
//
//  Created by macbook on 21/11/18.
//  Copyright © 2018 potato. All rights reserved.
//

import Foundation
let date = Date()
let calendario = Calendar.current

let day = calendario.component(.day, from: date)
let weekday = calendario.component(.weekday, from: date)
let month = calendario.component(.month, from: date) - 1
let year = calendario.component(.year, from: date)
