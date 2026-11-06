//
//  GoalsViewModel.swift
//  Noor
//
//  Created by Ferid Suleymanzade on 06.11.26.
//

import Foundation

class GoalsViewModel {
    
    var onSelectionChanged: (() -> Void)?
    
    private let goals: [GoalModel] = [
        GoalModel(minutes: 5,
                  title: "5 minutes a day",
                  detail: "A gentle start. A few verses, at your pace",
                  progress: 0.25),
        GoalModel(minutes: 10,
                  title: "10 minutes a day",
                  detail: "Time to read and reflect on what you read.",
                  progress: 0.5),
        GoalModel(minutes: 20,
                  title: "20 minutes a day",
                  detail: "Room to read, listen, and study the meaning.",
                  progress: 1.0)
    ]
    
    private(set) var selectedIndex = 1
    
    var numberOfGoals: Int {
        return goals.count
    }
    
    var selectedGoal: GoalModel {
        return goals[selectedIndex]
    }
    
    func goal(at index: Int) -> GoalModel {
        return goals[index]
    }
    
    func isSelected(at index: Int) -> Bool {
        return index == selectedIndex
    }
    
    func selectGoal(at index: Int) {
        selectedIndex = index
        onSelectionChanged?()
    }
}


