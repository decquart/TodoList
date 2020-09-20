//
//  RegistrationViewController.swift
//  TodoList
//
//  Created by Volodymyr Myhailyuk on 29.08.2020.
//  Copyright © 2020 Volodymyr Mykhailiuk. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class RegistrationViewController: UIViewController {

	var viewModel: RegistrationViewModel!
	private let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()

		setupBindings()
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

	func setupBindings() {
		signUpButton.rx.tap
			.bind { [weak self] in self?.viewModel.signUpTapped() }
			.disposed(by: disposeBag)

		backButton.rx.tap
			.bind { [weak self] in self?.viewModel.backTapped() }
			.disposed(by: disposeBag)

		userNameTextField.rx.text.orEmpty
			.bind(to: viewModel.nameSubject)
			.disposed(by: disposeBag)

		passwordTextField.rx.text.orEmpty
			.bind(to: viewModel.passwordSubject)
			.disposed(by: disposeBag)

		emailTextField.rx.text.orEmpty
			.bind(to: viewModel.emailSubject)
			.disposed(by: disposeBag)

		viewModel.onUserNameError
			.subscribe(onNext: { [weak self] in self?.userNameTextField.setErrorMessage($0) })
			.disposed(by: disposeBag)

		viewModel.onPasswordError
			.subscribe(onNext: { [weak self] in self?.passwordTextField.setErrorMessage($0) })
			.disposed(by: disposeBag)

		viewModel.onEmailError
			.subscribe(onNext: { [weak self] in self?.emailTextField.setErrorMessage($0) })
			.disposed(by: disposeBag)

		viewModel.onShowAlert
			.subscribe(onNext: { [weak self] in
				self?.showAlert(message: $0)
				self?.userNameTextField.text = ""
				self?.passwordTextField.text = ""
				self?.emailTextField.text = ""
			})
			.disposed(by: disposeBag)
	}

	@objc func removePlaceholderMessage(_ textField: UITextField) {
		textField.placeholder = nil
	}

	override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
		view.endEditing(true)
	}

	func showAlert(message: String) {
		let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
		alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
		self.present(alert, animated: true, completion: nil)
	}
}

//MARK: - UITextFieldDelegate
extension RegistrationViewController: UITextFieldDelegate {
	func textFieldDidBeginEditing(_ textField: UITextField) {
		removePlaceholderMessage(textField)
	}
}
