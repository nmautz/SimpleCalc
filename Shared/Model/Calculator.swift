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

enum CombineValueSymERROR : Error {
    case invalidoperatoruse
}

enum CombineError: Error {
    case general
}
enum ParenthesisError: Error {
    case general
}
enum BasicOperatorError: Error {
    case general
}
enum ExponentError: Error {
    case general
}
enum HelperError:Error{
    case general
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
                
                if !rawCommand.isEmpty{
                    rawCommand = [evaluateCommand()]
                    textCommand = getTextCommand()
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
        do {
            try nCommand = applyMacros(command: nCommand)
            try nCommand = evaluateParentheses(command: nCommand)
            try nCommand = combineValueSymbols(command: nCommand)
            try nCommand = evaluateExponets(command: nCommand)
            try nCommand = evaluateBasicOps(command: nCommand)
        }catch CombineValueSymERROR.invalidoperatoruse {
            return Symbol(display: "Invalid Operator Use Error", type: "ERROR")
        }catch CombineError.general {
            return Symbol(display: "Combine Error", type: "ERROR")
        }catch ParenthesisError.general {
            return Symbol(display: "Parenthesis Error", type: "ERROR")
        }catch BasicOperatorError.general {
            return Symbol(display: "Operator Error", type: "ERROR")
        }catch ExponentError.general {
            return Symbol(display: "Exponent Error", type: "ERROR")
        }catch{
            return Symbol(display: "ERROR", type: "ERROR")
        }
        
        return nCommand[0]

        

        
    }
    
    private func applyMacros(command: [Symbol]) throws -> [Symbol]{
        
        var nCommand = command
        
        for i in nCommand.startIndex..<nCommand.endIndex
        {
            if i != 0{
                
                if nCommand[i].display == "(" && nCommand[i-1].type == "value"
                {
                    
                    nCommand.insert(Symbol(display: "*", type: "operator"), at: i)
                    
                    
                    
                }
                
                
            }
            
            
            
        }
        
        
        
        return nCommand
    }
    
    

    private func combineValueSymbols(command: [Symbol]) throws -> [Symbol]{
        

        
        var nCommand = command
        
        do{
            
            var endIndex = nCommand.endIndex
            var index = 0
            
            while index < endIndex
            {
                if !(index-1 < 0) {
                    
                    if nCommand[index-1].display == "-" && nCommand[index].type == "value"{
                        
                        if index-2 >= 0 && nCommand[index-2].display == "."{
                            throw CombineValueSymERROR.invalidoperatoruse
                        }
                        
                        if nCommand[index].display == "."{
                            throw CombineValueSymERROR.invalidoperatoruse
                        }else{
                            if index-1 == 0 || (index-2 != 0 && nCommand[index-2].type != "value"){
                                nCommand[index].value! *= -1
                                nCommand[index].display = String(nCommand[index].value!)
                                nCommand.remove(at: index-1)
                                index = index-1
                                endIndex = nCommand.endIndex
                                
                            }
                        }
                    }
                }
                
                index+=1
                
            }
            
            
            
            
            for i in nCommand.startIndex...nCommand.endIndex-1 {
                
                if nCommand[i].type == "value" || nCommand[i].type == "decimal"{
                    
                    
 
                    
                    
                    if !(i+1 > nCommand.endIndex-1){
                        if nCommand[i+1].type == "value" || nCommand[i+1].type == "decimal"{
                            let start = i
                            var values: [Symbol] = []
                            var end = -1
                            values.append(nCommand[i])
                            for j in i+1...nCommand.endIndex-1{
                                
                                if nCommand[j].type == "value" || nCommand[j].type == "decimal"{
                                    values.append(nCommand[j])
                                }else{
                                    end = j-1
                                    break
                                    
                                }
                                
                                
                            }
                            if end == -1{
                                end = nCommand.endIndex-1
                            }
                            
                            let result = try doCombine(command: values)
                            
                            
                            nCommand.replaceSubrange(start...end, with: [result])
                            
                            return try combineValueSymbols(command: nCommand)
                            
                            
                            
                            
                            
                        }
                    }
                    
                }
                
                
            }
        }
        

        
        
        return nCommand
    }
    private func doCombine(command: [Symbol])throws  -> Symbol{
        

        
        var values = command
        
        var total: Double = 0.0
        var decIndex: Int = values.endIndex
        for i in values.startIndex ..< values.endIndex
        {
            if values[i].display == "."{
                decIndex = i
                break
            }
        }
        
        var negative: Bool = false
        for i in values.startIndex..<values.endIndex{
            
            if i != decIndex{
                if values[i].value == nil {
                    throw CombineError.general
                }
                if values[i].value! < 0{
                    negative = true
                    values[i].value = abs(values[i].value!)
                }
                
                if i < decIndex{
                    total += (values[i].value! * pow(10, Double((decIndex-1)-i)))
                }else{
                    total += (values[i].value! * pow(10, Double((decIndex)-i)))
                }
                
                
                        
            }
        }
        
        if negative {
            total *= -1
        }
        
        return Symbol(display: String(total), type: "value", value: total)
    }
       
    
    private func evaluateBasicOps(command: [Symbol])throws -> [Symbol]
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
        
        if opIndex <= 0 || opIndex >= command.endIndex-1{
            throw BasicOperatorError.general
        }
        
        if command[opIndex-1].value == nil || command[opIndex+1].value == nil {
            throw BasicOperatorError.general
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
        return try evaluateBasicOps(command: nCommand)
        
    }
    
    
    
    private func evaluateExponets(command: [Symbol])throws ->[Symbol]{
        

        
        
        var nCommand = command
        
        for i in 0..<nCommand.endIndex{
            
            if nCommand[i].display == "^"{
                
                if i <= 0 || i >= nCommand.endIndex-1{
                    throw ExponentError.general
                }
                
                if nCommand[i-1].value == nil || nCommand[i+1].value == nil{
                    throw ExponentError.general
                }
                
                let v1 = nCommand[i-1].value!
                let v2 = nCommand[i+1].value!
                
                let result = pow(v1, v2)
                
                nCommand.replaceSubrange(i-1...i+1, with: [Symbol(display: String(result), type: "value", value: result)])
                
                return try evaluateExponets(command: nCommand)
                
                
                
            }
            
            
            
        }
        
        return command
    }
    
    
    
    private func getParEndIndex(command: [Symbol], startIndex: Int)throws -> Int
    {

        
        var pCount = 1
        
        if startIndex+1 > command.endIndex-1 {
            throw HelperError.general
        }
        
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
    private func evaluateParentheses(command: [Symbol]) throws -> [Symbol]{
        
        
        

        
        var nCommand = command
        
        for i in nCommand.startIndex..<nCommand.endIndex {
            if !(i >= nCommand.endIndex-1) {
                
                if nCommand[i].display == ")" {
                    if nCommand[i+1].type == "value"{
                        throw ParenthesisError.general
                    }
                }
                
                
            }
        }
        
        
        for i in nCommand.startIndex...nCommand.endIndex-1 {
            
            if(nCommand[i].display == "("){
                let endIndex = try getParEndIndex(command: nCommand, startIndex: i)
                let startIndex = i
                
                if startIndex+1 > endIndex-1 {
                    throw ParenthesisError.general
                }
                let pCommand: [Symbol] = Array(nCommand[(startIndex+1)...(endIndex-1)])
                
                let simplified = evaluateCommand(command: pCommand)
                
                nCommand.replaceSubrange(startIndex...endIndex, with: [simplified])
                
                return [evaluateCommand(command: nCommand)]
                
            }
            
        }
        

        return command
        
        
    }

    
    
    
}


