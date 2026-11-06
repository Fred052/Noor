//
//  PersonalizeViewModel.swift
//  Noor
//
//  Created by Ferid Suleymanzade on 06.11.26.
//

import Foundation

class PersonalizeViewModel {

    var onSelectionChanged: (() -> Void)?

    private let interests: [InterestModel] = [
        InterestModel(title: "Read the Quran", iconName: "book"),
        InterestModel(title: "Understand the meaning", iconName: "lightbulb"),
        InterestModel(title: "Listen to recitation", iconName: "headphones"),
        InterestModel(title: "Memorize verses", iconName: "seal"),
        InterestModel(title: "Build a daily habit", iconName: "calendar")
    ]

    private(set) var selectedIndexes: Set<Int> = [0, 2, 4]

    var numberOfInterests: Int {
        return interests.count
    }

    var selectedInterests: [InterestModel] {
        return interests.enumerated()
            .filter { selectedIndexes.contains($0.offset) }
            .map { $0.element }
    }

    func interest(at index: Int) -> InterestModel {
        return interests[index]
    }

    func isSelected(at index: Int) -> Bool {
        return selectedIndexes.contains(index)
    }

    func toggleInterest(at index: Int) {
        if selectedIndexes.contains(index) {
            selectedIndexes.remove(index)
        } else {
            selectedIndexes.insert(index)
        }
        onSelectionChanged?()
    }
}
