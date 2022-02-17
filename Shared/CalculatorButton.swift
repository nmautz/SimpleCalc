//
//  CalculatorButton.swift
//  Simple Calculator
//
//  Created by Nathan Mautz on 2/16/22.
//

import SwiftUI

struct CalculatorButton: View {
    
    @State var symbol: Symbol
    @EnvironmentObject var calc:Calculator
    
    
    
    var body: some View {
        Button{
            calc.addCommandSymbol(symbol: symbol)
        }label: {
            Text(symbol.display)
        }
        
    }
}

struct CalculatorButton_Previews: PreviewProvider {
    static var previews: some View {
        CalculatorButton(symbol: Symbol(display: "5", type: "value"))
    }
}
