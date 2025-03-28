//
//  LabelBackgroundShape.swift
//  MemorizeIt
//
//  Created by Hans Arthur Cupiterson on 11/02/25.
//

import SwiftUI

struct LabelBackgroundShape: Shape {
    func path(in rect: CGRect) -> Path {
        RoundedRectangle(cornerRadius: 6)
            .path(in: rect)
    }
}
