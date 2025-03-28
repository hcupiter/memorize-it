//
//  TimeConverter.swift
//  MemorizeIt
//
//  Created by Hans Arthur Cupiterson on 25/01/25.
//

enum TimeUnit {
    case second
    case minute
    case hour
    case day
}

struct TimeConverter {
    static func convert(_ time: Int, from: TimeUnit, to: TimeUnit) -> Int {
        // Conversion factors relative to 1 second
        let factors: [TimeUnit: Int] = [
            .second: 1,
            .minute: 60,
            .hour: 3600,
            .day: 86400
        ]
        
        // Get the conversion factors for the given units
        guard let fromFactor = factors[from],
              let toFactor = factors[to] else {
            return -1
        }
        
        let timeInSeconds = time * fromFactor
        return timeInSeconds / toFactor
    }
}
