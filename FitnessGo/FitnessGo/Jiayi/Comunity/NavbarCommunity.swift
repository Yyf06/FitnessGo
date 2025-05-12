//
//  NavbarCommunity.swift
//  FitnessGo
//
//  Created by Michael on 5/9/2024.
//

import SwiftUI

struct NavbarCommunity: View {
    var body: some View {
        HStack {
            Spacer()
            
            NavigationLink(destination: StartGameOverview().navigationBarBackButtonHidden()){
                VStack {
                    Text("Game") // Label below the icon
                        .font(.caption) // Adjust font size to fit
                        .foregroundColor(.gray)
                    
                    Image("navicon1black")// Replace with your image asset
                        .resizable()
                        .frame(width: 44, height: 44)
                        .foregroundColor(.black)
                }
            }
            
            Spacer()
            
            NavigationLink(destination: HealthView().navigationBarBackButtonHidden()){
                VStack {
                    Text("Health Data") // Label below the icon
                        .font(.caption) // Adjust font size to fit
                        .foregroundColor(.gray)
                    Image( "navicon2black") // Replace with your image asset
                        .resizable()
                        .frame(width: 44, height: 44)
                        .foregroundColor(.black)
                }
            }
            
            Spacer()
            
            NavigationLink(destination: CommunityView().navigationBarBackButtonHidden()){
                VStack {
                    Text("Coummunity") // Label below the icon
                        .font(.caption) // Adjust font size to fit
                        .foregroundColor(Color(hex: "#1BA37D"))
                    Image("navicon3colour") // Replace with your image asset
                        .resizable()
                        .frame(width: 44, height: 44)
                        .foregroundColor(.black)
                }
            }
            
            Spacer()
            
            NavigationLink(destination: UserProfile().navigationBarBackButtonHidden()){
                VStack {
                    Text("Profile") // Label below the icon
                        .font(.caption) // Adjust font size to fit
                        .foregroundColor(.gray)
                    Image("navicon4") // Replace with your image asset
                        .resizable()
                        .frame(width: 44, height: 44)
                        .foregroundColor(.black)
                }
            }
            
            Spacer()
        }
        .padding()
        .background(Color.white) // Optional background color for the navigation bar
        .edgesIgnoringSafeArea(.bottom) //
    }
}

#Preview {
    NavbarCommunity()
}
