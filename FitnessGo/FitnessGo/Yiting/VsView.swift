//
//  VsView.swift
//  FitnessGo
//
//  Created by Michael on 7/9/2024.
//

import SwiftUI

struct VsView: View {
    let item: String
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var person:friendsRequest
    
    var body: some View {
        NavigationView {
         
            VStack {
                GeometryReader{
                    geometry in
                    VStack{
                        Button(action:{
                            print("Back button tapped")
                            self.presentationMode.wrappedValue.dismiss()
                        })
                        {
                            Image(systemName: "chevron.left")
                                .frame(maxWidth: .infinity,alignment: .leading)
                                .padding()
                        }
                        .foregroundColor(.black)
                        
                        HStack{
                            Image(systemName: "person.circle")
                                .resizable() // Make the image resizable
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 60, height: 60)
                                .foregroundColor(Color(red: 90/255, green: 188/255, blue: 161/255))
                            
                            
                            Text(" VS ")
                                .font(.system(size: 40))
                            
                            Image( person.selectedname)
                                .resizable() // Make the image resizable
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 60, height: 60)
                                .background(Circle().fill(Color(red: 90/255, green: 188/255, blue: 161/255)))
                            
                        }.position(x:geometry.size.width/2)
                            .padding(.top,50)
                            .frame(width: geometry.size.width,height: geometry.size.height * 0.1)
                        
                        
                        ZStack{
                            VStack{
                                
                                Text("LEVEL")
                                    .bold()
                                
                                HStack{
                                    Spacer()
                                    
                                    
                                    CustomProgressBar(progress: 35, showPercentage: true)
                                    
                                    
                                    Spacer()
                                    CustomProgressBar(progress: 13, showPercentage: true)
                                    Spacer()
                                }
                            }.background(Color(red: 27/255, green: 163/255, blue: 100/255).opacity(0.3))
                                .padding()
                            
                            
                        }.frame(width: geometry.size.width,height: geometry.size.height * 0.2)
                        
                        
                        ZStack{
                            VStack{
                                
                                Text("TODAY STEPS")
                                    .bold()
                                HStack{
                                    Spacer()
                                    
                                    
                                    CustomProgressBar(progress: 25, showPercentage: true)
                                    
                                    
                                    Spacer()
                                    CustomProgressBar(progress: 42, showPercentage: true)
                                    Spacer()
                                }
                            }.background(Color(red: 27/255, green: 163/255, blue: 100/255).opacity(0.2))
                                .padding()
                        }.frame(width: geometry.size.width,height: geometry.size.height * 0.2)
                        
                        
                        ZStack{
                            VStack{
                                
                                Text("WIN RATE")
                                    .bold()
                                HStack{
                                    Spacer()
                                    CustomProgressBar(progress: 45, showPercentage: true)
                                    
                                    Spacer()
                                    CustomProgressBar(progress: 43, showPercentage: true)
                                    Spacer()
                                }
                            }.background(Color(red: 27/255, green: 163/255, blue: 100/255).opacity(0.2))
                                .padding()
                        }.frame(width: geometry.size.width,height: geometry.size.height * 0.2)
                        
                        
                        ZStack{
                            VStack{
                                
                                Text("CARD NUMBERS")
                                    .bold()
                                HStack{
                                    Spacer()
                                    
                                    
                                    CustomProgressBar(progress: 10, showPercentage: false)
                                    
                                    
                                    Spacer()
                                    CustomProgressBar(progress: 7, showPercentage: false)
                                    Spacer()
                                }
                            }.background(Color(red: 27/255, green: 163/255, blue: 100/255).opacity(0.2))
                                .padding()
                        }.frame(width: geometry.size.width,height: geometry.size.height * 0.2)
                        
                    }
                }
                
                //bottom navigation
                Line()
                NavbarCommunity()
            }
        }
    }
}



struct CustomProgressBar: View {
    var progress: Double
    var showPercentage: Bool
    
    var body: some View {
        VStack {
            if showPercentage {
                Text("\(Int(progress))%")
                    .bold()
            }else{
                Text("\(Int(progress))")
                    .bold()
            }
            
            GeometryReader { geometry in
                ZStack(alignment: .leading) {
                    
                    RoundedRectangle(cornerRadius: 5)
                        .fill(Color.gray.opacity(0.3))
                        .frame(height: 20)
                    
                    
                    RoundedRectangle(cornerRadius: 5)
                        .fill(Color(red: 27/255, green: 163/255, blue: 100/255))
                        .frame(width: CGFloat(progress) / 100 * geometry.size.width, height: 20)
                }
            }
        }
        .padding()
    }
}
