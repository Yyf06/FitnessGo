//
//  Rate.swift
//  FitnessGo
//
//  Created by Michael on 5/9/2024.
//

import SwiftUI


// Main view for the Rate screen
struct Rate: View {
    @StateObject private var stepCountManager = StepCountManager()
    @State private var stepCounts: [StepCountData] = [] //
    @EnvironmentObject var globalEnv: GlobalEnvironment
    @State private var Coins: Int = 10 // set as an integer
    @State private var isPressed = false
    @State private var debugsteps: Int = 5000
    @State private var isDebugMode = false
    @State private var stepsLocalcurrent = 0
    @State private var coinscurrent = 0
  
    let audioPlayer = AudioPlayerClass() // Handles audio playback


    var body: some View {
        VStack{
            
            // Exchange section
                    HStack {
                        Text("1000 steps ")
                            .font(.title)
                            .foregroundColor(Color(red: 27/255, green: 163/255, blue: 125/255 ,opacity: 1))
                        
                        // Button to reset steps and coins stored in UserDefaults
                        Button(action: {
                            UserDefaults.standard.removeObject(forKey: "stepsLocalcurrent")
                            UserDefaults.standard.removeObject(forKey: "coinscurrent")
                            // exchange button
                        }) {
                            Image("ArrowSwitch")
                                .resizable()
                                .frame(width: 35, height: 30)
                            
                        }
                        
                        Image("coin")
                            .resizable()
                            .frame(width: 40, height: 40)
                        Text(" 1 C")
                            .font(.title)
                            .foregroundColor(Color(red: 27/255, green: 163/255, blue: 125/255 ,opacity: 1))
                        
                    }
                            
            .padding()
            
            VStack { // steps part
                HStack{
                    
                    Image ("walklight")
                        .resizable()
                        .frame(width: 70, height: 70)
                    
                    Text("Remaining Steps")
                        .font(.title)
                        .foregroundColor(Color(.white))
                }
                
                // Display the number of remaining steps from globalEnv
                Text("\(globalEnv.steps)")
                    .font(.title2)
                    .foregroundColor(Color(.white))
                    .opacity(isPressed ? 0.4 : 1.0)
                    .scaleEffect(isPressed ? 1.4 : 1.0)
                
            }
            .padding()
            .background(Color(red: 47/255, green: 152/255, blue: 123/255 ,opacity: 0.8))
            

            
            .cornerRadius(30)
            .padding(.bottom)
            
            // Coin exchange part
            VStack {
                ZStack {
                    Button(action: {
                        
                        Coins = CovertCoin(steps: globalEnv.steps)
                        
                        // Convert steps to coins and play a sound
                        audioPlayer.playCoinSound()
                        // exchange button
                    }) {
                        Image("exchangebutton")
                            .resizable()
                            .frame(width: 160, height: 60.0)
                        
                    }
                }
                
                VStack {
                    HStack{
                        
                        Image ("coin")
                            .resizable()
                            .frame(width: 60, height: 70)
                        
                        Text("Remaining Coins")
                            .font(.title)
                            .foregroundColor(Color(red: 27/255, green: 163/255, blue: 125/255 ,opacity: 1))
                    }
                    
                    // Display the number of remaining coins from globalEnv
                    Text("\(globalEnv.coins)") // coins amount here
                        .font(.title2)
                        .foregroundColor(Color(red: 27/255, green: 163/255, blue: 125/255 ,opacity: 1))
                        .opacity(isPressed ? 0.4 : 1.0)
                        .scaleEffect(isPressed ? 1.4 : 1.0)
                    
                }
                .padding()
                .background(Color(red: 209/255, green: 237/255, blue: 229/255 ,opacity: 0.8))
                
                
             
                
                .cornerRadius(30)
            }
            
            // Press events for button animations
            .pressEvents {
                withAnimation(.easeInOut(duration: 0.1)) {
                    isPressed = true
                }
            } onRelease: {
                withAnimation {
                    isPressed = false
                }
            }
        }
        .onAppear {

        
        }
    }
    
   
    
    // Coin exchange Function
    func CovertCoin(steps: Int) -> Int {
        let StepRatio = 1000
        let coinsEarned = steps / StepRatio
        if (steps >= 1000) {
            globalEnv.addCoins(coinsEarned) // Add coins to global environment
            globalEnv.steps -= coinsEarned * StepRatio // Deduct steps
        
            // Update local steps and coins, and store them in UserDefaults
            let defaults = UserDefaults.standard
            if (defaults.integer(forKey: "stepsLocalcurrent") != 0){
                stepsLocalcurrent = defaults.integer(forKey: "stepsLocalcurrent")
            }
            stepsLocalcurrent += (coinsEarned * StepRatio)
            
            print("stepsLocalcurrent: \(stepsLocalcurrent)")

            
            defaults.set(stepsLocalcurrent, forKey: "stepsLocalcurrent")
            
            if (defaults.integer(forKey: "coinscurrent") != 0){
                stepsLocalcurrent = defaults.integer(forKey: "coinscurrent")
            }
            coinscurrent += coinsEarned
            print("coinsnow: \(coinscurrent)")
            defaults.set(coinscurrent, forKey: "coinscurrent")
            
            

            
            return globalEnv.coins
        }
        return globalEnv.coins
    }
            

   }

#Preview {
    Rate()
        .environmentObject(GlobalEnvironment())
}
