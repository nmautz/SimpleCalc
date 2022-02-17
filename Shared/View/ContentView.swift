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
        VStack(){
            Divider().frame(height:20)
            CalculatorDisplay()
                .environmentObject(calc)
                .scaledToFit()
                .padding(.all, 20)
            Divider().frame(height:20)
            Spacer()
            CalculatorButtons()
                .environmentObject(calc)
                .padding(.all, 20)
        }

    }
        
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let calc: Calculator = Calculator()
        ContentView()
            .environmentObject(calc)
.previewInterfaceOrientation(.landscapeLeft)
    }
}
