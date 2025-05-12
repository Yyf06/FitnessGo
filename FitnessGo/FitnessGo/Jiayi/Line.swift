//
//  Line.swift
//  FitnessGo
//
//  Created by Michael on 5/9/2024.
//

import SwiftUI

struct Line: View {
    var body: some View {
        Path { path in
            path.move(to: CGPoint(x: -100, y:0))
            path.addLine(to: CGPoint(x: 500, y: 0))
        }
        .stroke(Color(red: 0/255, green: 0/255, blue: 0/255 ,opacity: 0.42), lineWidth: 2)
        .frame(height: 10)
        
    }
}

#Preview {
    Line()
}
