//
//  RegistrationInteractor.swift
//  TodoList
//
//  Created by Volodymyr Myhailyuk on 29.08.2020.
//  Copyright © 2020 Volodymyr Mykhailiuk. All rights reserved.
//

import Foundation

enum RegistrationError: Error {
	case emptyUserName
	case userExists(name: String)
	case emptyPassword
	case invalidEmail
	case cannotSaveUser
}

class RegistrationInteractor {
	private let repository: AnyRepository<User>
	weak var output: RegistrationInteractorOutput!
	private let keychain: KeychainProtocol

	init(repository: AnyRepository<User>, keychain: KeychainProtocol) {
		self.repository = repository
		self.keychain = keychain
	}
}

//MARK: - RegistrationInteractorInput
extension RegistrationInteractor: RegistrationInteractorInput {
	func saveUser(_ name: String, password: String, email: String) {
		guard !name.isEmpty else {
			output.signUpFailure(with: .emptyUserName)
			return
		}

		guard !password.isEmpty else {
			output.signUpFailure(with: .emptyPassword)
			return
		}

		guard isValidEmail(email) else {
			output.signUpFailure(with: .invalidEmail)
			return
		}

		let predicate = NSPredicate(format: "name = %@", name)

		repository.fetch(where: predicate) { [weak self] result in
			if case let .success(users) = result, users.first?.name == name {
				self?.output.signUpFailure(with: .userExists(name: name))
				return
			}

			self?.repository.add(User(name: name, email: email), completion: { success in
				if success {
					let passwordSaved = self?.keychain.save(password, for: name) == true

					passwordSaved
						? self?.output.signUpSuccess()
						: self?.output.signUpFailure(with: .cannotSaveUser)

					return
				}

				self?.output.signUpFailure(with: .cannotSaveUser)
			})
		}
	}
}

private extension RegistrationInteractor {
	func isValidEmail(_ email: String) -> Bool {
		let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

		let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
		return emailPred.evaluate(with: email)
	}
}
