//
//  Expression.swift
//  Simple Calculator
//
//  Created by Nathan Mautz on 2/16/22.
//

import Foundation
import UIKit

class Expression{
    
    var v1:Symbol = Symbol(display: "ERROR", type: "ERROR")
    var v2: Symbol = Symbol(display: "ERROR", type: "ERROR")
    var op:Symbol = Symbol(display: "ERROR", type: "ERROR")
    
    public init(v1:Symbol, v2:Symbol, op:Symbol){
        
        if(v1.type == "value" && v2.type == "value" && op.type == "operator")
        {
            self.v1 = v1
            self.v2 = v2
            self.op = op
        }
        
    }
    
    
    
    
    
    
    
    
    
}
