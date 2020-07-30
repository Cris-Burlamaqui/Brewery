//
//  HopRow.swift
//  Brewery
//
//  Created by Cris Burlamaqui on 30/07/2020.
//  Copyright © 2020 Cris Burlamaqui. All rights reserved.
//

import SwiftUI

struct HopRow: View {
    
    var hop: Hop
    
    var body: some View {
        List {
            Text(hop.name)
                .font(.headline)
                .foregroundColor(.gray)
            
            HStack {
                Text("amount:")
                Spacer()
                Text("\(hop.amount.value, specifier: "%g") \(hop.amount.unit)")
                    .foregroundColor(.gray)
            }
            
            HStack {
                Text("add:")
                Spacer()
                Text("\(hop.add)")
                    .foregroundColor(.gray)
            }
            
            HStack {
                Text("attribute:")
                Spacer()
                Text("\(hop.attribute)")
                    .foregroundColor(.gray)
            }
            
        }
    }
}

struct HopRow_Previews: PreviewProvider {
    static var previews: some View {
        HopRow(hop: Beer.hop)
    }
}
