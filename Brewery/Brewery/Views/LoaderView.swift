//
//  Loader.swift
//  Brewery
//
//  Created by Cris Burlamaqui on 31/07/2020.
//  Copyright © 2020 Cris Burlamaqui. All rights reserved.
//

import SwiftUI

struct LoaderView: View {
    
    @Environment(\.colorScheme) var colorScheme
    @State var animate = false
    
    var body: some View {
        
        VStack {
            Circle()
                .trim(from: 0.1, to: 0.9)
                .stroke(AngularGradient(gradient: Gradient(colors: [.white, .gray, .black]), center: .center), style: StrokeStyle(lineWidth: 5, lineCap: .round))
                .frame(width: 45, height: 45)
                .rotationEffect(.init(degrees: self.animate ? 360 : 0))
                .animation(Animation.linear(duration: 0.8).repeatForever(autoreverses: false))
            
            Text("Loading...")
                .foregroundColor(.black)
        }
        .padding()
        .background(Color.white)
        .cornerRadius(15)
        .shadow(color: colorScheme == .dark ? .white : .gray, radius: 10)
        .onAppear {
            self.animate.toggle()
        }
    }
}

struct Loader_Previews: PreviewProvider {
    static var previews: some View {
            LoaderView()
                .previewLayout(.sizeThatFits)
            
    }
}
