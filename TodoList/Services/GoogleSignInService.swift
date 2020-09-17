//
//  GoogleSignInService.swift
//  TodoList
//
//  Created by Volodymyr Myhailyuk on 01.09.2020.
//  Copyright © 2020 Volodymyr Mykhailiuk. All rights reserved.
//

import UIKit
import GoogleSignIn

protocol GoogleSignInServiceProtocol {
	func signIn()
}

final class GoogleSignInService: GoogleSignInServiceProtocol {
	private init() {}
	static let shared = GoogleSignInService()

	func configure(with presentingViewController: UIViewController, and delegate: GIDSignInDelegate?) {

		GIDSignIn.sharedInstance().clientID = "211658416219-s0i26hlsp9ar3qfamngrj8745p5r47ah.apps.googleusercontent.com"
		GIDSignIn.sharedInstance().delegate = delegate
		GIDSignIn.sharedInstance().presentingViewController = presentingViewController
	}

	func signIn() {
		GIDSignIn.sharedInstance().signIn()
	}
}
