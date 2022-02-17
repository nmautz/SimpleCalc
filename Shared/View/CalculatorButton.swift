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
    
    
    var widthMult = 1.0
    var heightMult = 1.0
    
    
    
    var body: some View {
        Button{
            calc.addCommandSymbol(symbol: symbol)
        }label: {
                       
            Text(symbol.display)
                .font(.title)
                .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                .scaledToFill()
                .frame(minWidth: 50, idealWidth: widthMult*100, maxWidth: widthMult*200, minHeight: 50, idealHeight: heightMult*100, maxHeight: heightMult*200)
                .background(Color(hue: 1.0, saturation: 0.021, brightness: 0.894))
                .cornerRadius(35)
                
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
