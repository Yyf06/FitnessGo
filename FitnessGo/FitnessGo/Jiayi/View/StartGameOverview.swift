//
//  StartGameOverview.swift
//  FitnessGo
//
//  Created by Jiayi on 5/9/2024.
//

import SwiftUI

struct StartGameOverview: View {
    var body: some View {
        NavigationView {
            VStack {
                GameStartTitle() // Game title section
                PlayGamePage() // Play game section
                Line() // Line separator
                NavbarGame() // Bottom navigation bar for game
            }
        }
    }
}

#Preview {
    StartGameOverview()
}
