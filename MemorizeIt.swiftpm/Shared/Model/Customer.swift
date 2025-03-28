//
//  Customer.swift
//  MemorizeIt
//
//  Created by Hans Arthur Cupiterson on 17/01/25.
//

import Foundation

struct Customer {
    let id: UUID
    var name: String
    var requestList: [Stock]
    let dateAppear: Date
}

extension Customer {
    static func mock() -> [Customer] {
        return [
            .init(
                id: UUID(),
                name: "James",
                requestList: [
                    .mock()[0]
                ],
                dateAppear: Date.now.addingTimeInterval(-200)),
            .init(
                id: UUID(),
                name: "John",
                requestList: [
                    .mock()[0],
                    .mock()[1]
                ],
                dateAppear: Date.now.addingTimeInterval(-100)),
            .init(
                id: UUID(),
                name: "Joseph",
                requestList: [
                    .mock()[0],
                    .mock()[1],
                    .mock()[2]
                ],
                dateAppear: Date.now.addingTimeInterval(-50))
        ]
    }
    
    static func getRandomNames() -> String {
        let random = Int.random(in: 0..<customerNames.count)
        return customerNames[random]
    }
}

extension Customer {
    static var customerNames: [String] {
        return [
            "Aeliana", "Borin", "Caelum", "Daria", "Eldrin", "Fiona", "Grymthorn", "Hilary", "Ildra", "Jasper",
            "Kaela", "Lorin", "Mara", "Nathaniel", "Ophelia", "Paxton", "Quinn", "Ryanna", "Sylas", "Talara",
            "Uther", "Vespera", "Wylis", "Xandra", "Yarven", "Zephyr", "Aria", "Bryce", "Cassia", "Darius",
            "Elena", "Finn", "Gwen", "Hector", "Iris", "Jasper", "Kara", "Liam", "Mira", "Nico",
            "Olivia", "Pax", "Quinn", "Raven", "Sage", "Trent", "Ula", "Vex", "Wren", "Xena",
            "Yara", "Zane", "Aldric", "Bryn", "Cara", "Derek", "Elyra", "Finnegan", "Giselle", "Harken",
            "Izzy", "Jasper", "Kendra", "Lysander", "Mara", "Nevan", "Ophelia", "Paxton", "Quinn", "Ryanna",
            "Sylas", "Talara", "Uther", "Vespera", "Wylis", "Xandra", "Yarven", "Zephyr", "Aria", "Bryce",
            "Cassia", "Darius", "Elena", "Finn", "Gwen", "Hector", "Iris", "Jasper", "Kara", "Liam",
            "Mira", "Nico", "Olivia", "Pax", "Quinn", "Raven", "Sage", "Trent", "Ula", "Vex", "Wren", "Xena",
            "Yara", "Zane", "Aldric", "Bryn", "Cara", "Derek", "Elyra", "Finnegan", "Giselle", "Harken"
        ]
    }
}
