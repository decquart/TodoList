//
//  LoginPresenter.swift
//  TodoList
//
//  Created by Volodymyr Myhailyuk on 21.08.2020.
//  Copyright © 2020 Volodymyr Mykhailiuk. All rights reserved.
//

import Foundation

class LoginPresenter {
	weak var view: LoginViewProtocol!
	private var interactor: LoginInteractorInput

	var onFinish: (() -> Void)?
	var onRegister: (() -> Void)?

	init(view: LoginViewProtocol, interactor: LoginInteractorInput) {
		self.view = view
		self.interactor = interactor
	}
}

//MARK: - LoginPresenterProtocol
extension LoginPresenter: LoginPresenterProtocol {
	func login(with username: String?, and password: String?) {
		interactor.login(with: username, and: password)
	}

	func skipLogin() {
		interactor.skipLogin()
	}

	func register() {
		onRegister?()
	}

	func signInWithGoogle() {
		interactor.signInWithGoogle()
	}
}

//MARK: - LoginInteractorOutput
extension LoginPresenter: LoginInteractorOutput {
	func loginSuccess() {
		onFinish?()
	}

	func loginFailure(error: LoginError) {
		switch error {
		case .emptyUserName:
			view.refreshUserNameTextField(with: "Empty User Name!")
		case .invalidUserName:
			view.refreshUserNameTextField(with: "Invalid User Name!")
		case .emptyPassword:
			view.refreshPasswordTextField(with: "Empty Password!")
		case .invalidPassword:
			view.refreshPasswordTextField(with: "Invalid Password!")
		}
	}
}
