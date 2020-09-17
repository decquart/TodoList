//
//  RegistrationPresenter.swift
//  TodoList
//
//  Created by Volodymyr Myhailyuk on 29.08.2020.
//  Copyright © 2020 Volodymyr Mykhailiuk. All rights reserved.
//

class RegistrationPresenter {
	weak var view: RegistrationViewProtocol!
	private var interactor: RegistrationInteractorInput

	var onBack: (() -> Void)?

	init(view: RegistrationViewProtocol, interactor: RegistrationInteractorInput) {
		self.view = view
		self.interactor = interactor
	}
	
}


//MARK: - RegistrationViewProtocol
extension RegistrationPresenter: RegistrationPresenterProtocol {
	func back() {
		onBack?()
	}

	func signUp(with model: SignUpViewModel) {
		interactor.saveUser(model.name, password: model.password, email: model.email)
	}
}

//MARK: - RegistrationInteractorOutput
extension RegistrationPresenter: RegistrationInteractorOutput {
	func signUpFailure(with error: RegistrationError) {
		switch error {
		case .emptyUserName:
			view.updatehUserNameTextField(with: "Empty Name!")
		case .emptyPassword:
			view.updatePasswordTextField(with: "Empty Password!")
		case .userExists(let name):
			view.updatehUserNameTextField(with: "User with name \(name) already exists")
		case .invalidEmail:
			view.updateEmailTextField(with: "Invalid Email!")
		case .cannotSaveUser:
			view.showCantSaveUserMessage("Can't save user. Please try again later")
		}
	}

	func signUpSuccess() {
		view.showUserSavedMessage("User successfully saved")
	}
}
