//
//  Stock.swift
//  MemorizeIt
//
//  Created by Hans Arthur Cupiterson on 17/01/25.
//

import Foundation

struct Stock {
    let id: UUID
    let item: Item
    var quantity: Int
}

extension Stock {
    static func mock() -> [Stock] {
        return [
            .init(id: UUID(), item: .data[0], quantity: 3),
            .init(id: UUID(), item: .data[1], quantity: 2),
            .init(id: UUID(), item: .data[2], quantity: 1)
        ]
    }
    
    static func setup() -> [Stock] {
        return [
            .init(id: UUID(), item: .data[0], quantity: 10),
            .init(id: UUID(), item: .data[1], quantity: 5)
        ]
    }
    
    static func generateRandomStock() -> [Stock] {
        var stocks: [Int:Stock] = [:] // Item ID : Stock
        let itemTypeQuantity = Int.random(in: 0...5)
        for _ in 0...itemTypeQuantity {
            let randomItem = Item.getRandomItem()
            let randomQuantity: Int = weightedRandomNumber()
            
            if stocks[randomItem.id] == nil {
                stocks[randomItem.id] = .init(id: UUID(), item: randomItem, quantity: randomQuantity)
            }

        }
        
        return Array(stocks.values.sorted(by: {
            $0.id < $1.id
        }))
    }
    
    static private func weightedRandomNumber() -> Int {
        // Define the numbers and their corresponding weights
        let numbers = Array(1...10)
        let weights = numbers.map { 11 - $0 } // Inverse weights: 10 for 1, 9 for 2, ..., 1 for 10
        
        // Calculate the cumulative weights
        var cumulativeWeights = [Int]()
        var sum = 0
        for weight in weights {
            sum += weight
            cumulativeWeights.append(sum)
        }
        
        // Generate a random number between 1 and the total sum of weights
        let randomValue = Int.random(in: 1...cumulativeWeights.last!)
        
        // Find the index of the first cumulative weight that is greater than or equal to the random value
        if let index = cumulativeWeights.firstIndex(where: { $0 >= randomValue }) {
            return numbers[index]
        }
        
        // Fallback, should not happen
        return numbers.last!
    }
    
    
}
