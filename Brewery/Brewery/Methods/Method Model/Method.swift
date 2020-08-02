//
//  Method.swift
//  Brewery
//
//  Created by Cris Burlamaqui on 28/07/2020.
//  Copyright © 2020 Cris Burlamaqui. All rights reserved.
//

import Foundation

class Method: ObservableObject {
    
    @Published var twistApplied = false
    @Published var fermentationIsApplied = false
    @Published var mashIsApplied = false
    
    @Published var mash_temp: [Temperature]
    var fermentation: TempItem
    var twist: String?
    
    init(mash: [Temperature], fermentation: TempItem, twist: String?) {
        self.mash_temp = mash
        self.fermentation = fermentation
        self.twist = twist
    }
    
    class Temperature: ObservableObject {
        
        var temp: TempItem
        var duration: Int?
        
        init(temp: TempItem, duration: Int?) {
            self.temp = temp
            self.duration = duration
        }
    }
    
    class TempItem: ObservableObject {
        
        var value: Int
        var unit: String
        init(value: Int, unit: String) {
            self.value = value
            self.unit = unit
        }
    }
}




