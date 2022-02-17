//
//  CalculatorButtons.swift
//  Simple Calculator
//
//  Created by Nathan Mautz on 2/16/22.
//

import SwiftUI

struct CalculatorButtons: View {
    
    @EnvironmentObject var calc:Calculator
    
    
    var body: some View {
        
        VStack{
            
            
            HStack{
                
                CalculatorButton(symbol: Symbol(display: "*", type: "operator"))
                    .environmentObject(calc)
                CalculatorButton(symbol: Symbol(display: "/", type: "operator"))
                    .environmentObject(calc)
                CalculatorButton(symbol: Symbol(display: "CLR", type: "action"))
                    .environmentObject(calc)
            }
            
            HStack{
                CalculatorButton(symbol: Symbol(display: "1", type: "value"))
                    .environmentObject(calc)
                CalculatorButton(symbol: Symbol(display: "2", type: "value"))
                    .environmentObject(calc)
                CalculatorButton(symbol: Symbol(display: "3", type: "value"))
                    .environmentObject(calc)
                CalculatorButton(symbol: Symbol(display: "+", type: "operator"))
                    .environmentObject(calc)
            }
            HStack{
                CalculatorButton(symbol: Symbol(display: "4", type: "value"))
                    .environmentObject(calc)
                CalculatorButton(symbol: Symbol(display: "5", type: "value"))
                    .environmentObject(calc)
                CalculatorButton(symbol: Symbol(display: "6", type: "value"))
                    .environmentObject(calc)
                CalculatorButton(symbol: Symbol(display: "-", type: "operator"))
            }
            HStack{
                CalculatorButton(symbol: Symbol(display: "7", type: "value"))
                    .environmentObject(calc)
                CalculatorButton(symbol: Symbol(display: "8", type: "value"))
                    .environmentObject(calc)
                CalculatorButton(symbol: Symbol(display: "9", type: "value"))
                    .environmentObject(calc)
                CalculatorButton(symbol: Symbol(display: "=", type: "action"))
            }
            
        }
    }
}

struct CalculatorButtons_Previews: PreviewProvider {
    static var previews: some View {
        CalculatorButtons()
    }
}
