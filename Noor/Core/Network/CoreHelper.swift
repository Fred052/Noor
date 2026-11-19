//
//  CoreHelper.swift
//  Noor
//
//  Created by Ferid Suleymanzade on 19.11.26.
//

import Foundation

final class CoreHelper {
    
    static let shared  = CoreHelper()
    
    private init() {}
    
    private let baseURL = "https://api.alquran.cloud/v1/"
    
    func configureURL(endpoint: String) -> String {
        baseURL + endpoint
    }
}
