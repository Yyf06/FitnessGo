//
//  device.swift
//  FitnessGo
//
//  Created by Michael on 7/9/2024.
//

import SwiftUI

struct device: View {
    @State private var isBack = false
    var body: some View {
        NavigationView {
            VStack {
        
                HStack {
                    Button(action: {
                        isBack = true
                    
                        print("Back button tapped")
                    }) {
                        Image(systemName: "chevron.left")
                            .foregroundColor(.black)
                            .frame(width: 20, height: 80)
                            .font(.system(size: 24))
                        
                    }
                    Spacer()
                    Image("3")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 80)
                    Spacer()
                }
                .padding()
                .fullScreenCover(isPresented: $isBack, content: {
                    UserProfile()
                })
                
                
                // Center content
                VStack(alignment: .leading,spacing: 40) {
                    
                    Text("Device")
                        .font(.system(size: 34))
                    
                        .foregroundColor(Color(hex: "#1BA37D").opacity(0.8))
                    
                    HStack{
                        Image(systemName: "circle.fill")
                        Text("Iphone")
                            .multilineTextAlignment(.center)
                            .font(.system(size: 24))
                            .padding()
                            .background(Color(hex:
                                                "#1BA37D").opacity(0.1))
                            .cornerRadius(15.0)
                    }
                    HStack{
                        Image(systemName: "circle")
                        Text("Apple Watch")
                            .multilineTextAlignment(.center)
                            .font(.system(size: 24))
                            .padding()
                            .background(Color(hex:
                                                "#1BA37D").opacity(0.1))
                            .cornerRadius(15.0)
                    }
                    Button(action: {
                        // Action for back button
                        print("Back button tapped")
                    }) {
                        Text("ADD")
                            .frame(width: 220, height: 80)
                            .background(Color(hex:
                                                "#1BA37D").opacity(0.4))
                        
                            .font(.system(size: 24))
                            .foregroundColor(.white)
                            .cornerRadius(15.0)
                        
                    }
                    
                    
                }
                .padding(30)
                
                .cornerRadius(15.0)
                
                Spacer()
                
                // Navigation bar at the bottom
                
                Line()
                NavbarProfile()
            }
        }
    }
}

#Preview {
    device()
}
