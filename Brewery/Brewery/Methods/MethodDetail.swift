//
//  MethodDetail.swift
//  Brewery
//
//  Created by Cris Burlamaqui on 01/08/2020.
//  Copyright © 2020 Cris Burlamaqui. All rights reserved.
//

import SwiftUI

struct MethodDetail: View {
    
    var method: Method
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Mash temperature").font(.headline).padding([.top])) {
                    List {
                        ForEach(0..<method.mash_temp.count) { idx in
                            VStack(spacing: 10) {
                                HStack {
                                    Text("temperature:")
                                    Spacer()
                                    Text("\(self.method.mash_temp[idx].temp.value) \(self.method.mash_temp[idx].temp.unit)")
                                }
                                HStack {
                                    Text("duration:")
                                    Spacer()
                                    Text("\(self.method.mash_temp[idx].duration ?? 0)")
                                }
                            }
                        }
                    }
                }
                
                Section(header: Text("Fermentation").font(.headline)) {
                    HStack {
                        Text("Temperature:")
                        Spacer()
                        Text("\(method.fermentation.temp.value) \(method.fermentation.temp.unit)")
                    }
                }
                
                Section(header: Text("Twist").font(.headline)) {
                    Text("\(method.twist ?? "Method not used.")")
                }
            }
            .navigationBarTitle(Text("Method"), displayMode: .inline)
        }
    }
}

struct MethodDetail_Previews: PreviewProvider {
    
    static var previews: some View {
        MethodDetail(method: Beer.method)
    }
}
