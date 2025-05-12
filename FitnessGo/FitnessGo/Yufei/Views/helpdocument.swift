//
//  helpdocument.swift
//  habit
//
//  Created by Yufei Yao on 4/9/2024.
//

import SwiftUI

struct HelpView: View {
    @State private var isBack = false
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    Button(action: {
                        
                        isBack = true// Action for back button
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
                VStack(alignment: .leading,spacing: 20) {
                    
                    Text("Help")
                        .font(.system(size: 34))
                        .fontWeight(.bold)
                        .foregroundColor(Color(hex: "#1BA37D").opacity(0.92))
                    
                    Text("Please send information to\nxxxx@xxx.com in time.")
                        .multilineTextAlignment(.center)
                        .font(.system(size: 24))
                    
                    Text("We will contact you as soon\nas we receive the message")
                        .multilineTextAlignment(.center)
                        .font(.system(size: 24))
                    Text("Thanks!")
                        .font(.system(size: 24))
                    
                    
                    Image("1")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 80)
                        .offset(x:180, y: -10)
                    
                    
                }
                .padding()
                .background(Color(hex: "#1BA37D").opacity(0.12))
                .cornerRadius(15.0)
                
                Spacer()
                
                // Navigation bar at the bottom
                Line()
                NavbarProfile()
            }
        }
    }
}

struct HelpView_Previews: PreviewProvider {
    static var previews: some View {
        HelpView()
    }
}
