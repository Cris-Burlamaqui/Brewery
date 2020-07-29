//
//  Ingredients.swift
//  Brewery
//
//  Created by Cris Burlamaqui on 28/07/2020.
//  Copyright © 2020 Cris Burlamaqui. All rights reserved.
//

import Foundation

struct Ingredients: Codable {
    
    let malt: [Malt]
    let hops: [Hop]
}

struct Malt: Codable {
    let name: String
    let amount: Amount
}

struct Hop: Codable {
    let name: String
    let amount: Amount
    let add: String
    let attribute: String
}

struct Amount: Codable {
    let value: Double
    let unit: String
}
