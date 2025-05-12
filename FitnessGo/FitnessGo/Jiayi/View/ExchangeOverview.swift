//
//  ExchangeOverview.swift
//  FitnessGo
//
//  Created by Jiayi on 5/9/2024.
//

import SwiftUI

// View that displays an overview of coin exchanges, with navigation to return to the previous HealthView
struct ExchangeOverview: View {
    @State private var isBack = false // State to control navigation back to HealthView
    
    var body: some View {
        HStack {
            
            // Back button to navigate back to HealthView
            Button(action: {
                isBack = true // Trigger navigation back when pressed
            }) {
                Image(systemName: "chevron.left") // Chevron icon for back button
                    .font(.system(size: 35))
                    .foregroundColor(.black)
            }
            .padding(.leading)
            Spacer()
            
            // Full-screen cover to present HealthView when `isBack` is true
                .fullScreenCover(isPresented: $isBack, content: {
                    HealthView() // Navigate back to the HealthView
                })
                    
                
        }
        
        // Main navigation view for the coin exchange
        NavigationView {
            
            VStack {
                
                ZStack{
                    
                    // Background image for the exchange screen
                    Image("CoinBackground2")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .edgesIgnoringSafeArea(.all)
                    
                    VStack {
                        
                        // Header for the coin exchange with a logo
                        HStack {
                            
                            Text("Coins Exchange")
                                .font(.system(size: 38))
                            Image("logoHu")
                                .resizable()
                                .frame(width: 80, height: 80)
                            
                            
                        }
                        
                        Rate()
                        
                        
                    }
                }
                
                Line()
                
                // Bottom navigation bar for health
                NavbarHealth()
            }
        }
    }
}

#Preview {
    ExchangeOverview()
}
