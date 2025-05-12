//
//  Register.swift
//  FitnessGo
//
//  Created by Yufei on 7/9/2024.
//

import SwiftUI

struct RegisterView: View {
    @State private var isLoggedIn = false
    
    var body: some View {
        if isLoggedIn {
            MView()
        } else {
            Register(isLoggedIn: $isLoggedIn)
        }
    }
}


struct Register: View {
    @State private var username = ""
    @State private var password = ""
    @State private var email = ""
    @Binding var isLoggedIn: Bool
    
    var body: some View {
        NavigationView {
            VStack {
                VStack {
                    // Logo Image
                    Image("1")
                        .resizable()
                        .frame(width: 55, height: 55)
                        .offset(y: -31)
                        .padding(.top, 30)
                    
                    // Username, Password, and Email Fields
                    VStack(alignment: .leading) {
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
                        
                        Text("Email")
                            .font(.headline)
                            .padding([.top, .horizontal])
                        
                        TextField("Email", text: $email)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .overlay(
                                RoundedRectangle(cornerRadius: 5)
                                    .stroke(Color(hex: "#1BA37D").opacity(0.54), lineWidth: 2)
                            )
                            .padding(.horizontal)
                    }
                    .padding(.bottom, 30)
                    
                    // Announcement Section
                    VStack {
                        Text("Please fill in all blanks")
                            .font(.subheadline)
                            .foregroundColor(.black)
                            .padding()
                            .frame(maxWidth: .infinity) // Allow text to take full width
                    }
                    .padding(.bottom, 20)
                    
                    // Register and Login Buttons
                    VStack(spacing: 20) {
                        Button("Register") {
                            isLoggedIn = true
                        }
                        .padding()
                        .frame(width: 150, height: 50)
                        .background(Color(hex: "#1BA37D").opacity(0.54))
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        
                        Text("I have an account")
                            .padding(.top)
                        
                        Button("Login") {
                            isLoggedIn = true
                        }
                        .padding()
                        .frame(width: 150, height: 50)
                        .background(Color(hex: "#1BA37D").opacity(0.54))
                        .foregroundColor(.white)
                        .cornerRadius(10)
                    }
                    .frame(maxWidth: .infinity, alignment: .center)
                    .padding(.horizontal, 40)
                    .padding(.bottom, 30)
                }
                
                Spacer()
                Line()
                NavbarProfile()
            }
        }
    }
}


#Preview {
    RegisterView()
}


struct MView: View {
    var body: some View {
        VStack {
            Text("Main View")
            
            Spacer()
            
           
            HStack {
            }
            .padding()
            .background(Color.gray.opacity(0.2))
            .edgesIgnoringSafeArea(.bottom)
        }
    }
}

#Preview {
    RegisterView()
}


