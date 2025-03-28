//
//  ModelContainerHelper.swift
//  MemorizeIt
//
//  Created by Hans Arthur Cupiterson on 21/02/25.
//

import Foundation
import SwiftData

class ModelContainerHelper {
    static func create() -> ModelContainer {
        let schema = setSchema()
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)
        
        do {
            let container = try ModelContainer(for: schema, configurations: modelConfiguration)
            return container
        } catch {
            fatalError("Could not create the Model Container: \(error)")
        }
    }
    
    private static func setSchema() -> Schema {
        return .init([
            ScoreSchema.self
        ])
    }
}
