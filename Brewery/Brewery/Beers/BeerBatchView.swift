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
    @State private var showNoSolution = true
    
    var body: some View {
        NavigationView {
            VStack {
                
                if showNoSolution {
                    
                    if !beerRequest.wainting {
                        VStack {
                            HStack {
                                Image("beer_example")
                                .resizable()
                                .frame(width: 70, height: 70)
                                .clipShape(Circle())
                                
                                Button(action: {
                                    self.consumeChallengeFile()
                                }) {
                                    Text("Load beer batch")
                                        .foregroundColor(Color.primary)
                                }
                                .padding()
                                .clipShape(RoundedRectangle(cornerRadius: 3))
                                .overlay(RoundedRectangle(cornerRadius: 3).stroke(Color.primary, lineWidth: 1))
                            }
                            .padding([.top], 20)
                            
                            Spacer()
                        }
                    }
                    else {
                        VStack {
                            Text(showNoSolution ? "No solution found!" : "Request error!")
                                .padding([.top])
                            
                            Spacer()
                        }
                    }
                }
                else {
                    
                    ZStack {
                        List(self.beerRequest.beerList) { beer in
                            BeerRow(beer: beer, beerType: self.beerBatch[beer.id - 1])
                        }
                        .padding([.top])

                        if beerRequest.wainting {
                            LoaderView()
                        }
                    }
                }
                
            }
            .navigationBarTitle("Beer Batch")
            .alert(isPresented: $showingAlert) { () -> Alert in
                Alert(title: Text("Error"), message: Text("There's no solution which satisfies all customers."), dismissButton: .cancel({
                    self.showNoSolution = true
                }))
            }
        }
    }
    
    func consumeChallengeFile() {
        
        beerRequest.wainting = true
        
        if let codeChallengeURL = Bundle.main.url(forResource: "code_challenge_richer", withExtension: "txt") {
            if let customersBeers = try? String(contentsOf: codeChallengeURL) {
                let allBeers = customersBeers.components(separatedBy: "\n")
                
                let beerTypeBatch = BeerTypeBatchModel(with: allBeers).beerTypeBatch
                
                if beerTypeBatch.isEmpty {
                    beerRequest.wainting = false
                    showingAlert = true
                }
                else {
                    showNoSolution = false
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
