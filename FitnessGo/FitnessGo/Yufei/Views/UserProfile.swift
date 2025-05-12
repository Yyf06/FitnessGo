//
//  UserProfile.swift
//  FitnessGo
//
//  Created by Yufei on 7/9/2024.
//

import SwiftUI
import CoreData



struct UserProfile: View {
    @EnvironmentObject var globalEnv: GlobalEnvironment

    @State private var isHelp = false
    @State private var isDevice = false
    @State private var isLogout = false
    var body: some View {
        
        NavigationView {
            VStack {
                ZStack{
                    Image("background 1")
                        .resizable()
                        .scaledToFill()
                        .edgesIgnoringSafeArea(.all)
                    
                    VStack {
                        
                        HStack {
                            Spacer()
                            Image("3")
                                .resizable()
                                .scaledToFit()
                                .frame(height: 100)
                            Spacer()
                            Button(action: {
                                
                                print("")
                            }) {
                                Image(systemName: "chevron.right")
                                    .foregroundColor(Color(hex: "#1BA37D").opacity(0.9))
                                    .imageScale(.large)
                                    .offset(x:-130)
                            }
                            
                            
                        }
                        .padding()
                        .fullScreenCover(isPresented: $isHelp, content: {
                            HelpView()
                        })
                        .fullScreenCover(isPresented: $isLogout, content: {
                            ContentView()
                        })
                        //profile information
                        VStack(spacing: 20) {
                            infoRow(title: "Name", value: "John Doe")
                            infoRow(title: "ID", value: "12345")
                            infoRow(title: "Age", value: "20")
                            infoRow(title: "Coins", value: "\(globalEnv.coins)")
                            infoRow(title: "Device", value: "IPHONE"/*, action: {isDevice = true}*/)
                            infoRow(title: "Help", value: ">", action: {isHelp = true})
                        }
                        .padding(30)
                        
                        Spacer()
                        
                        // Logout button
                        Button(action: {
                            isLogout = true
                            print("Logout clicked")
                        }) {
                            Text("Logout")
                                .font(.system(size: 16, weight: .medium))
                                .foregroundColor(.white)
                                .padding()
                                .frame(width: 200)
                                .background(Color(hex: "#1BA37D").opacity(0.8))
                                .cornerRadius(8)
                                .shadow(radius: 5)
                                .offset(y:-15)
                            
                        }
                        
                       
                        
                        
                    }
                }
                Line()
                NavbarProfile()
            }
        }
    }
    private func infoRow(title: String, value: String, action:(() -> Void)? = nil) -> some View {
        HStack {
            Text(title)
                .font(.system(size: 20))
                .foregroundColor(Color(hex: "#1BA37D")
                )
            Spacer()
            if (value == ">") {
                Button(action: { action?() }) {
                    Image(systemName: "chevron.right")
                    .foregroundColor(.black)
                }
            }
            else {
                Text(value)
                    .font(.system(size: 20))
                    .foregroundColor(.primary)
            }
        }
        .padding()
        .frame(minHeight: 50)
        .background(Color(hex: "#1BA37D").opacity(0.12))
        .padding(.horizontal)
        .cornerRadius(8)
    }
    
    
         
    }



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        UserProfile()
    }
}
