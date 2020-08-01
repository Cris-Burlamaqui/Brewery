//
//  BeerTypeBatchModel.swift
//  Brewery
//
//  Created by Cris Burlamaqui on 01/08/2020.
//  Copyright © 2020 Cris Burlamaqui. All rights reserved.
//

import Foundation

struct BeerTypeBatchModel {
    
    private var beerTypes: String
    private var clientsBeerList = [[String]]()
    
    var beerTypeBatch: [String] {
        self.generateBeerTypeBatch(from: self.clientsBeerList)
    }
    
    
    init(with allCustomersBeers: [String]) {
        
        self.beerTypes = allCustomersBeers[0]
        
        var clients = [[String]]()
        for index in 1..<allCustomersBeers.count where allCustomersBeers[index].count > 1 {
            
            let beerTypes = allCustomersBeers[index].replacingOccurrences(of: " ", with: "")
            var types = [String]()
            var prefix = ""
            
            for item in beerTypes {
                prefix += String(item)
                if item.isLetter {
                    types.append(prefix)
                    prefix = ""
                }
            }
            clients.append(types)
        }
        self.clientsBeerList =  clients.sorted { $0.count < $1.count }
    }
    
    
    
    private func generateBeerTypeBatch(from allClientsBeers: [[String]]) -> [String] {
        
        guard allClientsBeers.count > 1 else {
            return []
        }
        
        var clientList = allClientsBeers
        let beerTypes = Int(self.beerTypes) ?? 1
        var beers = Array(repeating: "", count: beerTypes)
        
        for clientBeers in clientList {
            for (idx, beer) in clientBeers.enumerated() {
                let index = beer.prefix{ "0"..."9" ~= $0 }
                let i = Int(index)! - 1
                let type = beer.deletingPrefix(String(index))
                if beers[i].elementsEqual(type) || beers[i].elementsEqual("") {
                    if type.elementsEqual("B") && idx != (clientBeers.endIndex - 1) {
                        continue
                    }
                    beers[i] = type
                    clientList.removeFirst()
                    break
                }
            }
        }
        
        if beers.contains("") {
            for (i, beer) in beers.enumerated() {
                if beer.elementsEqual("") {
                    beers[i] = "C"
                }
            }
        }
        
        if clientList.count > 0 {
            return []
        }
        
        return beers
    }
}

extension String {
    func deletingPrefix(_ prefix: String) -> String {
        guard self.hasPrefix(prefix) else { return self }
        return String(self.dropFirst(prefix.count))
    }
}
