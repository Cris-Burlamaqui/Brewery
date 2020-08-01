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
                
                let beerTypeBatch = BeerTypeBatchModel(with: allBeers).beerTypeBatch
                
                if beerTypeBatch.isEmpty {
                    beerRequest.wainting = false
                    showingAlert = true
                }
                else {
                    requestBeerData(from: beerTypeBatch)
                }
            }
        }
        else {
            fatalError("Could not load start.txt from bundle.")
        }
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
