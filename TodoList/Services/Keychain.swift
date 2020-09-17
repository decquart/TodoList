//
//  KeyChain.swift
//  TodoList
//
//  Created by Volodymyr Myhailyuk on 17.07.2020.
//  Copyright © 2020 Volodymyr Mykhailiuk. All rights reserved.
//

import Foundation

enum KeychainType: String {
	case username
	case email
	case password
}

protocol KeychainProtocol {
	func save(_ password: String, for username: String) -> Bool
	func loadPassword(for username: String) -> String?
	func deletePassword(for username: String) -> Bool
}

final class Keychain: KeychainProtocol {

	func save(_ password: String, for username: String) -> Bool {
		return save(password, for: username, and: KeychainType.password.rawValue)
	}

	func loadPassword(for username: String) -> String? {
		return load(for: username, and: KeychainType.password.rawValue)
	}

	func deletePassword(for username: String) -> Bool {
		return delete(for: username, and: KeychainType.password.rawValue)
	}
}


private extension Keychain {
	func save(_ value: String, for key: String, and service: String) -> Bool {
		let data = Data(value.utf8)

		let query = [
			String(kSecClass)		: String(kSecClassGenericPassword),
			String(kSecAttrAccount) : key,
			String(kSecAttrService) : service,
			String(kSecValueData)	: data ] as [String : Any]

		SecItemDelete(query as CFDictionary)

		let result = SecItemAdd(query as CFDictionary, nil)

		return result == noErr
	}

	func load(for key: String, and service: String) -> String? {
        let query = [
            String(kSecClass)		  : kSecClassGenericPassword,
			String(kSecAttrAccount)   : key,
			String(kSecAttrService)   : service,
            String(kSecReturnData)	  : kCFBooleanTrue!,
            String(kSecMatchLimit)	  : kSecMatchLimitOne ] as [String : Any]

        var dataTypeRef: AnyObject? = nil

        SecItemCopyMatching(query as CFDictionary, &dataTypeRef)

		guard let data = dataTypeRef as? Data else {
			return nil
		}

		return String(decoding: data, as: UTF8.self)
    }

	func delete(for key: String, and service: String) -> Bool {
		let query = [
			String(kSecClass)		: String(kSecClassGenericPassword),
			String(kSecAttrAccount) : key,
			String(kSecAttrService) : service] as [String : Any]

		let result = SecItemDelete(query as CFDictionary)

		return result == noErr
	}
}
