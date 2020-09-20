//
//  LoginViewController.swift
//  TodoList
//
//  Created by Volodymyr Myhailyuk on 21.08.2020.
//  Copyright © 2020 Volodymyr Mykhailiuk. All rights reserved.
//

import UIKit
import GoogleSignIn
import RxSwift
import RxCocoa


class LoginViewController: UIViewController {
	var viewModel: LoginViewModel!
	let disposeBag = DisposeBag()

	@IBOutlet private weak var loginView: UIView! {
		didSet {
			loginView.layer.cornerRadius = loginView.frame.width / 8
		}
	}

	@IBOutlet private weak var loginButton: UIButton! {
		didSet {
			loginButton.clipsToBounds = true
			loginButton.layer.cornerRadius = loginButton.frame.height / 2
		}
	}

	@IBOutlet private weak var skipButton: UIButton! {
		didSet {
			skipButton.clipsToBounds = true
			skipButton.layer.cornerRadius = skipButton.frame.height / 2
		}
	}


	@IBOutlet weak var signInWithGoogleButton: UIButton! {
		didSet {
			signInWithGoogleButton.clipsToBounds = true
			signInWithGoogleButton.layer.cornerRadius = signInWithGoogleButton.frame.height / 2
			signInWithGoogleButton.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMaxXMinYCorner]
			signInWithGoogleButton.setTitleColor(UIColor(red: 25/255, green: 104/255, blue: 231/255, alpha: 1), for: .normal)
		}
	}

	@IBOutlet weak var signUpButton: UIButton! {
		didSet {
			signUpButton.layer.cornerRadius = signUpButton.frame.height / 2
			signUpButton.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMinXMinYCorner]
			signUpButton.setTitleColor(UIColor(red: 25/255, green: 104/255, blue: 231/255, alpha: 1), for: .normal)
		}
	}

	@IBOutlet private weak var usernameTextField: UITextField! {
		didSet {
			usernameTextField.delegate = self
			usernameTextField.addTarget(self, action: #selector(removePlaceholderMessage(_:)), for: .editingChanged)
		}
	}

	@IBOutlet private weak var passwordTexrField: UITextField! {
		didSet {
			passwordTexrField.delegate = self
			passwordTexrField.addTarget(self, action: #selector(removePlaceholderMessage(_:)), for: .editingChanged)
		}
	}

	override func viewDidLoad() {
        super.viewDidLoad()

		view.applyGradient(for: .login(startPoint: .zero, endPoint: CGPoint(x: 0.8, y: 0.8)))

		setupBindings()
    }

	override func viewDidLayoutSubviews() {
		super.viewDidLayoutSubviews()

		loginButton.applyGradient(for: .login(startPoint: .zero, endPoint: CGPoint(x: 0.6, y: 0.6)))
		skipButton.applyGradient(for: .login(startPoint: .zero, endPoint: CGPoint(x: 0.6, y: 0.6)))
	}

	func setupBindings() {
		loginButton.rx.tap
			.bind { [weak self] in self?.viewModel.signInTapped() }
			.disposed(by: disposeBag)

		signInWithGoogleButton.rx.tap
			.bind { [weak self] in self?.viewModel.signInWithGoogleTapped() }
			.disposed(by: disposeBag)

		skipButton.rx.tap
			.bind { [weak self] in self?.viewModel.skipTapped() }
			.disposed(by: disposeBag)

		signUpButton.rx.tap
			.bind { [weak self] in self?.viewModel.signUpTapped() }
			.disposed(by: disposeBag)

		usernameTextField.rx.text.orEmpty
			.bind(to: viewModel.username)
			.disposed(by: disposeBag)

		passwordTexrField.rx.text.orEmpty
			.bind(to: viewModel.password)
			.disposed(by: disposeBag)

		viewModel.loginError
			.subscribe(onNext: { [weak self] in self?.usernameTextField.setErrorMessage($0) })
			.disposed(by: disposeBag)

		viewModel.passwordError
			.subscribe(onNext: { [weak self] in self?.passwordTexrField.setErrorMessage($0) })
			.disposed(by: disposeBag)
	}


	@objc func removePlaceholderMessage(_ textField: UITextField) {
		textField.placeholder = nil
	}

	override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
		view.endEditing(true)
	}
}

//MARK: - UITextFieldDelegate
extension LoginViewController: UITextFieldDelegate {
	func textFieldDidBeginEditing(_ textField: UITextField) {
		removePlaceholderMessage(textField)
	}
}
