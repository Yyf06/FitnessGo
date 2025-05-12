//
//  WinView.swift
//  FitnessGo
//
//  Created by Michael on 7/9/2024.
//

import SwiftUI

struct WinView: View {
    @ObservedObject var gameState: GameStateManager
    @State private var isJumpedtoGameViewWIN = false
    @State private var timeremain = 5
    @State private var isAgain = false
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    let audioPlayer = AudioPlayerClass()
 
    var body: some View {
        NavigationView {
            ZStack {
                GeometryReader{
                    geometry in
                    
                    VStack{
                        ZStack{
                            Image("winbackground")
                                .scaledToFill()
                                .frame(width: geometry.size.width * 0.8,height: geometry.size.height)
                            VStack{
                                Image("trophy")
                                Text("Congratulations")
                                    .background(.yellow)
                                    .font(.system(size: 40))
                                    .foregroundColor(.white)
                                    .padding()
                                
                            }
                            ZStack{
                                Rectangle()
                                
                                    .fill(Color(red: 246/255, green: 243/255, blue: 176/255))
                                    .cornerRadius(30)
                                    .frame(width: geometry.size.width * 0.9,height: geometry.size.height * 0.3)
                                
                                VStack {
                                    HStack {
                                        Spacer()
                                        VStack(spacing:50){
                                            Text("LV.8")
                                                .frame(width: 50, alignment: .leading)
                                            
                                            Text("LV.9")
                                                .frame(width: 50, alignment: .leading)
                                        }
                                        
                                        Spacer()
                                        
                                        VStack(spacing:50){
                                            Rectangle()
                                                .fill(Color(red: 27/255, green: 163/255, blue: 100/255).opacity(0.4))
                                                .frame(width: 150, height: 30)
                                            
                                            Rectangle()
                                                .fill(Color(red: 27/255, green: 163/255, blue: 100/255).opacity(0.4))
                                                .frame(width: 50, height: 30)
                                        }
                                        
                                        Spacer()
                                    }
                                    Divider().background(.gray)
                                    
                                    
                                    Text("Level up by 1 level")
                                    
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
                                .position(x:geometry.size.width/2,y:geometry.size.height * 0.5)
                                
                            }.position(x:geometry.size.width/2,y:geometry.size.height * 0.8)
                            
                            NavigationLink(destination: StartGameOverview().navigationBarBackButtonHidden(), isActive: $isJumpedtoGameViewWIN) {
                                EmptyView()
                            }
                            
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
                        isJumpedtoGameViewWIN = true
                    }
                }
            }
        }.onAppear {
            audioPlayer.playWinSound()}
        }
}

//#Preview {
//    WinView()
//}
