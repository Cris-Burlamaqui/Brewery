//
//  NoSolutionView.swift
//  Brewery
//
//  Created by Cris Burlamaqui on 02/08/2020.
//  Copyright © 2020 Cris Burlamaqui. All rights reserved.
//

import SwiftUI

struct NoSolutionView: View {
    
    @Environment(\.colorScheme) var colorScheme
    var message: String
    
    var body: some View {
        
        VStack {
            Image(colorScheme == .dark ? "sad_white" : "sad_black")
                .resizable()
                .frame(width: 70, height: 70)
            
            Text(message)
                .font(.headline)
                .padding()
                .foregroundColor(.primary)
            
        }
        .padding([.top], 50)
    }
}

struct NoSolutionView_Previews: PreviewProvider {
    static var previews: some View {
        
        NoSolutionView(message: "No solution found!")
        .previewLayout(.sizeThatFits)
    }
}
