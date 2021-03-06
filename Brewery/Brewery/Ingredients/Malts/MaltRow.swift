//
//  MaltRow.swift
//  Brewery
//
//  Created by Cris Burlamaqui on 30/07/2020.
//  Copyright © 2020 Cris Burlamaqui. All rights reserved.
//

import SwiftUI

struct MaltRow: View {
    
    @ObservedObject var malt: Malt
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(malt.name)
                .font(.system(size: 16, weight: .semibold, design: .default))
                .foregroundColor(.gray)
            
            HStack {
                Text("amount:")
                    .font(.system(size: 16))
                Text("\(malt.amount.value, specifier: "%g") \(malt.amount.unit)")
                    .foregroundColor(.gray)
                    .font(.system(size: 16))
                
                Spacer()
                
                Button(action: {
                    self.malt.isUsed.toggle()
                }) {
                    Text(self.malt.isUsed ? "Used" : "Use")
                        .font(.headline)
                }
                .padding([.leading])
            }
        }
        .padding(8)
    }
}

struct MaltRow_Previews: PreviewProvider {
    
    static var previews: some View {
        MaltRow(malt: Beer.malt)
            .previewLayout(.sizeThatFits)
    }
}
