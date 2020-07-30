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
    
    #if DEBUG
    static let tempItem = Temperature.TempItem(value: 64, unit: "celsius")
    static let temperature = Temperature(temp: Beer.tempItem, duration: 75)
    static let method = Method(mash_temp: [Beer.temperature], fermentation: Beer.temperature, twist: nil)
    
    static let amount = Amount(value: 3.3, unit: "kilograms")
    static let malt = Malt(name: "Maris Otter Extra Pale", amount: Beer.amount)
    static let hop = Hop(name: "Fuggles", amount: Beer.amount, add: "start", attribute: "bitter")
    static let ingredients = Ingredients(malt: [Beer.malt], hops: [Beer.hop])
    
    static let example = Beer(id: 1, name: "Buzz", description: "A light, crisp and bitter IPA brewed with English and American hops. A small batch brewed only once.", image_url: "https://images.punkapi.com/v2/keg.png", abv: 4.5, method: Beer.method, ingredients: Beer.ingredients)
    #endif
    
}
