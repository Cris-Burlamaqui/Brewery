//
//  BeerRow.swift
//  Brewery
//
//  Created by Cris Burlamaqui on 30/07/2020.
//  Copyright © 2020 Cris Burlamaqui. All rights reserved.
//

import SwiftUI

struct BeerRow: View {
    
    static let colors: [String: Color] = ["C": .blue, "B": .purple]
    
    var beer: Beer
    var beerType: String
    
    @State private var beerImage = UIImage(named: "beer_example")!
    
    var body: some View {
        HStack {
            
            Image(uiImage: beerImage)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 80, height: 100)
            
            VStack(alignment: .leading) {
                Text(beer.name)
                    .font(.headline)
                    .foregroundColor(.gray)
                HStack {
                    Text("abv:")
                        .fontWeight(.medium)
                        .foregroundColor(.gray)
                    
                    Text("\(beer.abv, specifier: "%g")")
                        .foregroundColor(beer.abv <= 5 ? .green : .red)
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
        .onAppear(perform: displayBeerImage)
    }
    
    func displayBeerImage() {
        guard let imageUrl = URL(string: beer.image_url) else { return }
        let task = URLSession.shared.downloadTask(with: imageUrl) { location, response, error in
                guard let location = location,
                    let imageData = try? Data(contentsOf: location),
                    let image = UIImage(data: imageData) else { return }
            
            DispatchQueue.main.async {
                self.beerImage = image
            }
        }
        task.resume()
    }
}

struct BeerRow_Previews: PreviewProvider {
    
    static var previews: some View {
        
        BeerRow(beer: Beer.example, beerType: "C")
    }
}
