//
//  Beer.swift
//  Brewery
//
//  Created by Cris Burlamaqui on 28/07/2020.
//  Copyright © 2020 Cris Burlamaqui. All rights reserved.
//

import Foundation

class Beer: Identifiable, ObservableObject {
    
    let id: Int
    let name: String
    let description: String
    let image_url: String
    let abv: Double
    let method: Method
    let ingredients: Ingredients
    
    init(id: Int, name: String, description: String, imageUrl: String, abv: Double, method: Method, ingredients: Ingredients) {
        self.id = id
        self.name = name
        self.description = description
        self.image_url = imageUrl
        self.abv = abv
        self.method = method
        self.ingredients = ingredients
    }
    
    #if DEBUG
    static let tempItem = Method.TempItem(value: 64, unit: "celsius")
    static let temperature = Method.Temperature(temp: tempItem, duration: 75)
    static let temperature2 = Method.Temperature(temp: tempItem, duration: nil)
    static let method = Method(mash: [Beer.temperature, Beer.temperature2], fermentation: tempItem, twist: "Bite and imaginative twist.")
    
    static let amount = Amount(value: 3.3, unit: "kilograms")
    static let malt = Malt(name: "Maris Otter Extra Pale", amount: Beer.amount)
    static let hop = Hop(name: "Fuggles", amount: Beer.amount, add: "start", attribute: "bitter")
    static let ingredients = Ingredients(malts: [Beer.malt], hops: [Beer.hop])
    
    static let example = Beer(id: 1, name: "Buzz", description: "A light, crisp and bitter IPA brewed with English and American hops. A small batch brewed only once.", imageUrl: "https://images.punkapi.com/v2/keg.png", abv: 4.5, method: Beer.method, ingredients: Beer.ingredients)
    #endif
    
}
