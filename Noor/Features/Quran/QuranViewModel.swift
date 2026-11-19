//
//  QuranViewModel.swift
//  Noor
//
//  Created by Ferid Suleymanzade on 19.11.26.
//

import Foundation

final class QuranViewModel {
    
    var success: (() -> Void)?
    
    private var allSurahs: [Surah] = []
    private var searchText = ""
    
    private(set) var surahs: [Surah] = []
    private(set) var selectedSortIndex = 0
    
    let sortOptions = SurahSort.allCases
    let segmentTitles = ["Surahs", "Juz", "Bookmarks"]
    
    var chipTitles: [String] { sortOptions.map { $0.title} }
    var currentSeachText: String { searchText }
    
    func load() {
        allSurahs = [
            Surah(number: 1, englishName: "Al-Fātiḥah", meaning: "The Opening", versesCount: 7, place: .meccan, arabicName: "الفاتحة", revelationOrder: 5),
            Surah(number: 2, englishName: "Al-Baqarah", meaning: "The Cow", versesCount: 286, place: .medinan, arabicName: "البقرة", revelationOrder: 87),
            Surah(number: 3, englishName: "Āl ʿImrān", meaning: "Family of Imran", versesCount: 200, place: .medinan, arabicName: "آل عمران", revelationOrder: 89),
            Surah(number: 4, englishName: "An-Nisāʾ", meaning: "The Women", versesCount: 176, place: .medinan, arabicName: "النساء", revelationOrder: 92),
            Surah(number: 5, englishName: "Al-Māʾidah", meaning: "The Table Spread", versesCount: 120, place: .medinan, arabicName: "المائدة", revelationOrder: 112),
            Surah(number: 6, englishName: "Al-Anʿām", meaning: "The Cattle", versesCount: 165, place: .meccan, arabicName: "الأنعام", revelationOrder: 55),
            Surah(number: 7, englishName: "Al-Aʿrāf", meaning: "The Heights", versesCount: 206, place: .meccan, arabicName: "الأعراف", revelationOrder: 39)
        ]
        applyFilters()
    }
    
    func selectSort(at index: Int) {
        guard sortOptions.indices.contains(index) else { return }
        selectedSortIndex = index
        applyFilters()
    }
    
    func search(_ text: String) {
        searchText = text
        applyFilters()
    }
    
    private func applyFilters() {
        var result = allSurahs
        
        let query = searchText.trimmingCharacters(in: .whitespaces).lowercased()
        if !query.isEmpty {
            result = result.filter {
                $0.englishName.lowercased().contains(query)
                || $0.meaning.lowercased().contains(query)
                || $0.arabicName.lowercased().contains(query)
                || String($0.number) == query
            }
        }
        
        switch sortOptions[selectedSortIndex] {
        case .surahOrder:
            result.sort { $0.number < $1.number}
        case .revelationOrder:
            result.sort { $0.revelationOrder < $1.revelationOrder}
        case .verses:
            result.sort { $0.versesCount > $1.versesCount}
        }
        
        surahs = result
        success?()
    }
}
