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
    
    func retrieveBeer(from data: Data) {
        
        do {
            let decoder = JSONDecoder()
            let beers = try decoder.decode([Beer].self, from: data)
            DispatchQueue.main.async {
                self.beerList = beers
            }
        } catch let decodeError as NSError {
            print("Decode error: \(decodeError.localizedDescription)")
            return
        }
    }
}
