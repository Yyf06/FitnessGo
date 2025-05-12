//
//  RunRace.swift
//  FitnessGo
//
//  Created by Michael on 14/9/2024.
//

import SwiftUI
import SpriteKit

struct RunRace: View {
    @State private var showGameScene = false

        var body: some View {
            VStack {
                Button("Play Game") {
                    showGameScene = true
                }
                .sheet(isPresented: $showGameScene) {
                    GameViewControllerRepresentable()
                }
            }
        }
}


#Preview {
    RunRace()
}
