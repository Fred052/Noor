//
//  SurahListResponse.swift
//  Noor
//
//  Created by Ferid Suleymanzade on 19.11.26.
//

import Foundation

struct SurahListResponse: Codable {
    let code: Int?
    let status: String?
    let data: [SurahItem]?

    enum CodingKeys: String, CodingKey {
        case code = "code"
        case status = "status"
        case data = "data"
    }
}

struct SurahItem: Codable {
    let number: Int?
    let name: String?
    let englishName: String?
    let englishNameTranslation: String?
    let numberOfAyahs: Int?
    let revelationType: String?

    enum CodingKeys: String, CodingKey {
        case number = "number"
        case name = "name"
        case englishName = "englishName"
        case englishNameTranslation = "englishNameTranslation"
        case numberOfAyahs = "numberOfAyahs"
        case revelationType = "revelationType"
    }
}
