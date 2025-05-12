//
//  PlayGamePage.swift
//  FitnessGo
//
//  Created by Jiayi on 5/9/2024.
//

import SwiftUI

// View for the Play Game page, providing buttons for playing the game, viewing rules, and spinning for equipment
struct PlayGamePage: View {
    @State private var isRule = false
    @State private var isSpin = false
    @State private var isGame = false
    var body: some View {
        ZStack{
          Image("background 4")
              .resizable()
              .scaledToFill()
              .edgesIgnoringSafeArea(.all)
            VStack {
                Spacer()
                
                // Play Game button
                HStack {
                    Button(action: {
                        isGame = true // Trigger the game screen when the button is pressed
                    }) {
                        Image("play game")
                            .padding()

                    }
                }
                .padding(.bottom, 50)
                
                .fullScreenCover(isPresented: $isRule, content: {
                    RuleOverview() // Present the Game Rule screen
                })
                .fullScreenCover(isPresented: $isSpin, content: {
                    SpinsView() // Present the Spins View screen
                })
                .fullScreenCover(isPresented: $isGame, content: {
                    Equipment() // Present the Equipment (game) screen
                })
                
               
                HStack{
                    Button(action: {
                        isRule = true // Trigger the Game Rule screen when the button is pressed
                    }) {
                      Image("game rule")
                    }
                    .padding()
                    
                    // Spins button to open the Spins View screen
                    Button(action: {
                        isSpin = true
                    }) {
                        Image("spins wheel")
                    }
                    
                }
              
                
                
                
            }
            .padding()
        }
       
    
            
    }
}

#Preview {
    PlayGamePage()
}
