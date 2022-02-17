//
//  CalculatorDisplay.swift
//  Simple Calculator
//
//  Created by Nathan Mautz on 2/16/22.
//

import SwiftUI

struct CalculatorDisplay: View {
    
    @EnvironmentObject var calc:Calculator
    
    var body: some View {
        Text(calc.textCommand)
        Divider()
    }
}

struct CalculatorDisplay_Previews: PreviewProvider {
    static var previews: some View {
        CalculatorDisplay()
    }
}
