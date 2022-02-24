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
    
    
    var widthMult = 1.0
    var heightMult = 1.0
    
    
    
    var body: some View {
        Button{
            calc.addCommandSymbol(symbol: symbol)
        }label: {
                       

            #if os(macOS)
            Text(symbol.display)
                .font(.title)
                .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                .scaledToFill()
                .frame(width: 50*widthMult, height: 100*heightMult, alignment: .center)
            #endif
            #if os(iOS)
            Text(symbol.display)
                .font(.title)
                .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                .scaledToFit()
                .background(Color(hue: 1.0, saturation: 0.021, brightness: 0.894))
                .cornerRadius(35)
                .frame(minWidth: 0, idealWidth: widthMult*100, maxWidth: widthMult*200, minHeight: 0, idealHeight: heightMult*100, maxHeight: heightMult*200)
            #endif
                
        }
        
    }
}

struct CalculatorButton_Previews: PreviewProvider {
    static var previews: some View {
        let calc: Calculator = Calculator()
        CalculatorButton(symbol: Symbol(display: "5", type: "value"), widthMult: 1)
            .environmentObject(calc)
.previewInterfaceOrientation(.portrait)
    }
    
}
