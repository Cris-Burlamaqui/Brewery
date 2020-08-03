//
//  BeerRow.swift
//  Brewery
//
//  Created by Cris Burlamaqui on 30/07/2020.
//  Copyright © 2020 Cris Burlamaqui. All rights reserved.
//

import SwiftUI

struct BeerRow: View {
    
    @ObservedObject var beerRequest = BeerRequest()
    
    var beer: Beer
    var beerType: String
    
    static let colors: [String: Color] = ["C": .blue, "B": .purple]
    
    var body: some View {
        NavigationLink(destination: BeerDetail(beer: beer, beerType: beerType, beerImage: beerRequest.beerImage, imageLoaded: beerRequest.imageLoaded)) {
            HStack {
                
                ZStack {
                    Color(.white)
                    
                    if beerRequest.imageLoaded {
                        Image(uiImage: beerRequest.beerImage)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .padding([.top, .bottom])
                    }
                    else {
                        
                        Text("Loading...")
                            .font(.system(size: 13))
                            .foregroundColor(.black)
                    }
                        
                        
                }
                .frame(width: 80, height: 100)
                .clipShape(Circle())
                .overlay(Circle().stroke(Color.black, lineWidth: 2))
                
                VStack(alignment: .leading) {
                    Text(beer.name)
                        .font(.headline)
                    HStack {
                        Text("abv:")
                            .fontWeight(.medium)
                            .foregroundColor(.gray)
                        
                        Text("\(beer.abv, specifier: "%g")")
                            .foregroundColor(beer.abv <= 5 ? .green : .orange)
                    }
                }
                Spacer()
                Text(beerType)
                    .font(.caption)
                    .fontWeight(.black)
                    .padding(8)
                    .background(Self.colors[beerType, default: .black])
                    .foregroundColor(.white)
                    .clipShape(Circle())
            }
        }
        .onAppear(perform: displayBeerImage)
    }
    
    func displayBeerImage() {
        
        guard let imageUrl = URL(string: beer.image_url) else { return }
        beerRequest.requestBeerImage(from: imageUrl)
        
    }
}

struct BeerRow_Previews: PreviewProvider {
    
    static var previews: some View {
        
        BeerRow(beer: Beer.example, beerType: "C")
            .previewLayout(.sizeThatFits)
    }
}
