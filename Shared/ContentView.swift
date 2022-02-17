//
//  ContentView.swift
//  Shared
//
//  Created by Nathan Mautz on 2/16/22.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var calc:Calculator
    
    var body: some View {
        VStack{
            
            CalculatorDisplay()
                .environmentObject(calc)
            CalculatorButtons()
                .environmentObject(calc)
        }
    }
        
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
