//
//  SurahMockManager.swift
//  Noor
//
//  Created by Ferid Suleymanzade on 19.11.26.
//

import Foundation

final class SurahMockManager: SurahManagerUseCase {

    func getSurahList(completion: @escaping (SurahListResponse?, String?) -> Void) {
        guard let url = Bundle.main.url(forResource: "SurahMockData", withExtension: "json") else {
            completion(nil, "Mock file not found")
            return
        }

        do {
            let data = try Data(contentsOf: url)
            let result = try JSONDecoder().decode(SurahListResponse.self, from: data)
            completion(result, nil)
        } catch {
            completion(nil, error.localizedDescription)
        }
    }
}
