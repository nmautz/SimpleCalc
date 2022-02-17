//
//  ContentView.swift
//  Shared
//
//  Created by Nathan Mautz on 2/16/22.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject private var calc:Calculator
    
    var body: some View {
        VStack{
            
            CalculatorDisplay()
                .environmentObject(calc)
            Divider()
            CalculatorButtons()
                .environmentObject(calc)
                .scaledToFit()
        }
    }
        
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let calc: Calculator = Calculator()
        ContentView()
            .environmentObject(calc)
.previewInterfaceOrientation(.portrait)
    }
}