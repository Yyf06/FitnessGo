//
//  LandmarkRow.swift
//  FitnessGo
//
//  Created by Michael on 7/9/2024.
//
import Foundation
import SwiftUI

struct LandmarkRow: View {
    var landmark: Landmark


       var body: some View {
           HStack {
               landmark.image
                   .resizable()
                   .frame(width: 50, height: 50)
               Text(landmark.name)


               Spacer()
           }
       }
   }


#Preview {
    Group {
        LandmarkRow(landmark: landmarks[0])
        LandmarkRow(landmark: landmarks[1])
    }
}
