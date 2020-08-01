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
    
    func getBeerData(from beersIds: String) {
        
        let urlString = "https://api.punkapi.com/v2/beers?ids=\(beersIds)"
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            guard let data = data else { return }
            
            do {
                let beers = try JSONDecoder().decode([Beer].self, from: data)
                DispatchQueue.main.async {
                    self.beerList = beers
                }
            }
            catch let error {
                print("Error decode: \(error.localizedDescription)")
            }
            
        }.resume()
    }
}
