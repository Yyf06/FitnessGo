//
//  GameViewControllerRepresentable.swift
//  FitnessGo
//
//  Created by Jiayi on 15/9/2024.
//

import SwiftUI
import UIKit
import SpriteKit

// A SwiftUI wrapper for the UIKit-based GameViewController, allowing it to be used in SwiftUI
struct GameViewControllerRepresentable: UIViewControllerRepresentable {
    
    // Observed object to track changes in game state
    @ObservedObject var gameState: GameStateManager
    var spinItemsModel: SpinItemsModel
    var checkboxModel: CheckboxModel
    var globalEnv: GlobalEnvironment
    
    // Creates and configures the GameViewController, which is a UIKit view controller
    func makeUIViewController(context: Context) -> GameViewController {
        
        let controller = GameViewController()
        
        // Pass SwiftUI state and models into the UIKit view controller
        controller.gameState = gameState
        controller.spinItemsModel=spinItemsModel
        controller.checkBoxModel = checkboxModel
        controller.globalEnv = globalEnv
        return controller
    }
    
    // Updates the GameViewController when the SwiftUI view changes
    func updateUIViewController(_ uiViewController: GameViewController, context: Context) {
        // Leave this empty if there's no need to update your UIViewController
    }
}

