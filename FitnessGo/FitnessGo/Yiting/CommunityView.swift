//
//  CommunityView.swift
//  FitnessGo
//
//  Created by 郭奕婷 on 7/9/2024.
//

import SwiftUI

class friendsRequest:ObservableObject{
    @Published var username:String = ""
    @Published var selectedname:String = ""
}

struct CommunityView: View {
    @State private var searchText: String = ""
    @State private var nameList:[String] = ["Anna","Hannah","Joe","John","Peter","Lily","Grace","Jessie"]
    @State private var selectedItem: String? = nil
    @State private var isPresented: Bool = false
    @State private var isRanked: Bool = false
    @State private var isShowFriendView: Bool = true
    @EnvironmentObject var person:friendsRequest
    private var searchResults: [String] {
        searchText.isEmpty ? nameList : nameList.filter { $0.contains(searchText) }
    }
    @State private var showVsView: Bool = false
    var body: some View {
        NavigationView {
            VStack {
                ZStack{
                    Image("background 3")
                        .resizable()
                        .scaledToFill()
                        .edgesIgnoringSafeArea(.all)
                    //                    .padding(.top,-100)
                    VStack {
                        GeometryReader{
                            geometry in
                            if person.username != "" && isShowFriendView{
                                
                                HStack {
                                    Text("New Friend ")
                                        .bold()
                                        .font(.title2)
                                    
                                    Text(person.username)
                                        .bold()
                                        .font(.title2)
                                    
                                    Spacer()
                                    
                                    
                                    Button(action: {
                                        nameList.append(person.username)
                                        isShowFriendView = false
                                        
                                    }) {
                                        Image(systemName: "checkmark.circle")
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: 50, height: 50)
                                            .foregroundColor(Color.green)
                                    }
                                    
                                    
                                    Button(action: {
                                        
                                        
                                        isShowFriendView = false
                                        
                                    }) {
                                        Image(systemName: "xmark.circle")
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: 50, height: 50)
                                            .foregroundColor(Color.red)
                                    }
                                    
                                    
                                }
                                .padding()
                                .padding(.top,120)
                                
                            }else{
                                
                            }
                            
                            VStack{
                                Divider()
                                    .padding()
                                
                                VStack{
                                    List(searchResults, id: \.self) { item in
                                        
                                        HStack{
                                            Image(item)
                                                .resizable()
                                                .frame(width: 70, height: 70)
                                                .clipShape(Circle())
                                                .background(Circle().fill(Color(red: 90/255, green: 188/255, blue: 161/255)))    .foregroundColor(Color(red: 90/255, green: 188/255, blue: 161/255))
                                            
                                            Text(item)
                                                .bold()
                                                .font(.title2)
                                            
                                            Spacer()
                                            
                                            Image(systemName: "envelope.circle")
                                                .resizable()
                                                .aspectRatio(contentMode: .fit)
                                                .frame(width: 50, height: 50)
                                                .foregroundColor(Color(red: 90/255, green: 188/255, blue: 161/255))
                                                .foregroundColor(Color(red: 90/255, green: 188/255, blue: 161/255))
                                            
                                            
                                            Image(systemName: "chevron.right.circle")
                                                .resizable()
                                                .aspectRatio(contentMode: .fit)
                                                .frame(width: 50, height: 50)
                                                .foregroundColor(Color(red: 90/255, green: 188/255, blue: 161/255))
                                            
                                        }
                                        .onTapGesture {
                                            selectedItem = item
                                            print("Clicked on: \(item)")
                                            person.selectedname = item
                                        
                                                    showVsView = true
                                                
                                            
                                        }

                                    }
                                    .listStyle(.plain)
                                }
                                .searchable(text: $searchText)
                                .padding(.top, 150)
                                .fullScreenCover(isPresented: $showVsView) {
                                 
                                        VsView(item: "")
                                       
                                    
                                }
                                .fullScreenCover(isPresented: $isRanked) {
                                    
                                    RankView()
                                        .environmentObject(person)
                                }
                            }
                            
                            Button(action:{
                                isRanked = true
                            }){
                                Text("R")
                                    .bold()
                                    .padding()
                                    .font(.title)
                                    .background(Color(red: 90/255, green: 188/255, blue: 161/255))
                            }.cornerRadius(25)
                                .frame(width: 50,height: 50)
                                .foregroundColor(.white)
                                .position(x:geometry.size.width - 40,y:geometry.size.height * 0.9)
                            
                            
                            
                        }
                    }
                   
                }
                        
                Line()
                NavbarCommunity()
                    .padding(.bottom, 85)

                
            }
            
            .onAppear(){
               // print("aini",person.username)
            }
            .ignoresSafeArea(.all)
        }
  
        
        
        
    }
}

#Preview {
    CommunityView()
        .environmentObject(friendsRequest())
}
