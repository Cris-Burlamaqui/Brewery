//
//  MethodDetail.swift
//  Brewery
//
//  Created by Cris Burlamaqui on 01/08/2020.
//  Copyright © 2020 Cris Burlamaqui. All rights reserved.
//

import SwiftUI

struct MethodDetail: View {
    
    @ObservedObject var method: Method
    
    var body: some View {
        Form {
            Section(header: Text("Mash temperature").font(.headline).padding([.top])) {
                VStack {
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
                            .padding([.bottom])
                        }
                    }
                    
                    Button(action: {
                        self.method.mashIsApplied.toggle()
                    }) {
                        Text(self.method.mashIsApplied ? "Applied" : "Apply")
                    }
                    .padding([.bottom])
                }
            }
            
            Section(header: Text("Fermentation").font(.headline)) {
                VStack {
                    HStack {
                        Text("Temperature:")
                        Text("\(method.fermentation.value) \(method.fermentation.unit)")
                        Spacer()
                        Button(action: {
                            self.method.fermentationIsApplied.toggle()
                        }) {
                            Text(self.method.fermentationIsApplied ? "Applied" : "Apply")
                        }
                        .padding([.leading])
                    }
                }
            }
            
            Section(header: Text("Twist").font(.headline)) {
                HStack {
                    Text("\(method.twist ?? "Method not applied.")")
                    
                    
                    if method.twist != nil {
                        Spacer()
                        Button(action: {
                            self.method.twistApplied.toggle()
                        }) {
                            Text(self.method.twistApplied ? "Applied" : "Apply")
                        }
                        .padding([.leading])
                    }
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
