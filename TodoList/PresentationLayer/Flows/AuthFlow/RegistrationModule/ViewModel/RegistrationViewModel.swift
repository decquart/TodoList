//
//  RegistrationViewModel.swift
//  TodoList
//
//  Created by Volodymyr Myhailyuk on 20.09.2020.
//  Copyright © 2020 Volodymyr Mykhailiuk. All rights reserved.
//

import Foundation
import RxSwift

final class RegistrationViewModel {

	enum RegistrationError: Error {
		case emptyUserName
		case userExists(name: String)
		case emptyPassword
		case emptyEmail
		case invalidEmail
		case cannotSaveUser
	}

	private let repository: AnyRepository<User>
	private let keychain: KeychainProtocol

	let disposeBag = DisposeBag()

	let onBack = PublishSubject<Void>()
	let didSignup = PublishSubject<Void>()

	let nameSubject = BehaviorSubject(value: "")
	let passwordSubject = BehaviorSubject(value: "")
	let emailSubject = BehaviorSubject(value: "")

	let onUserNameError = PublishSubject<String>()
	let onPasswordError = PublishSubject<String>()
	let onEmailError = PublishSubject<String>()

	let onShowAlert = PublishSubject<String>()

	init(repository: AnyRepository<User>, keychain: KeychainProtocol) {
		self.repository = repository
		self.keychain = keychain
	}

	func signUpTapped() {
		Observable.zip(nameSubject, passwordSubject, emailSubject) {
			return RegistrationCredentials(name: $0, password: $1, email: $2)
		}
		.flatMap { [weak self] in
			self?.validateTextFields(credentials: $0) ?? Observable.error(RegistrationError.cannotSaveUser)
		}
		.flatMap { [weak self] in
			self?.checkIfUserExists(credentials: $0) ?? Observable.error(RegistrationError.cannotSaveUser)
		}
		.flatMap { [weak self] in
			self?.persistNewUser(credentials: $0) ?? Observable.error(RegistrationError.cannotSaveUser)
		}
		.subscribe(onNext: { [weak self] in
			self?.onShowAlert.onNext("User successfully saved")
			self?.onBack.onNext(())
		}, onError: { [weak self] in
			guard let self = self, let error = $0 as? RegistrationError else { return }

			switch error {
			case .emptyUserName:
				self.onUserNameError.onNext("Empty Name!")
			case .emptyPassword:
				self.onPasswordError.onNext("Empty Password!")
			case .emptyEmail:
				self.onEmailError.onNext("Empty Email!")
			case .userExists(let name):
				self.onUserNameError.onNext("User with name \(name) already exists")
			case .invalidEmail:
				self.onEmailError.onNext("Invalid Email!")
			case .cannotSaveUser:
				self.onShowAlert.onNext("Can't save user. Please try again later")
			}
		})
		.disposed(by: disposeBag)
	}

	func backTapped() {
		onBack.onNext(())
	}
}

private extension RegistrationViewModel {
	func validateTextFields(credentials: RegistrationCredentials) -> Observable<RegistrationCredentials> {
		return Observable.create { [weak self] observer in
			let disposable = Disposables.create()

			guard !credentials.name.isEmpty else {
				observer.onError(RegistrationError.emptyUserName)
				return disposable
			}

			guard !credentials.password.isEmpty else {
				observer.onError(RegistrationError.emptyPassword)
				return disposable
			}

			guard !credentials.email.isEmpty else {
				observer.onError(RegistrationError.emptyEmail)
				return disposable
			}

			self?.isValidEmail(credentials.email) == true
				? observer.onNext(credentials)
				: observer.onError(RegistrationError.invalidEmail)

			return disposable
		}
	}

	func checkIfUserExists(credentials: RegistrationCredentials) -> Observable<RegistrationCredentials> {
		return Observable.create { [weak self] observer in
			let disposable = Disposables.create()

			let predicate = NSPredicate(format: "name = %@", credentials.name)

			self?.repository.fetch(where: predicate) { result in
				if case let .success(users) = result, users.first?.name == credentials.name {
					observer.onError(RegistrationError.userExists(name: credentials.name))
					return
				}

				observer.onNext(credentials)
			}

			return disposable
		}
	}

	func persistNewUser(credentials: RegistrationCredentials) -> Observable<Void> {

		return Observable.create { [weak self] observer in
			let disposable = Disposables.create()

			self?.repository.add(User(name: credentials.name, email: credentials.email), completion: { success in
				if success {
					let passwordSaved = self?.keychain.save(credentials.password, for: credentials.name) == true

					passwordSaved
						? observer.onNext(())
						: observer.onError(RegistrationError.cannotSaveUser)

					return
				}

				observer.onError(RegistrationError.cannotSaveUser)
			})

			return disposable
		}
	}

	func isValidEmail(_ email: String) -> Bool {
		let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

		let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
		return emailPred.evaluate(with: email)
	}
}
