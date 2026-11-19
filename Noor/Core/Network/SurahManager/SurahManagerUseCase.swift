//
//  SurahManagerUseCase.swift
//  Noor
//
//  Created by Ferid Suleymanzade on 19.11.26.
//

import Foundation

protocol SurahManagerUseCase {
    func getSurahList(completion: @escaping (SurahListResponse?, String?) -> Void)
}
