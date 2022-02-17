//
//  Simple_CalculatorApp.swift
//  Shared
//
//  Created by Nathan Mautz on 2/16/22.
//

import SwiftUI

@main
struct Simple_CalculatorApp: App {
    
    @StateObject private var calc = Calculator()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(calc)
            
        }
    }
}


