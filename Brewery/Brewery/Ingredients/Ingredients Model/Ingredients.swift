//
//  Ingredients.swift
//  Brewery
//
//  Created by Cris Burlamaqui on 28/07/2020.
//  Copyright © 2020 Cris Burlamaqui. All rights reserved.
//

import Foundation

class Ingredients: ObservableObject {
    
    var malt: [Malt]
    var hops: [Hop]
    
    init(malts: [Malt], hops: [Hop]) {
        self.malt = malts
        self.hops = hops
    }
}

class Malt: ObservableObject {
    
    @Published var isUsed = false
    
    var name: String
    var amount: Amount
    
    init(name: String, amount: Amount) {
        self.name = name
        self.amount = amount
    }
}

class Hop: ObservableObject {
    
    @Published var isUsed = false
    
    var name: String
    var amount: Amount
    var add: String
    var attribute: String
    
    init(name: String, amount: Amount, add: String, attribute: String) {
        self.name = name
        self.amount = amount
        self.add = add
        self.attribute = attribute
    }
}

class Amount: ObservableObject {
    var value: Double
    var unit: String
    init(value: Double, unit: String) {
        self.value = value
        self.unit = unit
    }
}
