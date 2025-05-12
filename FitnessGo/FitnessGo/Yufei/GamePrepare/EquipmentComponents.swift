//
//  EquipmentComponents.swift
//  FitnessGo
//
//  Created by Yufei Yao on 15/10/2024.
//

import Foundation
import SwiftUI


//view for displaying a grid of equipped items
struct EquipmentGrid: View {
    let title: String
    let items: [BagItem]
    let onItemTap: (BagItem) -> Void
    let totalValue: Int?
    let showTotal: Bool
    let showEyeSlash: Bool

    
    let columns = [
           GridItem(.flexible(), spacing: 5),
           GridItem(.flexible(), spacing: 5)
       ]
    var body: some View {
           VStack(alignment: .leading, spacing: 5) {
               HStack {
                   Text(title)
                       .font(.system(size: 18, weight: .bold))
                   Spacer()
                   // display added total values for users
                   // hide from the bot
                   if showTotal, let total = totalValue {
                       Text("Total: \(total)")
                           .font(.caption)
                           .fontWeight(.bold)
                   } else {
                       // Placeholder text
                       Text(" ")
                           .font(.caption)
                   }
               }
               .padding(.bottom, 5)
               
               ZStack(alignment: .topLeading) {
                   LazyVGrid(columns: columns, spacing: 15) {
                       ForEach(0..<4) { index in
                           if index < items.count {
                               // Display an item if it exists
                               ItemView(item: items[index])
                                   .onTapGesture {
                                       onItemTap(items[index]) //allow tapping to unequip
                                   }
                           } else {
                               ItemView(item: nil)
                           }
                       }
                   }
                   // eyeslash to cover one of John's equipment
                   if showEyeSlash {
                       Image("eye")
                           .resizable()
                           .scaledToFit()
                           .frame(width: 60, height: 129)
                           .offset(x: 7, y: -39)
        
                   }
               }
           }
           .frame(width: 150)
       }
   }

//view for displaying one item in equipment grid
    struct ItemView: View {
        let item: BagItem?
        
        var body: some View {
            Group {
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
                    )} else {
                        Color.gray.opacity(0.3) //show grey if no item selected
                    }
            }
            .frame(width: 65, height: 55)
            .background(Color.white)
            .overlay(
                RoundedRectangle(cornerRadius: 5)
                    .stroke(item?.color ?? Color.gray.opacity(0.3), lineWidth: 2)
            )
        }
        
    }

