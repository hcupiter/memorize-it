//
//  TutorialViewModel.swift
//  MemorizeIt
//
//  Created by Hans Arthur Cupiterson on 20/02/25.
//

import Foundation

class TutorialViewModel: ObservableObject {
    @Published var currentPage: Int = 0
    @Published var tutorialList: [Tutorial] = []
    
    init(){
        tutorialList = Tutorial.data
    }
    
    func next() {
        if currentPage < tutorialList.count - 1 {
            currentPage += 1
        }
    }
    
    func previous() {
        if currentPage > 0 {
            currentPage -= 1
        }
    }
    
    func isPrevDisabled() -> Bool {
        if currentPage <= 0 {
            return true
        }
        return false
    }
    
    func isNextDisabled() -> Bool {
        if currentPage >= tutorialList.count - 1 {
            return true
        }
        return false
    }
    
}
