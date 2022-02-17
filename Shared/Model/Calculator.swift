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


struct SymbolRange{
    var values: [Symbol]
    var start: Int
    var end: Int
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
                rawCommand = [evaluateCommand()]
                textCommand = getTextCommand()
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
        
        nCommand = combineValueSymbols(command: nCommand)
        nCommand = evaluateParentheses(command: nCommand)
        nCommand = evaluateExponets(command: nCommand)
        nCommand = evaluateBasicOps(command: nCommand)
        
        return nCommand[0]
    }
    
    
    private func combineValueSymbols(command: [Symbol]) -> [Symbol]{
        
        for i in command.startIndex...command.endIndex-1 {
            
            if command[i].type == "value"{
                
                if !(i+1 > command.endIndex-1){
                    if command[i+1].type == "value"{
                        let start = i
                        var values: [Symbol] = []
                        var end = -1
                        values.append(command[i])
                        for j in i+1...command.endIndex-1{
                            
                            if command[j].type == "value"{
                                values.append(command[j])
                            }else{
                                end = j-1
                                break
                                
                            }
                            
                            
                        }
                        if end == -1{
                            end = command.endIndex-1
                        }
                        
                        var result = doCombine(values: values)
                        
                        var nCommand = command
                        nCommand.replaceSubrange(start...end, with: [result])
                        
                        return combineValueSymbols(command: nCommand)
                        
                        
                        
                        
                        
                    }
                }
                
            }
            
            
        }
        
        
        return command
    }
    private func doCombine(values: [Symbol]) -> Symbol{
        
        //TODO
        return Symbol(display: "TMP", type: "TMP")
    }
    
    
    private func evaluateBasicOps(command: [Symbol]) -> [Symbol]
    {
        
        //TODO
        
        return command
    }
    
    
    
    private func evaluateExponets(command: [Symbol])->[Symbol]{
        
        
        //TODO
        
        return command
    }
    
    
    
    private func getParEndIndex(command: [Symbol], startIndex: Int) -> Int
    {
        
        var pCount = 1
        
        for i in startIndex+1...command.endIndex-1{
            
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
    private func evaluateParentheses(command: [Symbol]) -> [Symbol]{
        
        var nCommand = command
        
        
        for i in nCommand.startIndex...nCommand.endIndex-1 {
            
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


