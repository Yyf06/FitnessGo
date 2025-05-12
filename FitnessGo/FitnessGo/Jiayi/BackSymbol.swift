//
//  BackSymbol.swift
//  FitnessGo
//
//  Created by Michael on 4/9/2024.
//

import SwiftUI

struct BackSymbol: View {
    @State private var isBack = false
    var body: some View {
        HStack {
            Button(action: {
                isBack = true
            }) {
                Image(systemName: "chevron.left")
                    .font(.system(size: 35))
                    .foregroundColor(.black)
            }
            .padding(.leading)
            Spacer()
                .fullScreenCover(isPresented: $isBack, content: {
                    HealthView()
                })
                    
                
        }
    }
}

#Preview {
    BackSymbol()
}


