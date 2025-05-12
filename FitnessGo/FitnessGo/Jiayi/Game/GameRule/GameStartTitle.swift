//
//  GameStartTitle.swift
//  FitnessGo
//
//  Created by Jiayi on 4/9/2024.
//

import SwiftUI

// View that represents the title screen of the start game
struct GameStartTitle: View {
    var body: some View {
        VStack {
            VStack {
                
                // HStack to display "Game" and "Start" texts with the logo in between
                HStack {
                    Text("Game")
                        .font(.largeTitle)
                        .padding(.horizontal)
                        
                    
                    // Game logo in between the title text
                    Image("logoHu")
                    Text("Start")
                        .font(.largeTitle)
                        .padding(.horizontal)
                }
                
                
                
                
            }
            .padding()
            .overlay(
                RoundedRectangle(cornerRadius: 15)
                    .fill(Color(red: 27/255, green: 163/255, blue: 125/255 ,opacity: 0.20))
            )
            .padding()
            
            // Little character image below the title
            Image("littleman")
                .resizable()
                .frame(width: 330, height: 30)
                .offset(y:-40)
                .padding(.bottom, -40)
        }
    }
}

#Preview {
    GameStartTitle()
}
