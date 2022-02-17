//
//  Calculator.swift
//  Simple Calculator
//
//  Created by Nathan Mautz on 2/16/22.
//

import Foundation
import SwiftUI


struct Symbol{
    
    var display: String
    var type: String
    
}


final class Calculator : ObservableObject
{    
    private var rawCommand: [Symbol] = []
    
    @Published var textCommand: String = ""
    
    public func addCommandSymbol(symbol:Symbol){
        
        rawCommand.append(symbol)
        textCommand = getTextCommand()
        
    }
    
    public func getTextCommand()->String{
        
        var str: String = ""
        
        for symbol in rawCommand{
            
            str = str + symbol.display
        
        }

        return str
    }
    
    
    
    
    
    
    
}


