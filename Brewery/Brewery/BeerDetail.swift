//
//  BeerDetail.swift
//  Brewery
//
//  Created by Cris Burlamaqui on 30/07/2020.
//  Copyright © 2020 Cris Burlamaqui. All rights reserved.
//

import SwiftUI

struct BeerDetail: View {
    
    static let typeDesc: [String: String] = ["C":"Classic", "B":"Barrel Aged"]
    static let typeColor: [String: Color] = ["C": .blue, "B": .purple]
    
    var beer: Beer
    var beerType: String
    var beerImage: UIImage
    
    var body: some View {
        
        NavigationView {
        
            VStack {
                ZStack {
                    Color(.black)
                    ZStack(alignment: .bottomTrailing) {
                        Image(uiImage: beerImage)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                        Text("\(Self.typeDesc[beerType]!)")
                            .padding(4)
                            .background(Self.typeColor[beerType, default: .black])
                            .clipShape(RoundedRectangle(cornerRadius: 3))
                            .font(.caption)
                            .foregroundColor(.white)
                            .offset(x: -5, y: -5)
                    }
                }
                
                HStack{
                    Spacer()
                    HStack(alignment: .center) {
                        Text("abv:")
                        Text("\(beer.abv, specifier: "%g")")
                            .padding(8)
                            .background(beer.abv <= 5 ? Color.green : Color.red)
                            .clipShape(Circle())
                    }
                }
                .padding()
                
                Text(beer.description)
                    .padding()
                
                Form {
                    Section(header: Text("Malts").font(.headline)) {
                        List {
                            ForEach(0..<beer.ingredients.malt.count) { idx in
                                MaltRow(malt: self.beer.ingredients.malt[idx])
                            }
                        }
                    }
                    
                    Section(header: Text("Hops").font(.headline)) {
                        List() {
                            ForEach(0..<beer.ingredients.hops.count) { idx in
                                HopRow(hop: self.beer.ingredients.hops[idx])
                            }
                        }
                    }
                }
            }
            .navigationBarTitle(Text("\(beer.name)"))
        }
    }
}

struct BeerDetail_Previews: PreviewProvider {
    static var previews: some View {
        BeerDetail(beer: Beer.example, beerType: "B", beerImage:  UIImage(named: "beer_example")!)
    }
}
