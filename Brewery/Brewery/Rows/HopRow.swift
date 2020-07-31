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
        VStack(alignment: .leading, spacing: 10) {
            Text(hop.name)
                .font(.system(size: 16, weight: .semibold, design: .default))
                .foregroundColor(.gray)
            
            HStack {
                Text("amount:")
                .font(.system(size: 16))
                Spacer()
                Text("\(hop.amount.value, specifier: "%g") \(hop.amount.unit)")
                    .foregroundColor(.gray)
                    .font(.system(size: 16))
            }
            
            HStack {
                Text("add:")
                .font(.system(size: 16))
                Spacer()
                Text("\(hop.add)")
                    .foregroundColor(.gray)
                    .font(.system(size: 16))
            }
            
            HStack {
                Text("attribute:")
                    .font(.system(size: 16))
                Spacer()
                Text("\(hop.attribute)")
                    .foregroundColor(.gray)
                    .font(.system(size: 16))
            }
            
        }
    }
}

struct HopRow_Previews: PreviewProvider {
    static var previews: some View {
        HopRow(hop: Beer.hop)
            .previewLayout(.sizeThatFits)
    }
}
