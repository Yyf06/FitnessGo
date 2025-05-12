//
//  SpinItemsModel.swift
//  habit
//
//  Created by Yufei Yao on 18/9/2024.
//

import SwiftUI

class SpinItemsModel: ObservableObject {
    @Published var spunItems: [BagItem] = []
    @Published var lastSpunCard: String?
    @Published var equippedItems: [BagItem] = []
    @Published var bagItems: [BagItem] = []
    @Published var johnEquipment: [BagItem] = []
    @Published var alertMessage: String?
    
    init() {
        generateRandomEquipmentForJohn()
    }
    //mapping color to cards
    let colorCards: [String: [String]] = [
        "Red": ["Card drink1", "Card pants1", "Card shoes1", "Card wear1"],
        "Blue": ["Card drink2", "Card pants2", "Card shoes2", "Card wear2"],
        "Green": ["Card drink3", "Card pants3", "Card shoes3", "Card wear3"]
    ]
    //mapping cards to equipment images
    let bagImageMapping: [String: String] = [
        "Card drink1": "energy_drink3",
        "Card pants1": "shorts",
        "Card shoes1": "sneaker",
        "Card wear1": "shirt",
        "Card drink2": "energy_drink2",
        "Card pants2": "pants",
        "Card shoes2": "boots",
        "Card wear2": "hoodie",
        "Card drink3": "energy_drink",
        "Card pants3": "jeans",
        "Card shoes3": "high_heels",
        "Card wear3": "jacket"
    ]
    //assign values to each equipment type
    let itemValues: [String: Int] = [
           "Card drink1": 3, "Card pants1": 3, "Card shoes1": 3, "Card wear1": 3,
           "Card drink2": 2, "Card pants2": 2, "Card shoes2": 2, "Card wear2": 2,
           "Card drink3": 1, "Card pants3": 1, "Card shoes3": 1, "Card wear3": 1
       ]
    //Define categories
    enum ItemCategory: String {
        case shoe, pants, shirt, drink
    }
 
    //add a spun item to users bag
    func addItem(color: String) {
        guard let cards = colorCards[color], !cards.isEmpty else { //get cards from spun color
            print("no cards for color: \(color)")
            return
        }
        
        let randomCard = cards.randomElement()! //get a random card from spun color
        lastSpunCard = randomCard
        let bagImage = bagImageMapping[randomCard] ?? randomCard
        let value = itemValues[randomCard] ?? 1
        let newItem = BagItem(cardImage: randomCard, bagImage: bagImage, color: colorForString(color), value: value)
        bagItems.append(newItem)
        spunItems.append(newItem)

    }
    // equip an item from the bag
    func equipItem(_ item: BagItem) {
        if equippedItems.count < 4 {
        let category = getCategoryForItem(item)
            // at most one item from category other than drink
            if category == .drink || !equippedItems.contains(where: {getCategoryForItem($0) == category}) {
                    if let index = bagItems.firstIndex(where: { $0.id == item.id }) {
                        let equippedItem = bagItems.remove(at: index) //remove from bag
                        equippedItems.append(equippedItem) //move to equipmentlist
                    }
                } else {
                    alertMessage = "Cannot equip more than one item from the same category"
                }
            } else {
                alertMessage = "Cannot equip more than 4 items"
            }
      }
    // Determine items' categories from item image names
    func getCategoryForItem(_ item: BagItem) -> ItemCategory {
        if item.bagImage.contains("pants") || item.bagImage.contains("shorts") || item.bagImage.contains("jeans") {
            return .pants
        } else if item.bagImage.contains("shoes") || item.bagImage.contains("sneaker") || item.bagImage.contains("boots") || item.bagImage.contains("high_heels") {
            return .shoe
        } else if item.bagImage.contains("shirt") || item.bagImage.contains("hoodie") || item.bagImage.contains("jacket") {
            return .shirt
        } else {
            return .drink
        }
    }
    //unselect item and return to bag
    func unequipItem(_ item: BagItem) {
        if let index = equippedItems.firstIndex(where: { $0.id == item.id }) {
            let unequippedItem = equippedItems.remove(at: index)
            bagItems.append(unequippedItem)
        }
    }
    
    //random border color for equipped items
    func colorForString(_ colorString: String) -> Color {
        let colors: [Color] = [.blue, .red, .yellow, .green, .orange, .purple, .pink]
        return colors.randomElement() ?? .gray
    }
    
    //Calculate total values of equipments
    func calculateTotalEquippedValue() -> Int {
           return equippedItems.reduce(0) { $0 + $1.value }
       }
    // random selection of equipment for bot
    func generateRandomEquipmentForJohn() {
           johnEquipment.removeAll()
           let allCards = colorCards.values.flatMap { $0 }
           
           while johnEquipment.count < 4 {
               if let randomCard = allCards.randomElement(),
                  let bagImage = bagImageMapping[randomCard],
                  let value = itemValues[randomCard] {
                   let color = colorForString(colorCards.first(where: { $0.value.contains(randomCard) })?.key ?? "")
                   let newItem = BagItem(cardImage: randomCard, bagImage: bagImage, color: color, value: value)
                   johnEquipment.append(newItem)
               }
           }
       }
    
//calculate score
    func getScore() -> (johnScore: Int, playerScore: Int) {
        let johnScore = johnEquipment.reduce(0) { $0 + $1.value }
        let playerScore = equippedItems.reduce(0) { $0 + $1.value }

        return (johnScore, playerScore)
    }
  // get game result based on score
    func getResult() -> Int{
        let scores = getScore()
        let johnScore = scores.johnScore
        let playerScore = scores.playerScore
       
        print("John's score: \(johnScore)")
        print("Player's score: \(playerScore)")

        if playerScore >= johnScore {
            print("should congrats")
            return 1
           
       
        } else {
            print("should cry")
            return 0

        }
   }
    // clear euipment after each game
    func clearEquipment() {
            equippedItems.removeAll()
        }
}
