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
        
        VStack(spacing: 1){
            
            
            HStack(spacing: 1){


                CalculatorButton(symbol: Symbol(display: "CLR", type: "action"), widthMult: 4)
                    .environmentObject(calc)

            }
            HStack(spacing: 1){
                //Exponent Placeholder
                CalculatorButton(symbol: Symbol(display: "^", type: "operator"))
                    .environmentObject(calc)

                CalculatorButton(symbol: Symbol(display: "(", type: "parentheses"))
                    .environmentObject(calc)
                CalculatorButton(symbol: Symbol(display: ")", type: "parentheses"))
                    .environmentObject(calc)
                CalculatorButton(symbol: Symbol(display: "*", type: "operator"))
                    .environmentObject(calc)

            }
            
            HStack(spacing: 1){
                CalculatorButton(symbol: Symbol(display: "1", type: "value", value: 1))
                    .environmentObject(calc)
                CalculatorButton(symbol: Symbol(display: "2", type: "value", value: 2))
                    .environmentObject(calc)
                CalculatorButton(symbol: Symbol(display: "3", type: "value", value: 3))
                    .environmentObject(calc)
                CalculatorButton(symbol: Symbol(display: "/", type: "operator"))
                    .environmentObject(calc)

            }
            HStack(spacing: 1){
                CalculatorButton(symbol: Symbol(display: "4", type: "value", value: 4))
                    .environmentObject(calc)
                CalculatorButton(symbol: Symbol(display: "5", type: "value", value: 5))
                    .environmentObject(calc)
                CalculatorButton(symbol: Symbol(display: "6", type: "value", value: 6))
                    .environmentObject(calc)
                CalculatorButton(symbol: Symbol(display: "+", type: "operator"))
                    .environmentObject(calc)

            }
            HStack(spacing: 1){
                CalculatorButton(symbol: Symbol(display: "7", type: "value", value: 7))
                    .environmentObject(calc)
                CalculatorButton(symbol: Symbol(display: "8", type: "value", value: 8))
                    .environmentObject(calc)
                CalculatorButton(symbol: Symbol(display: "9", type: "value", value: 9))
                    .environmentObject(calc)

                CalculatorButton(symbol: Symbol(display: "-", type: "operator"))


            }

            HStack(spacing: 1){
                CalculatorButton(symbol: Symbol(display: "0", type: "value", value: 0))
                    .environmentObject(calc)
                
                CalculatorButton(symbol: Symbol(display: ".", type: "decimal"))
                    .environmentObject(calc)
                CalculatorButton(symbol: Symbol(display: "=", type: "action"))
                    .environmentObject(calc)
                

            }
            
        }
    }
}

struct CalculatorButtons_Previews: PreviewProvider {
    static var previews: some View {
        
        let calc: Calculator = Calculator()
        
        CalculatorButtons()
            .environmentObject(calc)
.previewInterfaceOrientation(.portrait)
    }
}
