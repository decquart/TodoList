//
//  RegistrationViewController.swift
//  TodoList
//
//  Created by Volodymyr Myhailyuk on 29.08.2020.
//  Copyright © 2020 Volodymyr Mykhailiuk. All rights reserved.
//

import UIKit

class RegistrationViewController: UIViewController {

	var presenter: RegistrationPresenterProtocol!

    override func viewDidLoad() {
        super.viewDidLoad()
    }
	@IBOutlet weak var userNameTextField: UITextField! {
		didSet {
			userNameTextField.delegate = self
			userNameTextField.addTarget(self, action: #selector(removePlaceholderMessage(_:)), for: .editingChanged)
		}
	}

	@IBOutlet weak var passwordTextField: UITextField! {
		didSet {
			passwordTextField.delegate = self
			passwordTextField.addTarget(self, action: #selector(removePlaceholderMessage(_:)), for: .editingChanged)
		}
	}

	@IBOutlet weak var emailTextField: UITextField! {
		didSet {
			emailTextField.delegate = self
			emailTextField.addTarget(self, action: #selector(removePlaceholderMessage(_:)), for: .editingChanged)
		}
	}

	@IBOutlet weak var backButton: UIButton! {
		didSet {
			backButton.clipsToBounds = true
			backButton.layer.cornerRadius = backButton.frame.height / 2
			backButton.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMaxXMinYCorner]

			backButton.applyGradient(for: .login(startPoint: .zero, endPoint: CGPoint(x: 0.6, y: 0.6)))
		}
	}
	@IBOutlet weak var signUpButton: UIButton! {
		didSet {
			signUpButton.clipsToBounds = true
			signUpButton.layer.cornerRadius = signUpButton.frame.height / 2
			signUpButton.applyGradient(for: .login(startPoint: .zero, endPoint: CGPoint(x: 0.6, y: 0.6)))
		}
	}

	@IBOutlet weak var signUpView: UIView! {
		didSet {
			signUpView.layer.cornerRadius = signUpView.frame.width / 8
			signUpView.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMinYCorner]
			signUpView.layer.shadowOpacity = 0.4
			signUpView.layer.shadowOffset = .zero
			signUpView.layer.shadowRadius = 10
		}
	}

	@IBAction func signUpButtonPressed(_ sender: Any) {
		let viewModel = SignUpViewModel(name: userNameTextField.text ?? "",
										email: emailTextField.text ?? "",
										password: passwordTextField.text ?? "")

		presenter.signUp(with: viewModel)
	}
	
	@IBAction func backButtonPressed(_ sender: Any) {
		presenter.back()
	}

	@objc func removePlaceholderMessage(_ textField: UITextField) {
		textField.placeholder = nil
	}

	override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
		view.endEditing(true)
	}
}

//MARK: - RegistrationViewProtocol
extension RegistrationViewController: RegistrationViewProtocol {
	func showCantSaveUserMessage(_ message: String) {
		let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
		alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
		self.present(alert, animated: true, completion: nil)
	}

	func showUserSavedMessage(_ message: String) {
		let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
		alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
			self.userNameTextField.text = ""
			self.passwordTextField.text = ""
			self.emailTextField.text = ""
		}))
		self.present(alert, animated: true, completion: nil)
	}

	func updatehUserNameTextField(with errorMessage: String) {
		userNameTextField.setErrorMessage(errorMessage)
	}

	func updatePasswordTextField(with errorMessage: String) {
		passwordTextField.setErrorMessage(errorMessage)
	}

	func updateEmailTextField(with errorMessage: String) {
		emailTextField.setErrorMessage(errorMessage)
	}
}

//MARK: - UITextFieldDelegate
extension RegistrationViewController: UITextFieldDelegate {
	func textFieldDidBeginEditing(_ textField: UITextField) {
		removePlaceholderMessage(textField)
	}
}
