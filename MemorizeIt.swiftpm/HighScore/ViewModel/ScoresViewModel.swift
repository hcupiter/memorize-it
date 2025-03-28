//
//  ScoresViewModel.swift
//  MemorizeIt
//
//  Created by Hans Arthur Cupiterson on 19/02/25.
//

import Foundation
import SwiftData

class ScoresViewModel: ObservableObject {
    @Published var scoreList: [Score] = []
    
    func getScore(modelContext: ModelContext) {
        do {
            let descriptor = FetchDescriptor<ScoreSchema>()
            let result = try modelContext.fetch(descriptor)
            self.scoreList = result.map({ $0.mapToEntity() }).sorted(by: {
                $0.value >  $1.value
            })
        }
        catch {
            debugPrint(error)
        }
    }
}
