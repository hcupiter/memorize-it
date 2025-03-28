//
//  Color+ToHex.swift
//  MemorizeIt
//
//  Created by Hans Arthur Cupiterson on 17/01/25.
//

import SwiftUI

extension Color {
    static func fromHex(_ hex: String) -> Color {
        // Ensure the string is valid and remove any leading '#' or '0x'
        let hexString = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        
        // Ensure we have a valid 6 or 8 character hex code
        guard hexString.count == 6 || hexString.count == 8 else {
            return Color.clear // Return a clear color for invalid hex strings
        }
        
        // Extract RGB components
        var int: UInt64 = 0
        Scanner(string: hexString).scanHexInt64(&int)
        
        let r, g, b: Double
        if hexString.count == 6 {
            r = Double((int >> 16) & 0xFF) / 255.0
            g = Double((int >> 8) & 0xFF) / 255.0
            b = Double(int & 0xFF) / 255.0
        } else { // 8-character hex with alpha
            r = Double((int >> 24) & 0xFF) / 255.0
            g = Double((int >> 16) & 0xFF) / 255.0
            b = Double((int >> 8) & 0xFF) / 255.0
        }
        
        return Color(red: r, green: g, blue: b)
    }
}

