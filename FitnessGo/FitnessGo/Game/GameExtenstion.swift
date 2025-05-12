//
//  GameExtenstion.swift
//  FitnessGo
//
//  Created by Michael on 16/9/2024.
//

import UIKit

struct ColliderType {
    static let CAR_COLLIDER : UInt32 = 0

    static let ITEM_COLLIDER : UInt32 = 1
    static let ITEM_COLLIDER_1 : UInt32 = 2
}

class Helper : NSObject {
    
    // create a random number by `arc4random`
    func randomBetweenTwoNumbers(firstNumber : CGFloat ,  secondNumber : CGFloat, thirdNumber : CGFloat, fourthNumber: CGFloat) -> CGFloat{
        return CGFloat(arc4random())/CGFloat(UINT32_MAX) * abs(firstNumber - secondNumber + thirdNumber - fourthNumber) + min(firstNumber, secondNumber, thirdNumber, fourthNumber)
    }
}

// Singleton class to manage settings across the app
class Settings {
    static let sharedInstance = Settings()
    
    private init(){
        
    }
    
    var highScore = 0
}

