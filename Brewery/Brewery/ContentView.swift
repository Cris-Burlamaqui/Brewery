//
//  ContentView.swift
//  Brewery
//
//  Created by Cris Burlamaqui on 28/07/2020.
//  Copyright © 2020 Cris Burlamaqui. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var beerRequest = BeerRequest()
    
    var body: some View {
        NavigationView {
            VStack {
                List(beerRequest.beerList) { beer in
                    Text(beer.name)
                }
            }
            .navigationBarTitle("Beers")
            .onAppear(perform: consumeChallengeFile)
        }
    }
    
    func consumeChallengeFile() {
        if let codeChallengeURL = Bundle.main.url(forResource: "code_challenge_richer", withExtension: "txt") {
            if let customersBeers = try? String(contentsOf: codeChallengeURL) {
                let allBeers = customersBeers.components(separatedBy: "\n")
                generateBeerList(from: allBeers)
                return
            }
        }
        fatalError("Could not load start.txt from bundle.")
    }
    
    func generateBeerList(from allBeers: [String]) {
        
        guard allBeers.count > 1 else {
            return
        }
        let size = Int(allBeers[0]) ?? 1
        var beerDic = [String: String]()
        
        for index in 1..<allBeers.count {
            var id = ""
            var value = ""
            for letter in allBeers[index] {
                if letter.isNumber {
                    id = "\(letter)"
                }
                if letter.isLetter {
                    value = "\(letter)"
                }
            }
            if id.count > 0 && value.count > 0 && beerDic.count <= size {
                beerDic.updateValue(value, forKey: id)
            }
        }
        let beerList = beerDic.sorted(by: { $0.key < $1.key })
        let beersMap = beerList.map { $0.key }
        var beersToRequest = ""
        for beer in beersMap {
            beersToRequest += "\(beer)%7C"
        }
        beerRequest.getBeerData(from: beersToRequest)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
