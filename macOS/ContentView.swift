//
//  ContentView.swift
//  Simple Calculator (macOS)
//
//  Created by Nathan Mautz on 2/23/22.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject private var calc:Calculator
    
    var body: some View {
        VStack{
            CalculatorDisplay()
                .environmentObject(calc)
                .scaledToFit()
                .padding(.all, 20)
            Divider().frame(height:20)
            CalculatorButtons()
                .environmentObject(calc)
                .scaledToFit()

        }
        .scaledToFit()
    
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
