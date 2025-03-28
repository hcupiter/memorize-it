//
//  Item.swift
//  MemorizeIt
//
//  Created by Hans Arthur Cupiterson on 17/01/25.
//

struct Item {
    let id: Int
    let name: String
    let imageName: String
    let price: Int
}

extension Item {
    static var data: [Item] {
        return [
            .init(id: 1, name: "Glass Of Water", imageName: "glass-water", price: 1),
            .init(id: 2, name: "Banana", imageName: "banana", price: 5),
            .init(id: 3, name: "Apple", imageName: "apple", price: 5),
            .init(id: 4, name: "Pencil", imageName: "pencil", price: 10),
            .init(id: 5, name: "Tissue Box", imageName: "tissue-box", price: 15),
            .init(id: 6, name: "Book", imageName: "book", price: 20),
            .init(id: 7, name: "Milk", imageName: "milk", price: 40),
            .init(id: 8, name: "Coke", imageName: "coke", price: 60),
            .init(id: 9, name: "Iphone", imageName: "iphone", price: 100),
            .init(id: 10, name: "Diamond", imageName: "diamond", price: 250),
        ]
    }
    
    static func getRandomItem() -> Item {
        // Calculate weights inversely proportional to the price
        var weights: [Double] = data.map { 1.0 / Double($0.price) }
        
        // Normalize weights to sum up to 1
        let totalWeight = weights.reduce(0, +)
        weights = weights.map { $0 / totalWeight }
        
        // Generate a random number between 0 and 1
        let randomValue = Double.random(in: 0..<1)
        
        // Select the item based on the random value and weights
        var cumulativeWeight = 0.0
        for (index, weight) in weights.enumerated() {
            cumulativeWeight += weight
            if randomValue < cumulativeWeight {
                return data[index]
            }
        }
        
        // Fallback to the last item if something goes wrong (should not happen)
        return data[0]
    }
    
}
