//
//  rungame.swift
//  FitnessGo
//
//  Created by Jiayi on 15/9/2024.
//

import Foundation
import SwiftUI
import SpriteKit

// Main view for the running game
struct RunGame: View {
    
    // State object to manage the game state
    @StateObject var gameState = GameStateManager()
    
    // Environment objects to share data between views: spinItemsModel, checkboxModel, and global environment
    @EnvironmentObject var spinItemsModel: SpinItemsModel
    @EnvironmentObject var checkboxModel: CheckboxModel
    @EnvironmentObject var globalEnv: GlobalEnvironment
    
    // Audio player instance to handle sound effects in the game
    let audioPlayer = AudioPlayerClass()
    
    // Defines the SpriteKit game scene to be presented in the view
        var scene: SKScene {
            
            let scene = GameScene(fileNamed: "GameScene")!
            scene.scaleMode = .resizeFill
      
            return scene
        }
        
    // Main body of the view
    var body: some View {
            Group {
                
                // Show the game view depends on if the game is active
                if gameState.gameIsActive {
                    GameViewControllerRepresentable(gameState: gameState,
                                                    spinItemsModel: spinItemsModel,
                                                    checkboxModel: checkboxModel,
                                                    globalEnv: globalEnv
                                                 )
                    
                    // Stop the sound when the game view disappears
                        .onDisappear {
                            audioPlayer.stopSound()
                        }
                } else {
                    
                    // jump to win or lose view when game is not active
                    if gameState.gameWon {
                        WinView(gameState: gameState)
                    } else {
                        GameOverView(gameState: gameState)
                    }
                }
            }
            .onChange(of: gameState.gameIsActive) { oldValue, newValue in
                        if !newValue {
                            audioPlayer.stopSound()
                        }
                    }
            .onAppear {
                audioPlayer.playRunningSound()
                
                // Delay playing the cheering sound by 2 seconds
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                               audioPlayer.playCheeringSound()
                           }
               
            }
            .onDisappear {
                audioPlayer.stopSound()
            }
        }
    }

