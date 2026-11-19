//
//  SurahManager.swift
//  Noor
//
//  Created by Ferid Suleymanzade on 19.11.26.
//

import Foundation

final class SurahManager: SurahManagerUseCase {

    private let manager = CoreManager()

    func getSurahList(completion: @escaping (SurahListResponse?, String?) -> Void) {
        manager.request(model: SurahListResponse.self,
                        endpoint: SurahEndpoint.surahList.path,
                        completion: completion)
    }
}
