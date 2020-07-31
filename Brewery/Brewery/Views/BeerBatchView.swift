//
//  ContentView.swift
//  Brewery
//
//  Created by Cris Burlamaqui on 28/07/2020.
//  Copyright © 2020 Cris Burlamaqui. All rights reserved.
//

import SwiftUI

struct BeerBatchView: View {
    
    @ObservedObject var beerRequest = BeerRequest()
    
    @State var beerBatch = [String]()
    @State private var showingAlert = false
    @State private var showNoSolution = false
    
    var body: some View {
        NavigationView {
            VStack {
                
                if showNoSolution {
                    VStack {
                        Text(showNoSolution ? "No solution found!" : "Request error!")
                            .padding([.top])
                        
                        Spacer()
                    }
                }
                else {
                    
                    ZStack {
                        List(self.beerRequest.beerList) { beer in
                            BeerRow(beer: beer, beerType: self.beerBatch[beer.id - 1])
                        }
                        
                        if beerRequest.wainting {
                            LoaderView()
                        }
                    }
                }
                
            }
            .navigationBarTitle("Beer Batch")
            .onAppear(perform: consumeChallengeFile)
            .alert(isPresented: $showingAlert) { () -> Alert in
                Alert(title: Text("Error"), message: Text("There's no solution which satisfies all customers."), dismissButton: .cancel({
                    self.showNoSolution = true
                }))
            }
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
        
        var clientList = generateClientList(from: allBeers)
        let types = Int(allBeers[0]) ?? 1
        var beers = Array(repeating: "", count: types)
        
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
            beerRequest.wainting = false
            showingAlert = true
        }
        else {
            requestBeerData(from: beers)
        }
    }
    
    func generateClientList(from allCustomersBeers: [String]) -> [[String]] {
        
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
        return clients.sorted { $0.count < $1.count }
    }
    
    func requestBeerData(from beers: [String]) {
        
        var beersIds = ""
        for idx in 0..<beers.count {
            beersIds += "\(idx + 1)%7C"
        }
        beerRequest.getBeerData(from: beersIds)
        beerBatch = beers
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            BeerBatchView().environment(\.colorScheme, .light)
            
            BeerBatchView().environment(\.colorScheme, .dark)
        }
    }
}

extension String {
    func deletingPrefix(_ prefix: String) -> String {
        guard self.hasPrefix(prefix) else { return self }
        return String(self.dropFirst(prefix.count))
    }
}