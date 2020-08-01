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
    @State var imageLoaded = false
    
    var body: some View {
        NavigationLink(destination: BeerDetail(beer: beer, beerType: beerType, beerImage: beerImage, imageLoaded: imageLoaded)) {
            HStack {
                
                ZStack {
                    Color(.white)
                    
                    if imageLoaded {
                        Image(uiImage: beerImage)
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
        let task = URLSession.shared.downloadTask(with: imageUrl) { location, response, error in
                guard let location = location,
                    let imageData = try? Data(contentsOf: location),
                    let image = UIImage(data: imageData) else { return }
            
            DispatchQueue.main.async {
                self.beerImage = image
                self.imageLoaded = true
            }
        }
        task.resume()
    }
}

struct BeerRow_Previews: PreviewProvider {
    
    static var previews: some View {
        
        BeerRow(beer: Beer.example, beerType: "C")
            .previewLayout(.sizeThatFits)
    }
}
