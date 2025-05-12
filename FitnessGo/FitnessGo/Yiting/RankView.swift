//
//  RankView.swift
//  FitnessGo
//
//  Created by 郭奕婷 on 7/9/2024.
//

import SwiftUI

struct RankView: View {
    @State private var isadd = false
    @State private var searchText: String = ""
    @State private var selectedName: String = ""
    let nameList: [String] = ["JOANNA", "BOB", "Martina","Grace","Harry","Lucp","Martin"]
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var person:friendsRequest
    private var searchResults: [String] {
        searchText.isEmpty ? nameList : nameList.filter { $0.contains(searchText) }
    }
    
    var body: some View {
        NavigationView {
            ZStack{
                
                Image("background 3")
                    .padding(.top,0)
                VStack {
                    Button(action: {
                        print("Back button tapped")
                        self.presentationMode.wrappedValue.dismiss()
                    }) {
                        Image(systemName: "chevron.left")
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding()
                    }
                    .foregroundColor(.black)
                    
                    GeometryReader { geometry in
                        VStack(spacing:0) {
                            
                            
                            ZStack {
                                Rectangle()
                                    .fill(Color(red: 27/255, green: 163/255, blue: 100/255).opacity(0.3))
                                    .cornerRadius(20)
                                    .padding()
                                    .frame(width: geometry.size.width, height: 120)
                                
                                Text("RANK")
                                    .bold()
                                    .font(.largeTitle)
                            }
                            .fullScreenCover(isPresented: $isadd) {
                                RequestConfirm(addedName: selectedName)
                            }
                            
                            List {
                                ForEach(Array(zip(searchResults.indices, searchResults)), id: \.1) { index, item in
                                    HStack {
                                        Text("\(index + 1)") // Show index
                                        
                                        Image(item)
                                            .resizable()
                                            .frame(width: 70, height: 70)
                                            .clipShape(Circle())
                                            .background(Circle().fill(Color(red: 90/255, green: 188/255, blue: 161/255)))    .foregroundColor(Color(red: 90/255, green: 188/255, blue: 161/255))
                                        
                                        
                                        Text(item)
                                            .bold()
                                        
                                        Spacer()
                                        
                                        Button(action: {
                                            selectedName =  item
                                            person.username = selectedName
                                            isadd = true
                                            print(selectedName)
                                        }) {
                                            Text("Add")
                                                .foregroundColor(.white)
                                        }
                                        .padding()
                                        .frame(width: 70, height: 30)
                                        .background(.black)
                                    }
                                    
                                }
                                .listStyle(.plain)
                                
                            }
                            
                        }
                    }
                        
                        Line()
                        NavbarCommunity()
                    } .searchable(text: $searchText)
                }
                
            }
        
    }
}

#Preview {
    RankView()
}
