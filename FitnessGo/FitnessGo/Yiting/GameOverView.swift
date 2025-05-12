//
//  GameOverView.swift
//  FitnessGo
//
//  Created by Michael on 7/9/2024.
//

import SwiftUI

struct GameOverView: View {
    @ObservedObject var gameState: GameStateManager
    @Environment(\.presentationMode) var presentationMode
    @State private var isJumpedtoGameView = false
    @State private var timeremain = 5
    @State private var isAgain = false
    let audioPlayer = AudioPlayerClass()
   
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    var body: some View {
        NavigationView {
            ZStack {
                GeometryReader{
                    geometry in
                    VStack {
                        VStack{
                            
                            ZStack{
                                Image("winbackground")
                                
                                    .scaledToFill()
                                    .frame(width: geometry.size.width * 0.8,height: geometry.size.height)
                                VStack{
                                    Image("GameOver")
                                    Text("Unfortunately")
                                        .font(.system(size: 30))
                                        .foregroundColor(.black)
                                        .padding()
                                    
                                    Text("You lose")
                                        .font(.system(size: 30))
                                        .foregroundColor(.black)
                                        .padding()
                                    HStack{
                                        Spacer()
                                        ZStack{
                                            Rectangle().fill(.black.opacity(0.2)).cornerRadius(10).frame(width: 100,height: 30)
                                            
                                            Button(action:{
                                                print("level tapped")
                                                
                                                
                                            }){
                                                Text("Leave \(timeremain)")
                                            }.foregroundColor(.black)
                                        }
                                        
                                        Spacer()
                                            .fullScreenCover(isPresented: $isAgain, content: {
                                                Equipment()
                                            })
                                        ZStack{
                                            Rectangle().fill(.black.opacity(0.2)).cornerRadius(10).frame(width: 140,height: 30)
                                            Button(action:{
                                                print("One more game tapped")
                                                isAgain = true
                                                
                                            }){
                                                Text("One more game")
                                            }.foregroundColor(.black)
                                        }
                                        
                                        Spacer()
                                    }
                              
                                }
          
                            }
                        }
                        NavigationLink(destination: StartGameOverview().navigationBarBackButtonHidden(), isActive: $isJumpedtoGameView) {
                            EmptyView()
                        }
                    }
                    
                    .frame(width: geometry.size.width,height: geometry.size.height)
                    .cornerRadius(30)
                    
                    
                    
                }
                .onReceive(timer) { time in
                    if timeremain > 0 {
                        timeremain -= 1
                    }
                    else {
                        gameState.gameIsRunning = false
                        timer.upstream.connect().cancel()
                        isJumpedtoGameView = true
                    }
                }
               
                
            }
        } .onAppear {
            audioPlayer.playLoseSound()
        }
        
    }
}

//#Preview {
//    GameOverView()
//}

