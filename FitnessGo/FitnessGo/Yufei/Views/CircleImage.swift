//
//  CircleImage.swift
//  FitnessGo
//
//  Created by Michael on 7/9/2024.
//



import SwiftUI

//struct hair: View {
//    var body: some View {
//        Image("turtlerock")
//
//            .resizable() // Allows the image to be resized
//            .scaledToFit() // Keeps the aspect ratio intact while fitting within the specified frame
//            .frame(width: 100, height: 100) // Set the size of the image
//            .clipShape(Circle())
//            .overlay {
//                    Circle().stroke(.white, lineWidth: 4)
//                        }
//            .shadow(radius: 7)
//    }
//
//
//}
//
//struct lake: View {
//    var body: some View {
//        Image("hiddenlake")
//
//            .resizable() // Allows the image to be resized
//            .scaledToFit() // Keeps the aspect ratio intact while fitting within the specified frame
//            .frame(width: 100, height: 100) // Set the size of the image
//            .clipShape(Circle())
//            .overlay {
//                    Circle().stroke(.white, lineWidth: 4)
//                        }
//            .shadow(radius: 7)
//    }
//
//
//}
//
//#Preview {
//    hair()
//
//}
import SwiftUI


struct CircularImageView: View {
    var imageName: String
    var size: CGFloat
    
    var body: some View {
        Image(imageName)
            .resizable()
            .scaledToFit()
            .frame(width: size, height: size)
            .clipShape(Circle())
            .overlay {
                Circle().stroke(Color.white, lineWidth: 4)
            }
            .shadow(radius: 7)
    }
}

struct CircularImageView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            CircularImageView(imageName: "turtlerock", size: 100)
            CircularImageView(imageName: "hiddenlake", size: 100)
        }
        .previewLayout(.sizeThatFits)
    }
}

