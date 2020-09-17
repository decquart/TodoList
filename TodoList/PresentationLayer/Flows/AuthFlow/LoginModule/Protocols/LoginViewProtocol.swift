//
//  LoginViewProtocol.swift
//  TodoList
//
//  Created by Volodymyr Myhailyuk on 21.08.2020.
//  Copyright © 2020 Volodymyr Mykhailiuk. All rights reserved.
//

protocol LoginViewProtocol: class {
	func refreshUserNameTextField(with errorMessage: String)
	func refreshPasswordTextField(with errorMessage: String)
}
