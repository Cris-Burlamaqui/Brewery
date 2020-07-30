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
                .fontWeight(.medium)
            
            HStack {
                Text("amount:")
                    .fontWeight(.medium)
                Spacer()
                Text("value: \(hop.amount.value, specifier: "%g")")
                Text("unit: \(hop.amount.unit)")
            }
            
            Text("add: \(hop.add)")
            Text("attribute: \(hop.attribute)")
            
        }
    }
}

struct HopRow_Previews: PreviewProvider {
    static var previews: some View {
        HopRow(hop: Beer.hop)
    }
}
