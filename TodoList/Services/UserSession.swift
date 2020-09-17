//
//  UserSession.swift
//  TodoList
//
//  Created by Volodymyr Myhailyuk on 30.08.2020.
//  Copyright © 2020 Volodymyr Mykhailiuk. All rights reserved.
//

import Foundation

protocol UserSessionProtocol {
	var isAuthorized: Bool { get }
	var currentUser: String? { get }
	func logIn(_ userName: String)
	func logOut()
	func skipAuthorization()
}

final class UserSession: UserSessionProtocol {
	private init() {}
	static let `default` = UserSession()

	private enum SessionState: String {
		case notAuthorized
		case loggedIn
		case skipped
	}

	var isAuthorized: Bool {
		return sessionState == .loggedIn || sessionState == .skipped
	}

	func logIn(_ userName: String) {
		sessionState = .loggedIn
		currentUser = userName
	}

	func logOut() {
		sessionState = .notAuthorized
		currentUser = nil
	}

	func skipAuthorization() {
		sessionState = .skipped
	}

	private var sessionState: SessionState {
		get { UserDefaults.standard[#function] ?? .notAuthorized }
		set { UserDefaults.standard[#function] = newValue }
	}

	var currentUser: String? {
		get { UserDefaults.standard[#function] }
		set { UserDefaults.standard[#function] = newValue }
	}
}
