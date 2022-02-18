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
    var value: Double? = nil
    
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
            if(symbol.display == "+/-"){
                
                if(rawCommand[rawCommand.endIndex-1].type == "value"){
                    
                    
                    if rawCommand[rawCommand.endIndex-1].display.contains("-"){
                        
                        rawCommand[rawCommand.endIndex-1].display.removeFirst()
                        
                    }else{
                        rawCommand[rawCommand.endIndex-1].display = "-" + rawCommand[rawCommand.endIndex-1].display
                    }
                    
                    rawCommand[rawCommand.endIndex-1].value! *= -1
                }
                
                
                
                
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
        
        let result: Symbol = self.evaluateCommand(command: self.rawCommand)
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
                        
                        let result = doCombine(values: values)
                        
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
        
        
        var total: Double = 0.0
        
        var decIndex: Int = values.endIndex
        for i in values.startIndex ..< values.endIndex
        {
            if values[i].display == "."{
                decIndex = i
                break
            }
        }
        
        
        for i in values.startIndex..<values.endIndex{
            
            if i != decIndex{
                
                if i < decIndex{
                    total += (values[i].value! * pow(10, Double((decIndex-1)-i)))
                }else{
                    total += (values[i].value! * pow(10, Double((decIndex)-i)))
                }
                
                
                        
            }
        }
        
        
        return Symbol(display: String(total), type: "value", value: total)
    }
       
    
    private func evaluateBasicOps(command: [Symbol]) -> [Symbol]
    {
        
        
        if command.count <= 1 {
            return command
        }
        
        //Get operator
        
        var opIndex = -1
        
        for i in command.startIndex..<command.endIndex{
            
            if command[i].display == "/" || command[i].display == "*"
            {
                opIndex = i
                break
            }else if opIndex == -1{
                
                if command[i].display == "+" || command[i].display == "-"
                {
                    opIndex = i
                }
            }
        }
        
        //Get left and right values
        let v1: Double = command[opIndex-1].value!
        let v2: Double = command[opIndex+1].value!
        let op: String = command[opIndex].display
        var result: Double
        
        switch op {
        case "*":
            result = v1 * v2
        case "/":
            result = v1 / v2
        case "+":
            result = v1 + v2
        case "-":
            result = v1 - v2
        default:
            result = 0
        }
        
        
        let resultSymbol:Symbol = Symbol(display: String(result), type: "value", value: result)
        
        var nCommand = command
        
        nCommand.replaceSubrange(opIndex-1...opIndex+1, with: [resultSymbol])
        return evaluateBasicOps(command: nCommand)
        
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


