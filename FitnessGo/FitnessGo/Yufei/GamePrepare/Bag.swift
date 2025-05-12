//
//  Bag.swift
//  FitnessGo
//
//  Created by Yufei Yao on 15/10/2024.
//

import Foundation
import SwiftUI


// represents an item that can be equipped or stored in the bag
struct BagItem: Identifiable {
    let id = UUID()
    let cardImage: String
    let bagImage: String
    let color: Color
    var selected: Bool = false
    let value: Int
}
 
// view for displaying a single bag item
struct BagItemView: View {
    @EnvironmentObject var spinItemsModel: SpinItemsModel
    let item: BagItem?
    let onTap: (BagItem) -> Void 
    
    var body: some View {
            if let item = item {
                ZStack {
                       Image(item.bagImage)
                           .resizable()
                           .scaledToFit()
                           .padding(5)
                       Text("\(item.value)")
                           .font(.caption)
                           .fontWeight(.bold)
                           .foregroundColor(.white)
                           .padding(4)
                           .background(Circle().fill(Color.black.opacity(0.7)))
                           .position(x: 50, y: 10)
                   }
                   .overlay(
                       RoundedRectangle(cornerRadius: 5)
                           .stroke(item.color, lineWidth: 2)
                   )
                    .onTapGesture {onTap(item) //move item to equipment grid
                                        }
            } else {
                //empty view
                Rectangle()
                    .fill(Color.gray.opacity(0.3))
                    .aspectRatio(1, contentMode: .fit)
            }
        }
    
    
   }
