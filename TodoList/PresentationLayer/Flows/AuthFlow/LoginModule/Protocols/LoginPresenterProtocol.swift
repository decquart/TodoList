//
//  LoginPresenterProtocol.swift
//  TodoList
//
//  Created by Volodymyr Myhailyuk on 21.08.2020.
//  Copyright © 2020 Volodymyr Mykhailiuk. All rights reserved.
//

protocol LoginPresenterProtocol {
	func login(with username: String?, and password: String?)
	func skipLogin()
	func register()
	func signInWithGoogle()
}
