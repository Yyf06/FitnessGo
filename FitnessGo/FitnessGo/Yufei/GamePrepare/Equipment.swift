//
//  Equipment.swift
//  habit
//
//  Created by Yufei Yao on 18/9/2024.
//

import SwiftUI


struct Equipment: View {
    @State private var isGame = false
    @State private var gameResult: Int?

    @EnvironmentObject var spinItemsModel: SpinItemsModel
    @EnvironmentObject var checkboxModel: CheckboxModel
    
    //check box for dark pattern
    struct iOSCheckboxToggleStyle: ToggleStyle {
        
        func makeBody(configuration: Configuration) -> some View {
            // 1
            Button(action: {

                // 2
                configuration.isOn.toggle()

            }, label: {
                HStack {
                    // 3
                    Image(systemName: configuration.isOn ? "checkmark.square" : "square")
                        .foregroundColor(Color(hex: "#d9d1b4"))
                    configuration.label
                }
            })
        }
    }

    var body: some View {
        NavigationView {
            VStack {
                VStack(spacing: 20) {
                    //header
                    HStack {
                        Spacer()
                        Text("Game Prepare")
                            .font(.headline)
                            .offset(y: 25)
                        Spacer()
                    }
                    .padding(.horizontal)
                    .fullScreenCover(isPresented: $isGame, content: {
                        RunGame()
                       
                    })
                    // game start area with player avatars
                    ZStack {
                        Image("road")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(height: 300)
                            .offset(y: 30)
                        
                        
                        HStack {
                            PlayerAvatar(name: "John", imageName: "run_b")
                            Spacer()
                            PlayerAvatar(name: "Me", imageName: "run_g")
                        }
                        
                        .padding(.horizontal)
                        .offset(y:-10)
                        
                        
                        Button("Start") {
                            guard !isGame else { return }
                            //                    spinItemsModel.clearEquipment()
                            isGame = true
                           
                        }
                        .padding()
                        .background(Color.black)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .offset(y: 40)
                        .disabled(isGame)
                    }
                    
                    // equipment grids for players
                    VStack {
                        
                        // John's equipment grid
                        HStack {
                            EquipmentGrid(
                                title: "John",
                                items: spinItemsModel.johnEquipment,
                                onItemTap: { _ in },
                                totalValue: spinItemsModel.johnEquipment.reduce(0) { $0 + $1.value }, showTotal: false, showEyeSlash: true
                            )
                            Spacer()
                            // user's equipment grid
                            EquipmentGrid(
                                title: "Me",
                                items: spinItemsModel.equippedItems,
                                onItemTap: spinItemsModel.unequipItem,
                                totalValue: spinItemsModel.calculateTotalEquippedValue(), showTotal: true, showEyeSlash: false
                                
                            )
                            
                            Spacer()
                            
                        }
                        Spacer()
                        // checkbox for spending coins
                        HStack {
                            Toggle(isOn: $checkboxModel.isOn) {
                                Text("I'm willing to spend 5 coins to look cool")
                                    .foregroundColor(Color(hex: "#d9d1b4"))
                            }
                            .toggleStyle(iOSCheckboxToggleStyle())
                            Spacer()
                        }
                    }
                    .padding(.horizontal)
                    .offset(x:10, y: -60)
                    // alert for equipment selection
                    //messages
                    .alert(item: Binding<AlertItem?>(
                        get: { spinItemsModel.alertMessage.map { AlertItem(message: $0) } },
                        set: { _ in spinItemsModel.alertMessage = nil }
                    )) { alertItem in
                        Alert(title: Text("Alert"), message: Text(alertItem.message), dismissButton: .default(Text("OK")))}
                    
                    // Bag
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Bag")
                            .font(.headline)
                        LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 6), spacing: 10) {
                            ForEach(spinItemsModel.bagItems) { item in
                                BagItemView(item: item) {_ in
                                    spinItemsModel.equipItem(item)
                                }
                            }
                            ForEach(spinItemsModel.bagItems.count..<12, id: \.self) { _ in
                                BagItemView(item: nil, onTap: {_ in })
                            }
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color(hex: "#D1EDE5"))
                    .cornerRadius(10)
                    //                     .offset(y:-8)
                }.background(Color(hex: "#F1FBCA"))
                
                NavbarGame()

                
            }
        }
    }
    //clear all equipped items
    private func clearEquipmentFromGrid() {
           spinItemsModel.equippedItems.removeAll()
       }
         }


// view for displaying a player avatar
    struct PlayerAvatar: View {
        let name: String
        let imageName: String
        
        var body: some View {
            VStack {
                Text(name)
                    .font(.system(size: 18, weight: .bold))
                    .foregroundColor(.white)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(Color.black.opacity(0.6))
                    .cornerRadius(10)
                    .offset(y:-30)
                Image(imageName)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 200)
                    .offset(y:-40)
            }
        }
    }
// alert message 
    struct AlertItem: Identifiable {
        let id = UUID()
        let message: String
    }
    

    

#Preview {
    Equipment()
        .environmentObject(SpinItemsModel())
        .environmentObject(CheckboxModel())
}
