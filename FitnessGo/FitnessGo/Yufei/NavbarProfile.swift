//
//  NavbarProfile.swift
//  FitnessGo
//
//  Created by Michael on 12/9/2024.
//

import SwiftUI

struct NavbarProfile: View {
    var body: some View {
        // Navbar
        HStack {
            Spacer()
            
            NavigationLink(destination: StartGameOverview().navigationBarBackButtonHidden()){
                VStack {
                    Text("Game")
                        .font(.caption)
                        .foregroundColor(.gray)
                    Image("navicon1black")
                        .resizable()
                        .frame(width: 44, height: 44)
                        .foregroundColor(.black)
                }
            }
            
            Spacer()
            
            NavigationLink(destination: HealthView().navigationBarBackButtonHidden()){
                VStack {
                    Text("Health Data")
                        .font(.caption)
                        .foregroundColor(.gray)
                    Image( "navicon2black")
                        .resizable()
                        .frame(width: 44, height: 44)
                        .foregroundColor(.black)
                }
            }
            
            Spacer()
            
            NavigationLink(destination: CommunityView().navigationBarBackButtonHidden()){
                VStack {
                    Text("Coummunity")
                        .font(.caption)
                        .foregroundColor(.gray)
                    Image("navicon3black")
                        .resizable()
                        .frame(width: 44, height: 44)
                        .foregroundColor(.black)
                }
            }
            
            Spacer()
            
            NavigationLink(destination: UserProfile().navigationBarBackButtonHidden()){
                VStack {
                    Text("Profile")
                        .font(.caption)
                        .foregroundColor(Color(hex: "#1BA37D"))
                    Image("navicon4colour")
                        .resizable()
                        .frame(width: 50, height: 44)
                        .foregroundColor(.black)
                }
            }
            
            Spacer()
        }
        .padding()
        .background(Color.white)
        .edgesIgnoringSafeArea(.bottom)
    }
}

#Preview {
    NavbarProfile()
}
