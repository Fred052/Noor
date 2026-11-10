//
//  KeychainManager.swift
//  Noor
//
//  Created by Ferid Suleymanzade on 10.11.26.
//

import Foundation
import Security

enum KeychainKey {
    static let userID = "userID"
    static let appleUserID = "appleUserID"
}

final class KeychainManager {

    static let shared = KeychainManager()
    private init() {}

    private let service = Bundle.main.bundleIdentifier ?? "noor"

    private func baseQuery(for key: String) -> [String: Any] {
        return [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: service,
            kSecAttrAccount as String: key
        ]
    }

    @discardableResult
    func save(_ value: String, for key: String) -> Bool {
        delete(key)
        var query = baseQuery(for: key)
        query[kSecValueData as String] = Data(value.utf8)
        query[kSecAttrAccessible as String] = kSecAttrAccessibleWhenUnlockedThisDeviceOnly
        return SecItemAdd(query as CFDictionary, nil) == errSecSuccess
    }

    func read(_ key: String) -> String? {
        var query = baseQuery(for: key)
        query[kSecReturnData as String] = true
        query[kSecMatchLimit as String] = kSecMatchLimitOne

        var result: AnyObject?
        let status = SecItemCopyMatching(query as CFDictionary, &result)
        guard status == errSecSuccess, let data = result as? Data else { return nil }
        return String(data: data, encoding: .utf8)
    }

    @discardableResult
    func delete(_ key: String) -> Bool {
        let status = SecItemDelete(baseQuery(for: key) as CFDictionary)
        return status == errSecSuccess || status == errSecItemNotFound
    }
}
