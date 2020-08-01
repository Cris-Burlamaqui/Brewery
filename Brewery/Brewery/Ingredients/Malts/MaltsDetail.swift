//
//  MaltDetail.swift
//  Brewery
//
//  Created by Cris Burlamaqui on 01/08/2020.
//  Copyright © 2020 Cris Burlamaqui. All rights reserved.
//

import SwiftUI

struct MaltsDetail: View {
    
    var malts: [Malt]
    
    var body: some View {
        
        Form {
            Section {
                    List {
                        ForEach(0..<malts.count) { idx in
                            MaltRow(malt: self.malts[idx])
                        }
                    }
            }
            .navigationBarTitle(Text("Malts"), displayMode: .inline)
        }
    }
}

struct MaltDetail_Previews: PreviewProvider {
    static var previews: some View {
        MaltsDetail(malts: [Beer.malt, Beer.malt, Beer.malt])
    }
}
