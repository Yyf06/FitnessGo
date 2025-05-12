//
//  GlobalEnvironment.swift
//  FitnessGo
//
//  Created by Jiayi on 18/9/2024.
//


import Foundation
import Combine

// Global environment class that manages coins, step count, and related actions.
class GlobalEnvironment: ObservableObject {
    @Published var coins: Int = 0
    @Published var stepCounts: [StepCountData] = []
    @Published var steps: Int = 0
    private var stepCountManager = StepCountManager()
    private var cancellable: AnyCancellable?
    private var coinsLocal: Int = 0
    
    
    // Initializer to set up initial values and observe step count updates
    init() {

        // Initializer to set up initial values and observe step count updates
        self.coins = UserDefaults.standard.integer(forKey: "coinscurrent")
        
        // Observe changes in the step count from the StepCountManager
        self.cancellable = stepCountManager.$stepCount
            .receive(on: DispatchQueue.main) // Ensure updates are received on the main thread
            .sink { [weak self] newStepCount in
                self?.steps = newStepCount // Update the steps property
            }
        
        updateStepCount()
    }

    
    
    // Function to add coins to the total and update UserDefaults
    func addCoins(_ amount: Int) {
        
            
        
        DispatchQueue.main.async {
            
            // Retrieve coincurrent value from UserDefaults
            let coinscurrent = UserDefaults.standard.integer(forKey: "coinscurrent")

            print("coinscurrent: \(coinscurrent)")
            // add spectic coin into amount
            self.coins += amount
            // Save the updated coin value to UserDefaults
            UserDefaults.standard.set(self.coins, forKey: "coinscurrent")
            print("self.coins: \(self.coins)")
        }
        
    }

    // Function to subtract coins for a spin
    func subtractCoinspin(_ amount: Int) {

        DispatchQueue.main.async {
            

            self.coins -= amount
            UserDefaults.standard.set(self.coins, forKey: "coinscurrent")
            print("self.coins: \(self.coins)")
        }

    }
    
    // Function to subtract coins for an effect purchase(dark pattern)
    func subtractCoinEffect(_ amount: Int) {
        DispatchQueue.main.async {
            

            self.coins -= amount
            UserDefaults.standard.set(self.coins, forKey: "coinscurrent")
            print("self.coins: \(self.coins)")
        }

    }
    
    // Private function to update the steps property from the last entry in stepCounts
    private func updateStepsFromLastEntry() {
                if let lastStepCount = stepCounts.last?.stepCount {
                    steps = Int(lastStepCount)
                }
    }
            
    // Function to manually update the step count by calling StepCountManager
    func updateStepCount() {
           stepCountManager.updateStepCount()
           DispatchQueue.main.async {
               self.steps = 100000
               print("StepsUpdateCount: \(self.steps)")
           }
       }

    // Function to update steps with a new value
       func updateSteps(_ newSteps: Int) {
           DispatchQueue.main.async {
               self.steps = newSteps
           }
       }
            
    
}
