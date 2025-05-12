//
//  GameScene.swift
//  FitnessGo
//
//  Created by Jiayi on 15/9/2024.
//

import SpriteKit
import GameplayKit


class GameScene: SKScene{
    
    // use variable result from other model
    var gameState: GameStateManager?
    var gameResult: GameStateManager?
    
    var spinItemsModel: SpinItemsModel?
    var checkboxModel: CheckboxModel?
    var globalEnv: GlobalEnvironment?
    
    var stopEverything = true
    
    // set spritenode for each object
    var leftCar = SKSpriteNode()
    var rightCar = SKSpriteNode()
    var whiteLine1 = SKSpriteNode()
    var whiteLine2 = SKSpriteNode()
    var runner1 = SKSpriteNode()
  


    
    override func didMove(to view: SKView) {
    
        
        print("RUN GAME START")
        GameResult()
        
        // End game after 7 sec
        DispatchQueue.main.asyncAfter(deadline: .now() + 7) {
            self.endGame()
           
        }
        
        // set up the anchorPoints
        self.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        setup()
        animateRunner()
        animateRunnerLeft()
        
        // setup the clock timer for each objects
        Timer.scheduledTimer(timeInterval: TimeInterval(0.3), target: self, selector: #selector(GameScene.scheduleWhiteLineAppearance), userInfo: nil, repeats: false)
        Timer.scheduledTimer(timeInterval: (0.3), target: self, selector: #selector(GameScene.createRoadStrip), userInfo: nil, repeats: true)
        Timer.scheduledTimer(timeInterval: TimeInterval(0.5), target: self, selector: #selector(GameScene.leftTraffic), userInfo: nil, repeats: true)
        Timer.scheduledTimer(timeInterval: (0.8), target: self, selector: #selector(GameScene.rightTraffic), userInfo: nil, repeats: true)
        Timer.scheduledTimer(timeInterval: (0.5), target: self, selector: #selector(GameScene.running), userInfo: nil, repeats: true)
        
        
        
        
    }

    // schedule the finish line appears after 5 secs
    @objc func scheduleWhiteLineAppearance() {
        let wait = SKAction.wait(forDuration: 5)
        let addWhiteLines = SKAction.run {
            self.addWhiteLine()
        }
        run(SKAction.sequence([wait, addWhiteLines]))
    
    }
    // add finish line into the game scene
    @objc func addWhiteLine() {
        let whiteLineleft : SKSpriteNode!
        let whiteLineright : SKSpriteNode!
        
        // create leftline and rightline by using image whiteline
        whiteLineleft = SKSpriteNode(imageNamed: "whiteline")
        whiteLineright = SKSpriteNode(imageNamed: "whiteline")
        
        // set size and position
        whiteLineleft.size = CGSize(width: 230, height: 90)
        whiteLineright.size = CGSize(width: 230, height: 90)
        whiteLineleft.position.x = 78
        whiteLineright.position.x = -78 //position of endline
        whiteLineleft.position.y = 700
        whiteLineright.position.y = 700
        whiteLineleft.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        whiteLineright.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        whiteLineleft.zPosition = 10
        whiteLineright.zPosition = 10
        whiteLineleft.name="whitelinel"
        whiteLineright.name="whiteliner"
        
        // add whiteline as node in the game scene
        addChild(whiteLineleft)
        addChild(whiteLineright)

                
    }
    
   
    
    // set up the init object in the game scene
    func setup() {
        leftCar = self.childNode(withName: "leftCar") as! SKSpriteNode
        runner1 = self.childNode(withName: "runner1") as! SKSpriteNode
     
    }

    // Right runner animateion using sprite frames from tecture atlas
    func animateRunner() {
        let textureAtlas = SKTextureAtlas(named: "runnersprite1")
        var frames: [SKTexture] = []

        for i in 1...5 {
            let textureName = "runnersprite1_\(i)"
            if textureAtlas.textureNames.contains(textureName) {  // Check if texture exists in the atlas
                let frame = textureAtlas.textureNamed(textureName)
                frames.append(frame)
                print("Loaded frame: \(textureName)")  // Log each loaded frame
            } else {
                print("Error: \(textureName) not found in atlas")
            }
        }

        // Proceed with animation if frames are loaded correctly
        if !frames.isEmpty {
            let animation = SKAction.animate(with: frames, timePerFrame: 0.1, resize: false, restore: true)
            let repeatAnimation = SKAction.repeatForever(animation)
            runner1.run(repeatAnimation)
            print("Animation started")
        } else {
            print("Error: No frames loaded for animation")
        }
        
        
    }
    
    // Left runner animateion using sprite frames from tecture atlas
    func animateRunnerLeft() {
        if (self.checkboxModel?.isOn == false) {
            let textureAtlas = SKTextureAtlas(named: "runnersprite2")
            var frames: [SKTexture] = []
            
            for i in 1...6 {
                let textureName = "b_\(i)"
                if textureAtlas.textureNames.contains(textureName) {  // Check if texture exists in the atlas
                    let frame = textureAtlas.textureNamed(textureName)
                    frames.append(frame)
                    print("Loaded frame: \(textureName)")  // Log each loaded frame
                } else {
                    print("Error: \(textureName) not found in atlas")
                }
            }
            
            // Proceed with animation if frames are loaded correctly
            if !frames.isEmpty {
                let animation = SKAction.animate(with: frames, timePerFrame: 0.05, resize: false, restore: true)
                let repeatAnimation = SKAction.repeatForever(animation)
                leftCar.run(repeatAnimation)
                print("Animation started")
            } else {
                print("Error: No frames loaded for animation")
            }

        }
        
        // if checkbox model on
        else {
            let textureAtlas = SKTextureAtlas(named: "runnerspriteEffect")
            var frames: [SKTexture] = []
            self.globalEnv?.subtractCoinEffect(5)

            for i in 1...5 {
                let textureName = "runnerspriteEffect_\(i)"
                if textureAtlas.textureNames.contains(textureName) {  // Check if texture exists in the atlas
                    let frame = textureAtlas.textureNamed(textureName)
                    frames.append(frame)
                    print("Loaded frame: \(textureName)")  // Log each loaded frame
                } else {
                    print("Error: \(textureName) not found in atlas")
                }
            }

            // Proceed with animation if frames are loaded correctly
            if !frames.isEmpty {
                let animation = SKAction.animate(with: frames, timePerFrame: 0.1, resize: false, restore: true)
                let repeatAnimation = SKAction.repeatForever(animation)
                leftCar.run(repeatAnimation)
                print("Animation started")
            } else {
                print("Error: No frames loaded for animation")
            }
        }
    }

    // update loop for running game
    override func update(_ currentTime: TimeInterval) {
        showEnding()
        showRoadStrip()
   
        
        
        
        
        
    }

    // create the road strip and simulate they are moving
    @objc func createRoadStrip(){
    
            let leftRoadStrip = SKShapeNode(rectOf: CGSize(width: 10, height: 200))
            leftRoadStrip.strokeColor = SKColor(red: 236, green: 106, blue: 82, alpha: 0)
            leftRoadStrip.fillColor = SKColor(red: 236, green: 106, blue: 82, alpha: 0)
            leftRoadStrip.alpha = 0.4
            leftRoadStrip.name = "leftRoadStrip"
            leftRoadStrip.zPosition = 10
            leftRoadStrip.position.x = -187.5
            leftRoadStrip.position.y = 700
            addChild(leftRoadStrip)
            
            let rightRoadStrip = SKShapeNode(rectOf: CGSize(width: 10, height: 200))
            rightRoadStrip.strokeColor = SKColor(red: 236, green: 106, blue: 82, alpha: 0)
            rightRoadStrip.fillColor = SKColor(red: 236, green: 106, blue: 82, alpha: 0)
            rightRoadStrip.alpha = 0.4
            rightRoadStrip.name = "rightRoadStrip"
            rightRoadStrip.zPosition = 10
            rightRoadStrip.position.x = 187.5
            rightRoadStrip.position.y = 700
            addChild(rightRoadStrip)
            
            let middleRoadStrip = SKShapeNode(rectOf: CGSize(width: 10, height: 200))
            middleRoadStrip.strokeColor = SKColor.white
            middleRoadStrip.fillColor = SKColor.white
            middleRoadStrip.alpha = 0.4
            middleRoadStrip.name = "rightRoadStrip"
            middleRoadStrip.zPosition = 10
            middleRoadStrip.position.x = -2.5
            middleRoadStrip.position.y = 700
            addChild(middleRoadStrip)
        
    }
    
    // manage the left line audience or plants appears, size and movements
    @objc func leftTraffic(){
        if stopEverything{
            let leftTrafficItem : SKSpriteNode!
            let randonNumber = Int.random(in: 1...20)
           
            switch Int(randonNumber) {
            case 1...4:
                leftTrafficItem = SKSpriteNode(imageNamed: "audience1")
                leftTrafficItem.size.width = 150
                leftTrafficItem.size.height = 200
                leftTrafficItem.name = "audience1"
                
            case 5...8:
                leftTrafficItem = SKSpriteNode(imageNamed: "grass1")
                leftTrafficItem.size.width = 100
                leftTrafficItem.size.height = 100
                leftTrafficItem.name = "grass1"
                
            case 9...12:
                leftTrafficItem = SKSpriteNode(imageNamed: "audienceleft1")
                leftTrafficItem.size.width = 120
                leftTrafficItem.size.height = 200
                leftTrafficItem.name = "audienceleft1"
                
            case 13...15:
                leftTrafficItem = SKSpriteNode(imageNamed: "grass2")
                leftTrafficItem.size.width = 330
                leftTrafficItem.size.height = 360
                leftTrafficItem.name = "grass2"
                
            default:
                leftTrafficItem = SKSpriteNode(imageNamed: "grass3")
                leftTrafficItem.size.width = 150
                leftTrafficItem.size.height = 230
                leftTrafficItem.name = "grass3"
            }
            leftTrafficItem.anchorPoint = CGPoint(x: 0.5, y: 0.5)
            leftTrafficItem.zPosition = 10
            
            
            let randomNum = Helper().randomBetweenTwoNumbers(firstNumber: 1, secondNumber: 4, thirdNumber: 12, fourthNumber: 16)
            switch Int(randomNum) {
            case 1...4:
                leftTrafficItem.position.x = -280//-280
                
            case 5...8:
                leftTrafficItem.position.x = -280//-100
                
            case 9...12:
                leftTrafficItem.position.x = -280//-280
                
            case 12...15:
                leftTrafficItem.position.x = -280//-280
                
            default:
                leftTrafficItem.position.x = -280//-280
            }
            leftTrafficItem.position.y = 700
            
            addChild(leftTrafficItem)
        }
    }
    
    // Manage the right line audience and plants appears, size, and movements
    @objc func rightTraffic(){
        if stopEverything{
        let rightTrafficItem : SKSpriteNode!
            let randonNumber = Int.random(in: 1...18)
            /*Helper().randomBetweenTwoNumbers(firstNumber: 1, secondNumber: 8, thirdNumber: 16, fourthNumber: 24)*/
        switch Int(randonNumber) {

            
        case 1...4:
            rightTrafficItem = SKSpriteNode(imageNamed: "grass2")
            rightTrafficItem.size.width = 330
            rightTrafficItem.size.height = 360
            rightTrafficItem.name = "grass2"
          
        case 5...8:
            rightTrafficItem = SKSpriteNode(imageNamed: "grass1")
             rightTrafficItem.size.width = 100
            rightTrafficItem.size.height = 100
            rightTrafficItem.name = "grass1"
           
        case 9...13:
            rightTrafficItem = SKSpriteNode(imageNamed: "audienceright2")
             rightTrafficItem.size.width = 170
            rightTrafficItem.size.height = 280
            rightTrafficItem.name = "audienceright2"
        default:
            rightTrafficItem = SKSpriteNode(imageNamed: "audienceright1")
            rightTrafficItem.size.width = 160
            rightTrafficItem.size.height = 230
            rightTrafficItem.name = "audienceright1"
        }
        rightTrafficItem.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        rightTrafficItem.zPosition = 10
            let randomNum = Helper().randomBetweenTwoNumbers(firstNumber: 1, secondNumber: 10, thirdNumber: 16, fourthNumber: 24)
            switch Int(randomNum) {

        case 1...4:
            rightTrafficItem.position.x = 280
          
        case 5...10:
            rightTrafficItem.position.x = 280
        
        case 9...13:
            rightTrafficItem.position.x = 280
          
        default:
            rightTrafficItem.position.x = 280
        }
        rightTrafficItem.position.y = 700
       
        
        addChild(rightTrafficItem)
        }
    }
    
    // show the road strip, audiences, plants and move them down
    func showRoadStrip(){
        if self.stopEverything{
            enumerateChildNodes(withName: "leftRoadStrip", using: { (roadStrip, stop) in
                let strip = roadStrip as! SKShapeNode
                strip.position.y -= 25
            })

            
            enumerateChildNodes(withName: "rightRoadStrip", using: { (roadStrip, stop) in
                let strip = roadStrip as! SKShapeNode
                strip.position.y -= 25
            })
            
            enumerateChildNodes(withName: "middleRoadStrip", using: { (roadStrip, stop) in
                let strip = roadStrip as! SKShapeNode
                strip.position.y -= 25
            })
            
            // set the speed of plants movement speed
            enumerateChildNodes(withName: "grass2", using: { (leftCar, stop) in
                let car = leftCar as! SKSpriteNode
                car.position.y -= 15
            })
            
        
            // set the speed of plants movement speed
            enumerateChildNodes(withName: "grass1", using: { (rightCar, stop) in
                let car = rightCar as! SKSpriteNode
                car.position.y -= 15
            })
            
            // set the speed of audiences movement speed
            enumerateChildNodes(withName: "audience1", using: { (rightCar, stop) in
                let car = rightCar as! SKSpriteNode
                car.position.y -= 15
            })
            
            // set the speed of audiences movement speed
            enumerateChildNodes(withName: "audienceright1", using: { (leftCar, stop) in
                let car = leftCar as! SKSpriteNode
                car.position.y -= 15
            })
            
            // set the speed of audiences movement speed
            enumerateChildNodes(withName: "audienceright2", using: { (leftCar, stop) in
                let car = leftCar as! SKSpriteNode
                car.position.y -= 15
            })
            
            // set the speed of plants movement speed
            enumerateChildNodes(withName: "grass3", using: { (leftCar, stop) in
                let car = leftCar as! SKSpriteNode
                car.position.y -= 15
            })
            
            // set the speed of audiences movement speed
            enumerateChildNodes(withName: "audienceleft1", using: { (leftCar, stop) in
                let car = leftCar as! SKSpriteNode
                car.position.y -= 15
            })
        }
    }
    
    // set up the two runner running movement
    @objc func running() {
        
        //set the right runner
        enumerateChildNodes(withName: "runner1", using: { (runner1, stop) in
            if self.stopEverything {
                let runnerright = runner1 as! SKSpriteNode
                let runningdistanceright = CGFloat.random(in: 0..<400)
    
                let moveAction = SKAction.moveTo(y: -340 + runningdistanceright, duration: 0.5)
                runnerright.run(moveAction)
            
                
            }
        })
        
        // set the left runner
        enumerateChildNodes(withName: "leftCar", using: { (leftCar, stop) in
            if self.stopEverything {
                let runner = leftCar as! SKSpriteNode
                let runningdistance = CGFloat.random(in: 0..<400)
                

                let moveAction = SKAction.moveTo(y: -340 + runningdistance, duration: 0.5)
                runner.run(moveAction)
            }
        })
    }
  
    // end the game if finish line y = 200
    func showEnding(){

        let whiteLineLeft = childNode(withName: "whitelinel") as? SKSpriteNode
            let whiteLineRight = childNode(withName: "whiteliner") as? SKSpriteNode

            guard let whiteLineLeft = whiteLineLeft, let whiteLineRight = whiteLineRight else {
      
                return
            }
            
            if self.stopEverything {
                // Move both lines down by 15
                whiteLineLeft.position.y -= 15
                whiteLineRight.position.y -= 15

                // Check if either line reaches the stop threshold
                if whiteLineLeft.position.y <= 200 || whiteLineRight.position.y <= 200 {
                    self.stopEverything = false
                    print("Both lines stopped")
                } else {
                    self.stopEverything = true
                }
            }
        
        
        //  adjust the position of right runner depends on they are win or lose
        enumerateChildNodes(withName: "runner1", using: { (runner1, stop) in
            if self.stopEverything == false {
                let runnerright = runner1 as! SKSpriteNode
                if self.gameState?.gameWon == false {
                    runnerright.position.y += 45
//                    print("CPU y add 45")
                }
                else {
                    
                    runnerright.position.y += 10
//                    print("CPU y add 10")
                }
                
            }
        })
        
        //  adjust the position of left runner depends on they are win or lose
        enumerateChildNodes(withName: "leftCar", using: { (leftCar, stop) in
            if self.stopEverything == false {
                let runner = leftCar as! SKSpriteNode
                
                if self.gameState?.gameWon == true {
                    runner.position.y += 45
//                    print("PLAYYER y add 45")
                }
                else {
                    runner.position.y += 10
//                    print("PLAYYER y add 10")
                }
                
            }
        })
        
        
        
    }
    
    // Game end, disabled the game state
    func endGame() {
        DispatchQueue.main.async {
            print("Ending Game")
            self.gameState?.gameIsActive = false 
        }
    }
    
    // set the game result depends on spins wheel model
    func GameResult() {
        let result = self.spinItemsModel?.getResult()
        self.spinItemsModel?.clearEquipment()
        if result == 1 {
            self.gameState?.gameWon = true
        }
        else {
            self.gameState?.gameWon = false
        }
            
    }
}
