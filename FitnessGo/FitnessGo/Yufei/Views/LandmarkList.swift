//
//  LandmarkList.swift
//  FitnessGo
//
//  Created by Michael on 7/9/2024.
//


import Foundation

import SwiftUI

struct LandmarkList: View {
    var body: some View {
        List(landmarks) { landmark in
            LandmarkRow(landmark: landmark)
        }
    }
}


#Preview {
    LandmarkList()
}


