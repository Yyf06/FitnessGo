//
//  StepsExchange.swift
//  FitnessGo
//
//  Created by Jiayi on 3/9/2024.
//

import SwiftUI


// View to display and exchange steps for coins
struct StepsExchange: View {
    @EnvironmentObject var globalEnv: GlobalEnvironment
    @StateObject private var stepCountManager = StepCountManager()
    @State private var isExchange = false
    @State private var step: Int = 0
    @State private var coins: Int = 0
    @State private var refreshID = UUID()
    
    // Main view section
    var body: some View {
        HStack {
            Image("walk")
            .resizable()
            .scaledToFill()
            .frame(width: 100, height: 120, alignment: .center)
            .clipped()
            VStack {
                
                // step count display
                HStack {
                    Text("\(globalEnv.steps)") // Display steps from the global environment
                        .font(.title)
                        .fontWeight(.medium)
                        .foregroundColor(Color(hex: "#1BA37D"))
                    Text("steps")
                        .font(.headline)
                        .foregroundColor(Color(hex: "#1BA37D"))
                }
                
                // Coin count display
                HStack {
                    Text("\(globalEnv.coins)") // Display coins from the global environment
                        .font(.title)
                        .fontWeight(.medium)
                        .foregroundColor(Color(hex: "#1BA37D"))
                    Text("coins")
                        .font(.headline)
                        .foregroundColor(Color(hex: "#1BA37D"))
                }
                
            }
            Spacer()
            
            // Full-screen overlay for the exchange functionality
                .fullScreenCover(isPresented: $isExchange, content: {
                    ExchangeOverview()
                })
            
            // jump to ExchangeOverview() when click the button
            Button(action: {
                isExchange = true
                // exchange button
            }) {
                Image("exchangebutton")
                    .resizable()
                    .frame(width: 90.0, height: 40.0)
            }
        }.onAppear {
            }
        .padding(.leading)
        .background(Color(red: 27/255, green: 163/255, blue: 125/255 ,opacity: 0.12))
        
        .cornerRadius(30)
        .padding()
        
    }

}


#Preview {
    StepsExchange()
}
