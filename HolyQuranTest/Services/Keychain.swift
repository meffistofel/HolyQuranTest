//
//  Keychain.swift
//  DepartmentSwiftUI
//
//  Created by Oleksandr Kovalov on 24.08.2022.
//

import Foundation

struct Keychain {

    // MARK: - KeychainError

    enum KeychainError: Error {
        case noPassword
        case unexpectedPasswordData
        case unexpectedItemData
        case unhandledError
    }

    // MARK: - Properties

    private let keychainType: Constants.KeychainType

    // MARK: - Init

    init(keychainType: Constants.KeychainType) {
        self.keychainType = keychainType
    }

    // MARK: Keychain access

    func saveItem(_ password: String) throws {

        // Encode the password into an Data object.
        let encodePassword = password.data(using: .utf8)

        do {

            try _ = readItem()

            var attributeToUpdate = [String: AnyObject]()
            attributeToUpdate[kSecValueData as String] = encodePassword as AnyObject?

            let query = keychainQuery()
            let status = SecItemUpdate(query as CFDictionary, attributeToUpdate as CFDictionary)

            guard status == noErr else { throw KeychainError.unhandledError }
        } catch KeychainError.noPassword {

            var newItem = keychainQuery()
            newItem[kSecValueData as String] = encodePassword as AnyObject?

            let status = SecItemAdd(newItem as CFDictionary, nil)

            guard status == noErr else { throw KeychainError.unhandledError }
        }
    }

    private func readItem() throws -> String {

        var query = keychainQuery()
        query[kSecMatchLimit as String] = kSecMatchLimitOne
        query[kSecReturnAttributes as String] = kCFBooleanTrue
        query[kSecReturnData as String] = kCFBooleanTrue

        // Try to fetch the existing keychain item that matches the query.
        var queryResult: AnyObject?
        let status = withUnsafeMutablePointer(to: &queryResult) {
            SecItemCopyMatching(query as CFDictionary, UnsafeMutablePointer($0))
        }

        // Check the return status and throw an error if appropriate.
        guard status != errSecItemNotFound else { throw KeychainError.noPassword }
        guard status == noErr else { throw KeychainError.unhandledError }

        // Parse the password string from the query result.
        guard let existingItem = queryResult as? [String: AnyObject],
              let passwordData = existingItem[kSecValueData as String] as? Data,
              let password = String(data: passwordData, encoding: .utf8) else {
            throw KeychainError.unexpectedPasswordData
        }
        return password

    }

    private func deleteItem() throws {
        let query = keychainQuery()
        let status = SecItemDelete(query as CFDictionary)

        guard status == noErr || status == errSecItemNotFound else { throw KeychainError.unhandledError}
    }

    /*
     For the purpose of this demo app, the user identifier will be stored in the device keychain.
     You should store the user identifier in your account management system.
     */
    static func currentUserIdentifier(type: Constants.KeychainType) -> String {
        do {
            let storedIdentifier = try Keychain(keychainType: type).readItem()
            return storedIdentifier
        } catch {
            return ""
        }
    }

    static func deleteUserIdentifierFromKeychain(type: Constants.KeychainType) -> Bool {
        do {
            try Keychain(keychainType: type).deleteItem()
            return true
        } catch {
            print("Unable to delete userIdentifier from keychain")
            return false
        }
    }
}

// MARK: - Private Extension

extension Keychain {
    private func keychainQuery() -> [String: AnyObject] {

        var query: [String: AnyObject] = [:]
        query[kSecClass as String] = kSecClassGenericPassword
        query[kSecAttrService as String] = keychainType.service as AnyObject?

        if let account = keychainType.account {
            query[kSecAttrService as String] = account as AnyObject?
        }

        if let accessGroup = keychainType.accessGroup {
            query[kSecAttrAccessGroup as String] = accessGroup as AnyObject?
        }

        return query
    }
}

