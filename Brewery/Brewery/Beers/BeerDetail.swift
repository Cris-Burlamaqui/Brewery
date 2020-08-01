//
//  BeerDetail.swift
//  Brewery
//
//  Created by Cris Burlamaqui on 30/07/2020.
//  Copyright © 2020 Cris Burlamaqui. All rights reserved.
//

import SwiftUI

struct BeerDetail: View {
    
    @Environment(\.colorScheme) var colorScheme
    
    static let typeDesc: [String: String] = ["C":"Classic", "B":"Barrel Aged"]
    static let typeColor: [String: Color] = ["C": .blue, "B": .purple]
    
    @State var maltsIsPresented = false
    @State var hopsIsPresented = false
    @State var methodIsPresented = false
    
    var beer: Beer
    var beerType: String
    var beerImage: UIImage
    var imageLoaded = false
    
    var body: some View {
        VStack {
            
            ZStack(alignment: .bottomTrailing) {
                ZStack {
                    Color(colorScheme == .dark ? .white : .black)
                    
                    if imageLoaded {
                        Image(uiImage: beerImage)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .padding()
                    }
                    else {
                        Text("Loading...")
                            .foregroundColor(colorScheme == .dark ? .black : .white)
                    }
                }
                
                Text("\(Self.typeDesc[beerType]!)")
                    .padding(4)
                    .background(Self.typeColor[beerType, default: .black])
                    .clipShape(RoundedRectangle(cornerRadius: 3))
                    .font(.system(size: 13))
                    .foregroundColor(.white)
                    .offset(x: -5, y: -5)
            }
            
            HStack{
                Spacer()
                HStack(alignment: .center) {
                    Text("abv:")
                    Text("\(beer.abv, specifier: "%g")")
                        .font(.system(size: 14, weight: .bold))
                        .padding(8)
                        .background(beer.abv <= 5 ? Color.green : Color.orange)
                        .clipShape(Circle())
                        .foregroundColor(.white)
                }
            }
            
            Text(beer.description)
                .padding()
            
            Form {
                Section(header: Text("Ingredients").font(.headline).padding([.top])) {
                    
                    NavigationLink(destination: MaltsDetail(malts: beer.ingredients.malt)) {
                        Text("Malts")
                    }
                    
                    
                    NavigationLink(destination: HopsDetail(hops: beer.ingredients.hops)) {
                        Text("Hops")
                    }
                    
                }
                
                Section(header: Text("Methods").font(.headline)) {
                    NavigationLink(destination: MethodDetail(method: beer.method)) {
                        Text("Method list")
                    }
                    
                    
                }
                .navigationBarTitle(Text(beer.name), displayMode: .inline)
            }
        }
        
    }
}

struct BeerDetail_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            
            BeerDetail(beer: Beer.example, beerType: "B", beerImage:  UIImage(named: "beer_example")!, imageLoaded: false)
            
            BeerDetail(beer: Beer.example, beerType: "B", beerImage:  UIImage(named: "beer_example")!, imageLoaded: false).environment(\.colorScheme, .dark)
        }
    }
}
