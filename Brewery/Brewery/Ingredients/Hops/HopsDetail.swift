//
//  HopsDetail.swift
//  Brewery
//
//  Created by Cris Burlamaqui on 01/08/2020.
//  Copyright © 2020 Cris Burlamaqui. All rights reserved.
//

import SwiftUI

struct HopsDetail: View {
    
    var hops: [Hop]
    
    var body: some View {
        Form {
            Section {
                    
                    List {
                        ForEach(0..<hops.count) { idx in
                            HopRow(hop: self.hops[idx])
                        }
                    }
            }
            .navigationBarTitle(Text("Hops"), displayMode: .inline)
        }
    }
}

struct HopsDetail_Previews: PreviewProvider {
    static var previews: some View {
        HopsDetail(hops: [Beer.hop, Beer.hop, Beer.hop, Beer.hop])
    }
}
