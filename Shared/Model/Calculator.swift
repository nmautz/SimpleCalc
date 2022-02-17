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
        
        if(symbol.type == "action")
        {
            if(symbol.display == "CLR"){
                rawCommand = []
            }
            if(symbol.display == "="){
                evaluateCommand()
            }
        }else {
            rawCommand.append(symbol)
        }
        textCommand = getTextCommand()
        
    }
    
    public func getTextCommand()->String{
        
        var str: String = ""
        
        for symbol in rawCommand{
            
            str = str + symbol.display
        
        }

        return str
    }
    
    
    public func evaluateCommand()->String{
        
        
        var expression = evaluateCommand(command: rawCommand)
        
        textCommand = getTextCommand()
        
        return textCommand
    }
    
    
    
    
    private func evaluateCommand(command: [Symbol])->Symbol{
        
        

    
        
        return Symbol(display: "Replace", type: "Me")
    }
    
    
    private func parenthesesCommand(pCommand: [Symbol]) -> [Symbol]{
        
        var nCommand: [Symbol] = pCommand
        
        for i in 0...pCommand.endIndex {
            
            if pCommand[i].display == "(" {
                var simplified = parenthesesCommand(pCommand: nCommand, pStartIndex: i)
                
            }
            
            
        }
        
        return nCommand
        
        
    }
    
    private func parenthesesCommand(pCommand: [Symbol], pStartIndex: Int)->Symbol
    {
        var pCount = 1
        var buffer: [Symbol] = []
        
        for i in pStartIndex...pCommand.endIndex{
            if pCommand[i].display == "(" {
                pCount+=1
            }else if pCommand[i].display == ")" {
                pCount -= 1
            }else{
                buffer.append(pCommand[i])
            }
            
            if pCount == 0 {
                return evaluateCommand(command: buffer)
            }
            
            
            
            
        }
        return Symbol(display: "ERROR", type: "ERROR")
        
    }
    
    
    
    
    
    
    
    
    
}


