//
//  MaltDetail.swift
//  Brewery
//
//  Created by Cris Burlamaqui on 01/08/2020.
//  Copyright © 2020 Cris Burlamaqui. All rights reserved.
//

import SwiftUI

struct MaltsDetail: View {
    
    var malt: [Malt]
    
    var body: some View {
        Form {
            Section(header: Text("Malts")
                .font(.headline).italic()
                .foregroundColor(.primary)
                .padding([.top])) {
                    
                    List {
                        ForEach(0..<malt.count) { idx in
                            MaltRow(malt: self.malt[idx])
                        }
                    }
            }
        }
    }
}

struct MaltDetail_Previews: PreviewProvider {
    static var previews: some View {
        MaltsDetail(malt: [Beer.malt, Beer.malt, Beer.malt])
    }
}
