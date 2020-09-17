//
//  RegistrationViewProtocol.swift
//  TodoList
//
//  Created by Volodymyr Myhailyuk on 29.08.2020.
//  Copyright © 2020 Volodymyr Mykhailiuk. All rights reserved.
//

protocol RegistrationViewProtocol: class {
	var presenter: RegistrationPresenterProtocol! { get }

	func updatehUserNameTextField(with errorMessage: String)
	func updatePasswordTextField(with errorMessage: String)
	func updateEmailTextField(with errorMessage: String)

	func showCantSaveUserMessage(_ message: String)
	func showUserSavedMessage(_ message: String)
}
