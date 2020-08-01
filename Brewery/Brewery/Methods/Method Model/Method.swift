//
//  Method.swift
//  Brewery
//
//  Created by Cris Burlamaqui on 28/07/2020.
//  Copyright © 2020 Cris Burlamaqui. All rights reserved.
//

import Foundation

struct Method: Codable {
    
    let mash_temp: [Temperature]
    let fermentation: Temperature
    let twist: String?
}

struct Temperature: Codable {
    
    let temp: TempItem
    let duration: Int?
    
    struct TempItem: Codable {
        let value: Int
        let unit: String
    }
}
