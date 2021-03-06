//
//  LoginViewModel.swift
//  TodoList
//
//  Created by Volodymyr Myhailyuk on 18.09.2020.
//  Copyright © 2020 Volodymyr Mykhailiuk. All rights reserved.
//

import RxSwift
import Foundation
import GoogleSignIn

final class LoginViewModel: NSObject {

	enum LoginError: Error {
		case emptyUserName
		case emptyPassword
		case invalidUserName
		case invalidPassword
		case unrecognized
	}

	let loginError = PublishSubject<String>()
	let passwordError = PublishSubject<String>()

	let username = BehaviorSubject<String>(value: "")
	let password = BehaviorSubject<String>(value: "")
	let disposeBag = DisposeBag()

	var onFinish: Completion?
	var onRegister: Completion?

	private let repository: AnyRepository<User>
	private let keychain: KeychainProtocol
	private let userSession: UserSessionProtocol
	var googleSignInService: GoogleSignInServiceProtocol?

	init(repository: AnyRepository<User>, keychain: KeychainProtocol, userSession: UserSessionProtocol) {
		self.repository = repository
		self.keychain = keychain
		self.userSession = userSession
	}

	func skipLogin() {
		userSession.skipAuthorization()
		onFinish?()
	}

	func signIn() {
		Observable.zip(username, password) {
			return Credentials(name: $0, password: $1)
		}
		.flatMap { [weak self] val -> Observable<Bool> in
			return self?.validateCredentials(val) ?? Observable.empty()
		}
		.observeOn(MainScheduler.instance)
		.subscribe(onNext: { [weak self] success in
			if success {
				self?.onFinish?()
			}
		}, onError: { [weak self] in
			guard let error = $0 as? LoginError else { return }

			switch error {
			case .emptyUserName:
				self?.loginError.on(.next("Empty User Name!"))
			case .emptyPassword:
				self?.passwordError.on(.next("Empty Password!"))
			case .invalidUserName:
				self?.loginError.on(.next("Invalid User Name!"))
			case .invalidPassword:
				self?.passwordError.on(.next("Invalid Password!"))
			default:
				break
			}
		})
		.disposed(by: disposeBag)
	}

	func signInWithGoogle() {
		googleSignInService?.signIn()
	}

	func signUp() {
		onRegister?()
	}

	func validateCredentials(_ credentials: Credentials) -> Observable<Bool> {
		return Observable.create { [weak self] observer in

			let disposable = Disposables.create()

			guard !credentials.name.isEmpty else {
				observer.on(.error(LoginError.emptyUserName))
				return disposable
			}

			guard !credentials.password.isEmpty else {
				observer.on(.error(LoginError.emptyPassword))
				return disposable
			}

			let predicate = NSPredicate(format: "name = %@", credentials.name)

			self?.repository.fetch(where: predicate) { [weak self] result in
				guard let self = self else { return }

				if case let .success(users) = result, let user = users.first, user.name == credentials.name {
					let password = self.keychain.loadPassword(for: credentials.name)
					let isValidPassword = password == credentials.password

					if isValidPassword {
						self.userSession.logIn(user.name)
						observer.on(.next(true))
					} else {
						observer.on(.error(LoginError.invalidPassword))
					}

					return
				}

				observer.on(.error(LoginError.invalidUserName))
			}

			return disposable
		}
	}
}


//MARK: - GIDSignInDelegate
extension LoginViewModel: GIDSignInDelegate {
	func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
		if let error = error {
			print("\(error.localizedDescription)")
			return
		}

		let predicate = NSPredicate(format: "name = %@", user.profile.name)

		repository.fetch(where: predicate) { [weak self] result in
			if case let .success(users) = result, users.first?.name == user.profile.name {
				self?.userSession.logIn(user.profile.name)
				self?.onFinish?()
				return
			}

			self?.repository.add(user.profile.mapToModel) { [weak self] success in
				if success {
					self?.userSession.logIn(user.profile.name)
					self?.onFinish?()
				}
			}
		}
	}
}
