//
//  Rule.swift
//  FitnessGo
//
//  Created by Jiayi on 4/9/2024.
//

import SwiftUI

// view of game rule
struct Rule: View {
    var body: some View {
        VStack {
            HStack {
                Text("Game Rule")
                    .font(.title)
                
            }
            
            // Game rule content
            VStack(alignment: .leading) {
                HStack {
                    Text("Step 1:")
                        .font(.callout)
                        .padding(.horizontal)
                        .padding(.top)

                    Spacer()
                    
                }
                Text("Exchange your steps to coins!")
                    .font(.callout)
                    .padding(.horizontal)
                    .padding(.bottom)
                Text("Step 2:")
                    .font(.callout)
                    .padding(.horizontal)
                Text("Take a chance in spinning wheels!")
                    .font(.callout)
                    .padding(.horizontal)
                    .padding(.bottom)
                Text("Step 3:")
                    .font(.callout)
                    .padding(.horizontal)
                Text("Select your equipment and run against John(bot)! (Hint: The rarer the equipment, the more chance to win）")
                    .font(.callout)
                    .padding(.horizontal)
                
                    .padding(.bottom)
                Text("Step 4:")
                    .font(.callout)
                    .padding(.horizontal)
                Text("Start your game!")
                    .font(.callout)
                    .padding(.horizontal)
                    .padding(.bottom)
                
                    
                
            
            }
            
        }
        .padding()
        .background(Color(red: 90/255, green: 188/255, blue: 161/255 ,opacity: 0.49))
        
        .cornerRadius(25)
        .padding()
    
        
        
    }
}

#Preview {
    Rule()
}
