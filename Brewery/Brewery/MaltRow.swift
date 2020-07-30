//
//  MaltRow.swift
//  Brewery
//
//  Created by Cris Burlamaqui on 30/07/2020.
//  Copyright © 2020 Cris Burlamaqui. All rights reserved.
//

import SwiftUI

struct MaltRow: View {
    
    var malt: Malt
    
    var body: some View {
        List {
            Text(malt.name)
                .font(.headline)
                .foregroundColor(.gray)
            
            HStack {
                Text("amount:")
                Spacer()
                Text("\(malt.amount.value, specifier: "%g") \(malt.amount.unit)")
                    .foregroundColor(.gray)
            }
        }
    }
}

struct MaltRow_Previews: PreviewProvider {
    
    static var previews: some View {
        MaltRow(malt: Beer.malt)
    }
}
