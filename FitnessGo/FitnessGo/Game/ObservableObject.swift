//
//  ObservableObject.swift
//  FitnessGo
//
//  Created by Jiayi on 17/9/2024.
//

import Foundation
import SwiftUI
import Combine

// GameStateManager class to manage the state of the game
class GameStateManager: ObservableObject {
    
    // Published properties will automatically notify views when changed
    @Published var gameIsRunning: Bool = false // Whether the game is currently running
    @Published var gameIsActive: Bool = true // Whether the game is active or stop
    @Published var gameWon: Bool = true // if game is win or lose
    func runGame() {
            gameIsRunning = true // set game is running
            
        }
}

