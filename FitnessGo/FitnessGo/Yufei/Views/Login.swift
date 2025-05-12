//
//  Login.swift
//  habit
//
//  Created by Yufei Yao on 4/9/2024.
//

import SwiftUI

struct ContentView: View {
    @State private var isLoggedIn = false
    
    var body: some View {
        //conditional rendering
        if isLoggedIn {
            //if loggedin
            StartGameOverview()
        } else {
            LoginView(isLoggedIn: $isLoggedIn)
        }
    }
}

struct LoginView: View {
    @State private var username = ""
    @State private var password = ""
    @Binding var isLoggedIn: Bool
    
    var body: some View {
        NavigationView {
            VStack {
                VStack {
                    Image("1")
                        .resizable()
                        .frame(width: 55, height: 55)
                        .offset(y: -31)
                        .padding(.top, 40)
                    
                    VStack(alignment: .leading) {
                        // username
                        Text("Username")
                            .font(.headline)
                            .padding(.horizontal)
                        
                        TextField("Username", text: $username)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .overlay(
                                RoundedRectangle(cornerRadius: 5)
                                    .stroke(Color(hex: "#1BA37D").opacity(0.54), lineWidth: 2)
                            )
                            .padding(.horizontal)
                        // password
                        Text("Password")
                            .font(.headline)
                            .padding([.top, .horizontal])
                        
                        SecureField("Password", text: $password)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .overlay(
                                RoundedRectangle(cornerRadius: 5)
                                    .stroke(Color(hex: "#1BA37D").opacity(0.54), lineWidth: 2)
                            )
                            .padding(.horizontal)
                    }.padding(.bottom,30)
                    
                    HStack(spacing: 20) {
                        Button("Login") {
                            isLoggedIn = true
                        }
                        .padding()
                        .frame(width: 100, height: 50)
                        .background(Color(hex: "#1BA37D").opacity(0.54))
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        
                        
                        Button("Register") {
                            isLoggedIn = true
                        }
                        .padding()
                        .background(Color(hex: "#1BA37D").opacity(0.54))
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .frame(width: 150)
                    }
                    .frame(maxWidth: .infinity, alignment: .center)
                    .padding(EdgeInsets(top: 0, leading: 40, bottom: 30, trailing: 40))
                    
                    Spacer().frame(height: 20)
                    
                    .background(
                        Color(hex: "#D1EDE5")
                            .opacity(0.54)
                            .cornerRadius(20)
                    ).frame(minWidth: 300, minHeight: 150)
                }
                .padding(40)
                Spacer()
                // nav bar
                Line()
                NavbarLogin()
            }
            .background{
                Image("background 1")
                    .scaledToFill()
                    .padding(.top,-100)
            }
        }
    }
}

     



struct MainView: View {
    var body: some View {
        VStack {
            
            HStack {
        
            }
            .padding()
            .background(Color.gray.opacity(0.2))
            .edgesIgnoringSafeArea(.bottom)
        }
    }
}

#Preview {
    ContentView()
}
