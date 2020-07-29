//
//  Beer.swift
//  Brewery
//
//  Created by Cris Burlamaqui on 28/07/2020.
//  Copyright © 2020 Cris Burlamaqui. All rights reserved.
//

import Foundation

struct Beer: Codable, Identifiable {
    
    let id: Int
    let name: String
    let description: String
    let image_url: String
    let abv: Double
    let method: Method
    let ingredients: Ingredients
    
}
