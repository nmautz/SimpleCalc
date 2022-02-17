//
//  CalculatorButton.swift
//  Simple Calculator
//
//  Created by Nathan Mautz on 2/16/22.
//

import SwiftUI

extension UIScreen{
   static let screenWidth = UIScreen.main.bounds.size.width
   static let screenHeight = UIScreen.main.bounds.size.height
   static let screenSize = UIScreen.main.bounds.size
}

struct CalculatorButton: View {
    
    @State var symbol: Symbol
    @EnvironmentObject var calc:Calculator
    
    
    
    var body: some View {
        Button{
            calc.addCommandSymbol(symbol: symbol)
        }label: {
                       
            Text(symbol.display)
                .font(.title)
                .frame(width: UIScreen.screenWidth / 5, height: UIScreen.screenHeight / 10)
                .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                .background(/*@START_MENU_TOKEN@*//*@PLACEHOLDER=View@*/Color(hue: 1.0, saturation: 0.021, brightness: 0.894)/*@END_MENU_TOKEN@*/)
                .scaledToFit()
                
        }
        
    }
}

struct CalculatorButton_Previews: PreviewProvider {
    static var previews: some View {
        let calc: Calculator = Calculator()
        CalculatorButton(symbol: Symbol(display: "5", type: "value"))
            .environmentObject(calc)
    }
    
}
