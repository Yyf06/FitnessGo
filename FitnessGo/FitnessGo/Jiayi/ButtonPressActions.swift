//
//  ButtonPressActions.swift
//  FitnessGo
//
//  Created by Michael on 13/9/2024.
//

import Foundation
import SwiftUI

// Custom modifier to handle button press and release events
//  Written by SerialCoder.dev
struct ButtonPress: ViewModifier {
    var onPress: () -> Void
    var onRelease: () -> Void
    
    // Defines the body of the view modifier, adding a gesture to the content
    func body(content: Content) -> some View {
        content
            .simultaneousGesture(
                DragGesture(minimumDistance: 0)
                    .onChanged({ _ in
                        onPress()
                    })
                    .onEnded({ _ in
                        onRelease()
                    })
            )
    }
}

// Extension for the View to easily apply the ButtonPress modifier
//  Written by SerialCoder.dev
extension View {
    func pressEvents(onPress: @escaping (() -> Void), onRelease: @escaping (() -> Void)) -> some View {
        modifier(ButtonPress(onPress: {
            onPress()
        }, onRelease: {
            onRelease()
        }))
    }
}
