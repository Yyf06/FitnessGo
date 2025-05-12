//
//  HealthData.swift
//  FitnessGo
//
//  Created by Jiayi on 3/9/2024.
//

import SwiftUI

// Main view to display health data using the StepCountManager to fetch information
struct HealthData: View {
    @StateObject private var stepCountManager = StepCountManager()
    
    var body: some View {
        
        // Use GeometryReader to calculate layout sizes dynamically based on screen size
        GeometryReader { geometry in
            let boxWidth = geometry.size.width /  4
            let boxHeight = boxWidth * 1.5
            VStack(spacing:20) {
                HStack(spacing:20){
                    
                    // Display a small box for Sleep data
                    smallbox(title: "Sleep", variable: String(format: "%.1f", stepCountManager.sleepHours), value: "H", image: "sleep", width: boxWidth, height: boxHeight)
                    
                    // Display a small box for Rank (static rank value for now)
                    smallbox(title: "Rank", variable: "2", value: " ", image: "rank", width: boxWidth, height: boxHeight)
                    
                }
                .padding([.leading, .trailing, .top], 15)
                
                // Second row: Distance and Energy boxes
                HStack(spacing:20){
                    
                    // Display a small box for Distance data
                    smallbox(title: "Distance", variable: String(format: "%.1f", stepCountManager.runningDistance), value: "KM", image: "distance", width: boxWidth, height: boxHeight)
                    
                    // Display a small box for Energy data
                    smallbox(title: "Energy",
                        variable: String(format: "%.0f", stepCountManager.activeEnergy),
                        value: "kcal",
                        image: "run",
                        width: boxWidth,
                        height: boxHeight
                    )
                }
                .padding([.leading, .trailing, .bottom], 15)
                
                // When the view appears, request health data permissions and update health metrics
            }.onAppear { stepCountManager.requestAuthorization()
                stepCountManager.updateStepCount()
                stepCountManager.updateSleepHours()
                stepCountManager.updateRunningDistance()
            }
        }
        

        
            
            
        
        
        
    }
    func smallbox(title: String, variable: String, value: String, image: String, width: CGFloat, height: CGFloat) -> some View {
       
        VStack {
            HStack {
                VStack() {
                    Text(title)
                        .font(.title2)
                        .fontWeight(.regular)
                        .foregroundColor(Color(hex: "#1BA37D"))
                        .frame(alignment: .leading)
                        .padding(.trailing)

                    HStack {
                        Text(variable)//Need change to real hour health API
                            .font(.title)
                            .fontWeight(.medium)
                            .multilineTextAlignment(.center)
                            .padding(.leading,  20)
                            .padding(.top, 10)
                        Text(value)
                            .font(.title3)
                            .fontWeight(.medium)
                            .padding(.top, 10)
                            
                            
                            
                    }
                }
                Spacer()
            }
            HStack {
                Image(image)
                    .resizable()
                    .frame(width: 40.0, height: 40.0)
                    .padding(.leading, 95)
            }
        }
            
        
        .padding()
        .overlay(
            RoundedRectangle(cornerRadius: 30)
                .fill(Color(red: 27/255, green: 163/255, blue: 125/255 ,opacity: 0.12))
            
            
        )
        
        
       
        
        
        
        
    
        
    }
}

#Preview {
    HealthData()
}
