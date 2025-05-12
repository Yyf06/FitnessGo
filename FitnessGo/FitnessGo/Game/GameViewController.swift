//
//  GameViewController.swift
//  FitnessGo
//
//  Created by Jiayi on 14/9/2024.
//



import UIKit
import SpriteKit
import GameplayKit

// main cotroller for game scene, manage game states and scene
class GameViewController: UIViewController {
    var gameState: GameStateManager?
    var spinItemsModel: SpinItemsModel?
    var checkBoxModel: CheckboxModel?
    var globalEnv: GlobalEnvironment?
    var audioPlayer: AudioPlayerClass?
    
    // overide to set up as a SKView, with SpriteKit content
    override func loadView() {
        // Create an SKView instance
        let skView = SKView(frame: UIScreen.main.bounds)
        self.view = skView
    }
    
    // Called after the view has been loaded into memory
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        if let view = self.view as! SKView? {
            // Load the SKScene from 'GameScene.sks'
            if let scene = GameScene(fileNamed: "GameScene") {
                // Set the scale mode to scale to fit the window
                
                
            
                scene.scaleMode = .aspectFill
                scene.gameState = gameState
                scene.spinItemsModel=spinItemsModel
                scene.checkboxModel = checkBoxModel
                scene.globalEnv = globalEnv
                // Present the scene
                view.presentScene(scene)
                
                // Play a cheering sound when the scene is presented
                audioPlayer?.playCheeringSound()
            }
            
            view.ignoresSiblingOrder = true
            
            view.showsFPS = true
            view.showsNodeCount = true
        }
    }
    
    
    // Define supported orientations for the game based on the device type
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

    // Hide the status bar during gameplay
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    
}

