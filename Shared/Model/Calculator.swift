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
    
    
    public func evaluateCommand()-> Symbol{
        
        let result = evaluateCommand(command: rawCommand)
        
        return result
    }
    
    
    
    
    private func evaluateCommand(command: [Symbol])->Symbol{
        
        var nCommand = command
        
        nCommand = parenthesesCommand(command: nCommand)

        
        return Symbol(display: "Replace", type: "Me")
    }
    
    
    
    
    private func getParEndIndex(command: [Symbol], startIndex: Int) -> Int
    {
        
        var pCount = 1
        
        for i in startIndex+1...command.endIndex{
            
            if command[i].display == "(" {
                pCount += 1
            }else if command[i].display == ")"{
                pCount -= 1
            }
            
            if(pCount == 0){
                
                return i
            }
            
            
        }
        
        
        
        return -1
    }
    
    
    
    //Returns command free of ()
    private func parenthesesCommand(command: [Symbol]) -> [Symbol]{
        
        var nCommand = command
        
        
        for i in nCommand.startIndex...nCommand.endIndex {
            
            if(nCommand[i].display == "("){
                let endIndex = getParEndIndex(command: nCommand, startIndex: i)
                let startIndex = i
                
                let pCommand: [Symbol] = Array(nCommand[(startIndex+1)...(endIndex-1)])
                
                let simplified = evaluateCommand(command: pCommand)
                
                nCommand.replaceSubrange(startIndex...endIndex, with: [simplified])
                
                return nCommand
                
            }
    
            
        }
        

        return command
        
        
    }

    
    
    
}


