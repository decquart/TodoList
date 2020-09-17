//
//  RegistrationUseCase.swift
//  TodoList
//
//  Created by Volodymyr Myhailyuk on 29.08.2020.
//  Copyright © 2020 Volodymyr Mykhailiuk. All rights reserved.
//

protocol RegistrationInteractorInput {
	var output: RegistrationInteractorOutput! { get }

	func saveUser(_ name: String, password: String, email: String)
}

protocol RegistrationInteractorOutput: class {
	func signUpFailure(with error: RegistrationError)
	func signUpSuccess()
}
