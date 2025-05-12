//
//  RuleOverview.swift
//  FitnessGo
//
//  Created by Jiayi on 4/9/2024.
//

import SwiftUI

// View to display an overview of the game rules
struct RuleOverview: View {
    @State private var isBack = false
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    // Back button to return to the StartGameOverview view
                    Button(action: {
                        isBack = true // Set the state to true when the back button is pressed
                    }) {
                        Image(systemName: "chevron.left")
                            .font(.system(size: 35))
                            .foregroundColor(.black)
                    }
                    .padding(.leading)
                    Spacer()
                        .fullScreenCover(isPresented: $isBack, content: {
                            StartGameOverview()
                        })
                            
                        
                }
                .padding(.leading)
                GameStartTitle() // Title section for the game start
                Rule() // Game rules section
                Line()  // Line separator
                NavbarHealth() // Bottom navigation bar for health
            }
        }
    }
}

#Preview {
    RuleOverview()
}
