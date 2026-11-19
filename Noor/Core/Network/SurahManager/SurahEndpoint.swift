//
//  SurahEndpoint.swift
//  Noor
//
//  Created by Ferid Suleymanzade on 19.11.26.
//

import Foundation

enum SurahEndpoint {
    case surahList

    var path: String {
        switch self {
        case .surahList:
            return CoreHelper.shared.configureURL(endpoint: "surah")
        }
    }
}
