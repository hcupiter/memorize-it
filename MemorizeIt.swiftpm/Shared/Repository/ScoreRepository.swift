////
////  ScoreRepository.swift
////  MemorizeIt
////
////  Created by Hans Arthur Cupiterson on 21/02/25.
////
//
//import Foundation
//import SwiftData
//
//protocol ScoreRepository: Sendable {
//    func fetch(_ id: UUID) async -> Result<ScoreSchema, Error>
//    func fetchScores() async -> Result<[ScoreSchema], Error>
//    func saveScore(_ score: ScoreSchema) async -> Result<Void, Error>
//    func deleteScore(_ id: UUID) async -> Result<Void, Error>
//}
//
//
//struct LocalScoreRepository: ScoreRepository {
//    let modelContext: ModelContext
//    
//    func fetchScores() async -> Result<[ScoreSchema], Error> {
//        guard let context = modelContext else {
//            return .failure(SwiftDataError.failed("[ERROR]: Model Context not found"))
//        }
//        
//        do {
//            let descriptor = FetchDescriptor<ScoreSchema>()
//            let result = try context.fetch(descriptor)
//            return .success(result)
//        }
//        catch {
//            return .failure(error)
//        }
//    }
//    
//    func fetch(_ id: UUID) async -> Result<ScoreSchema, any Error> {
//        guard let context = modelContext else {
//            return .failure(SwiftDataError.failed("[ERROR]: Model Context not found"))
//        }
//        
//        do {
//            let descriptor = FetchDescriptor<ScoreSchema>(
//                predicate: #Predicate { $0.scoreID == id}
//            )
//            if let result = try context.fetch(descriptor).first {
//                return .success(result)
//            }
//            return .failure(SwiftDataError.notFound())
//        }
//        catch {
//            return .failure(error)
//        }
//    }
//    
//    func saveScore(_ score: ScoreSchema) async -> Result<Void, Error> {
//        guard let context = modelContext else {
//            return .failure(SwiftDataError.failed("[ERROR]: Model Context not found"))
//        }
//        
//        do {
//            context.insert(score)
//            try context.save()
//            return .success(())
//        }
//        catch {
//            return .failure(error)
//        }
//    }
//    
//    func deleteScore(_ id: UUID) async -> Result<Void, Error> {
//        guard let context = modelContext else {
//            return .failure(SwiftDataError.failed("[ERROR]: Model Context not found"))
//        }
//        
//        do {
//            switch await fetch(id) {
//            case .success(let score):
//                context.delete(score)
//                try context.save()
//                return .success(())
//            case .failure(_):
//                return .failure(SwiftDataError.notFound())
//            }
//        }
//        catch {
//            return .failure(error)
//        }
//    }
//}
