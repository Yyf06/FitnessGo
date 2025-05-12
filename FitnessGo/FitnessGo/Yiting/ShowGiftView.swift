//
//  SpinsView.swift
//  Fitness Go
//
//  Created by 郭奕婷 on 16/9/2024.
//

import SwiftUI

struct ShowGiftView: View {
    @EnvironmentObject var spinItemsModel: SpinItemsModel
       let colorName: String

       var body: some View {
           GeometryReader { geometry in
               if let cardImage = spinItemsModel.lastSpunCard {
                   Image(cardImage)
                       .resizable()
                       .scaledToFill()
                       .frame(width: 270, height: 300)
                       .frame(maxWidth: .infinity, alignment: .center)
               } else {
                   Text("No card spun yet")
                       .frame(width: 270, height: 300)
                       .frame(maxWidth: .infinity, alignment: .center)
               }
           }
       }
   }

#Preview {
    ShowGiftView(colorName: "Red")
           .environmentObject(SpinItemsModel())
}
