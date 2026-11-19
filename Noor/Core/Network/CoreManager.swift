//
//  CoreManager.swift
//  Noor
//
//  Created by Ferid Suleymanzade on 19.11.26.
//

import Foundation
import Alamofire

enum EncodingType {
    case url
    case json
    
    var encoding: ParameterEncoding {
        switch self {
        case .url:
            return URLEncoding.default
        case .json:
            return JSONEncoding.default
        }
    }
}

final class CoreManager {
    
    func request<T: Codable>(model: T.Type,
                             endpoint: String,
                             method: HTTPMethod = .get,
                             parameter: Parameters? = nil,
                             encoding: EncodingType = .url,
                             completion: @escaping (T?, String?) -> Void) {
        AF.request(endpoint,
                   method: method,
                   parameters: parameter,
                   encoding: encoding.encoding).responseData { response in
            switch response.result {
            case .success(let data):
                do {
                    let result = try JSONDecoder().decode(T.self, from: data)
                    completion(result, nil)
                } catch {
                    completion(nil, error.localizedDescription)
                }
            case .failure(let error):
                completion(nil, error.localizedDescription)
            }
            
        }
    }
}
