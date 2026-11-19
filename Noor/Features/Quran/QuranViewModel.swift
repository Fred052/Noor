//
//  QuranViewModel.swift
//  Noor
//
//  Created by Ferid Suleymanzade on 19.11.26.
//

import Foundation

final class QuranViewModel {

    var success: (() -> Void)?
    var error: ((String) -> Void)?

    private let manager: SurahManagerUseCase
    private var allSurahs: [Surah] = []
    private var searchText = ""

    private(set) var surahs: [Surah] = []
    private(set) var selectedSortIndex = 0

    let sortOptions = SurahSort.allCases
    let segmentTitles = ["Surahs", "Juz", "Bookmarks"]

    var chipTitles: [String] { sortOptions.map { $0.title } }
    var currentSearchText: String { searchText }

    init(manager: SurahManagerUseCase) {
        self.manager = manager
    }

    func getSurahList() {
        manager.getSurahList { [weak self] data, errorMessage in
            guard let self else { return }
            if let errorMessage {
                self.error?(errorMessage)
            } else if let data {
                self.allSurahs = (data.data ?? []).compactMap { self.makeSurah(from: $0) }
                self.applyFilters()
            }
        }
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

    private func makeSurah(from item: SurahItem) -> Surah? {
        guard let number = item.number,
              let englishName = item.englishName,
              let arabicName = item.name else { return nil }

        return Surah(number: number,
                     englishName: englishName,
                     meaning: item.englishNameTranslation ?? "",
                     versesCount: item.numberOfAyahs ?? 0,
                     place: item.revelationType == "Medinan" ? .medinan : .meccan,
                     arabicName: cleanArabicName(arabicName),
                     revelationOrder: RevelationOrder.position(of: number))
    }

    private func cleanArabicName(_ name: String) -> String {
        name
            .replacingOccurrences(of: "سُورَةُ ", with: "")
            .replacingOccurrences(of: "سورة ", with: "")
    }

    private func applyFilters() {
        var result = allSurahs

        let query = searchText.trimmingCharacters(in: .whitespaces).lowercased()
        if !query.isEmpty {
            result = result.filter {
                $0.englishName.lowercased().contains(query)
                || $0.meaning.lowercased().contains(query)
                || $0.arabicName.contains(query)
                || String($0.number) == query
            }
        }

        switch sortOptions[selectedSortIndex] {
        case .surahOrder:
            result.sort { $0.number < $1.number }
        case .revelationOrder:
            result.sort { $0.revelationOrder < $1.revelationOrder }
        case .verses:
            result.sort { $0.versesCount > $1.versesCount }
        }

        surahs = result
        success?()
    }
}
