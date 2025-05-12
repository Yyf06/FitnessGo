//
//  RequestConfirm.swift
//  FitnessGo
//
//  Created by Jiayi on 4/9/2024.
//

import SwiftUI

// View that confirms a friend request has been sent and navigates to a community view when confirmed
struct RequestConfirm: View {
    @State private var isOK = false
    var addedName:String
    @EnvironmentObject var person:friendsRequest
// main content
    var body: some View {
        NavigationView {
            VStack{
                VStack {

                    VStack {
                        // Title and close button
                        VStack {
                            HStack {
                                Spacer()
                                
                                // Close button (currently no action)
                                Button(action: {
                                    
                                }) {
                                    Image("closepopup")
                                        .resizable()
                                        .frame(width: 20, height: 20)
                                        .padding()
                                    
                                    
                                }
                                
                                // Display the added friend's name
                                Text(addedName)
                                
                            }
                            
                            // jump to other view if press the button
                            .fullScreenCover(isPresented: $isOK, content: {
                                CommunityView().environmentObject(person)
                            })
                            
                            // Confirmation message
                            Text("Your friend request has been sent !")
                                .font(.title)
                                .fontWeight(.regular)
                                .padding()
                            HStack {
                                Spacer()
                                Button(action: {
                                    
                                    isOK = true // Navigate to the community view when pressed
                                }) {
                                    Image("OKbutton")
                                        .resizable()
                                        .frame(width: 45, height: 45)
                                        .padding()
                                    
                                }
                            }
                        }
                    }
                    .background(Color(red: 27/255, green: 163/255, blue: 125/255 ,opacity: 0.2))
                    
                    .cornerRadius(30)
                    
                }
                .padding()
                .padding(.top, 100)
                Spacer()
                Line()
                
                
                NavbarCommunity()
            }
        }.onAppear(){
            print("sss",addedName)
        }
        
        
    }
}

#Preview {
    RequestConfirm(addedName: "Mandy")
}
