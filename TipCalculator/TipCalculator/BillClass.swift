//
//  BillClass.swift
//  TipCalculator
//
//  Created by Di Hoang on 5/3/17.
//  Copyright © 2017 Di Hoang. All rights reserved.
//

import Foundation

class BillClass {
    var bill: Double
    var tip: Double
    var total: Double
    var tipPercentage: Double
    var splitNumber: Int
    var totalEach: Double
    
    init(_ bill: Double, _ tip: Double, _ total: Double, _ tipPercentage: Double, _ splitNumber: Int, _ totalEach: Double) {
        self.bill = bill
        self.tip = tip
        self.total = total
        self.tipPercentage = tipPercentage
        self.splitNumber = splitNumber
        self.totalEach = totalEach
    }
}
