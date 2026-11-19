//
//  QuranModel.swift
//  Noor
//
//  Created by Ferid Suleymanzade on 17.11.26.
//
import Foundation

enum RevelationPlace: String {
    case meccan = "Meccan"
    case medinan = "Medinan"
}

struct Surah {
    let number: Int
    let englishName: String
    let meaning: String
    let versesCount: Int
    let place: RevelationPlace
    let arabicName: String
    let revelationOrder: Int

    var subtitle: String {
        "\(meaning) · \(versesCount) verses · \(place.rawValue)"
    }
}

enum SurahSort: CaseIterable {
    case surahOrder
    case revelationOrder
    case verses

    var title: String {
        switch self {
        case .surahOrder: return "Surah order"
        case .revelationOrder: return "Revelation order"
        case .verses: return "Verses"
        }
    }
}
