//
//  ContentView.swift
//  FitnessGo
//
//  Created by Jiayi on 30/8/2024.
//

import SwiftUI

// Main health overview view that display step exchange, and health data
struct HealthView: View {
    var body: some View {
        NavigationView {
            VStack {
                ZStack{
                    Image("background 3")
                        .resizable()
                        .scaledToFill()
                        .edgesIgnoringSafeArea(.all)
                    VStack {
                        // Title section with user's name and logo
                        VStack(alignment: .leading) {
                            Text("Hello")
                                .font(.title3)
                                .fontWeight(.medium)
                                .padding(.leading)
                            
                            // User's name and logo
                            HStack(alignment: .bottom) {
                                Text("Alice") // User name here
                                    .font(.largeTitle)
                                    .fontWeight(.medium)
                                    .padding(.leading)
                                Spacer()
                                
                                // Logo image
                                Image("logoHu")// logo here
                                    .resizable()
                                    .frame(width: 50, height: 50)
                            }
                            
                        }
                        .padding(.leading, 20.0)
                        .padding(.trailing, 20)
                        .padding(.bottom, 1)
                        
                        // Steps exchange section
                        StepsExchange()
                        
                        // Health data section
                        HealthData()
                    }
                }
                
                Line()
                
                NavbarHealth()
            }
            
                
                
            
            
            
        }
        
    }
        
}



#Preview {
    HealthView()
}

// get colour extension

