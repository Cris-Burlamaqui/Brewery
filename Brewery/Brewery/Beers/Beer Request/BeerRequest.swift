//
//  BeerData.swift
//  Brewery
//
//  Created by Cris Burlamaqui on 28/07/2020.
//  Copyright © 2020 Cris Burlamaqui. All rights reserved.
//

import Foundation

class BeerRequest: ObservableObject {
    
    @Published var beerList = [Beer]()
    @Published var wainting = false
    
    func getBeerData(from beersIds: String) {
        
        let urlString = "https://api.punkapi.com/v2/beers?ids=\(beersIds)"
        let url = URL(string: urlString)!
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        let session = URLSession(configuration: .default)
        
        session.dataTask(with: request) { data, response, error in
            
            guard let httpResponse = response as? HTTPURLResponse,
                  let data = data else { return }
            
            if httpResponse.statusCode == 200 {
                self.retrieveBeer(from: data)
            }
            
        }.resume()
    }
    
    private func retrieveBeer(from data: Data) {
        
        do {
            let json = try JSONSerialization.jsonObject(with: data, options: []) as? [[String: Any]]
            if let jsonData = json {
                let beers = parseBeer(from: jsonData)
                DispatchQueue.main.async {
                    self.beerList = beers
                    self.wainting = false
                }
            }
            
        } catch let error as NSError {
            print("Serialization error: \(error.localizedDescription)")
            DispatchQueue.main.async {
                self.wainting = false
            }
        }
        
    }
    
    private func parseBeer(from json: [[String: Any]]) -> [Beer] {
    
        var beerClientList = [Beer]()
        
        for beerClient in json {
            
            let id = beerClient["id"] as! Int
            let name = beerClient["name"] as! String
            let description = beerClient["description"] as! String
            let imageUrl = beerClient["image_url"] as! String
            let abv = beerClient["abv"] as! Double
            let method = parseMethod(from: beerClient["method"] as! [String : Any])
            let ingredients = parseIngredients(from: beerClient["ingredients"] as! [String : Any])
            
            let beer = Beer(id: id, name: name, description: description, imageUrl: imageUrl, abv: abv, method: method, ingredients: ingredients)
            beerClientList.append(beer)
        }
        
        return beerClientList
    }
    
    private func parseMethod(from clientMethod: [String: Any]) -> Method {
        
        let twist = clientMethod["twist"] as? String
        
        let ferment = clientMethod["fermentation"] as! [String: Any]
        let fermentTemp = ferment["temp"] as! [String: Any]
        let fermentValue = fermentTemp["value"] as! Int
        let fermentUnit = fermentTemp["unit"] as! String
        let fermentation = Method.TempItem(value: fermentValue, unit: fermentUnit)
        
        let mashs = clientMethod["mash_temp"] as! [[String: Any]]
        var mashList = [Method.Temperature]()
        
        for mash in mashs {
            let tempItem = mash["temp"] as! [String: Any]
            let value = tempItem["value"] as! Int
            let unit = tempItem["unit"] as! String
            let temp = Method.TempItem(value: value, unit: unit)
            let duration = mash["duration"] as? Int
            
            let mashItem = Method.Temperature(temp: temp, duration: duration)
            mashList.append(mashItem)
        }
        
        return Method(mash: mashList, fermentation: fermentation, twist: twist)
    }
    
    private func parseIngredients(from clientIngredients: [String: Any]) -> Ingredients {
        
        let malts = clientIngredients["malt"] as! [[String: Any]]
        var maltList = [Malt]()
        for malt in malts {
            let name = malt["name"] as! String
            let amt = malt["amount"] as! [String: Any]
            let value = amt["value"] as! Double
            let unit = amt["unit"] as! String
            let amount = Amount(value: value, unit: unit)
            
            let maltItem = Malt(name: name, amount: amount)
            maltList.append(maltItem)
        }
        
        
        let hops = clientIngredients["hops"] as! [[String: Any]]
        var hopList = [Hop]()
        for hop in hops {
            let name = hop["name"] as! String
            let amt = hop["amount"] as! [String: Any]
            let value = amt["value"] as! Double
            let unit = amt["unit"] as! String
            let amount = Amount(value: value, unit: unit)
            let add = hop["add"] as! String
            let attribute = hop["attribute"] as! String
            
            let hopItem = Hop(name: name, amount: amount, add: add, attribute: attribute)
            hopList.append(hopItem)
        }
        
        return Ingredients(malts: maltList, hops: hopList)
    }
}
