//
//  CategoryDetailsViewController.swift
//  TodoList
//
//  Created by Volodymyr Mykhailiuk on 01.06.2020.
//  Copyright © 2020 Volodymyr Mykhailiuk. All rights reserved.
//

import UIKit
import RxSwift

class CategoryDetailsViewController: UIViewController {
	var viewModel: CategoryDetailsViewModel!

	let disposeBag = DisposeBag()

	private lazy var saveBarButton: UIBarButtonItem = {
		return UIBarButtonItem(barButtonSystemItem: .save, target: nil, action: nil)
	}()

	@IBOutlet weak private var categoryIconImageView: UIImageView!
	@IBOutlet weak private var titleTextField: UITextField! {
		didSet {
			titleTextField.layer.cornerRadius = titleTextField.frame.height / 2
		}
	}
	@IBOutlet weak private var colorsContainerView: UIView!
	@IBOutlet weak var iconsContainerView: UIView!

	var colorPickerView: UIView?
	var iconPickerView: UIView?

	override func viewDidLoad() {
        super.viewDidLoad()
		navigationItem.title = "Category"

		if let iconPickerView = iconPickerView {
			iconsContainerView.add(iconPickerView, top: 0, left: 8, right: -8, bottom: 0)
		}

		if let colorPickerView = colorPickerView {
			colorsContainerView.add(colorPickerView, top: 0, left: 8, right: -8, bottom: 0)
		}

		setupGestureRecognizer()
		setupBindings()
    }

	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		self.navigationItem.rightBarButtonItem = saveBarButton

		viewModel.initAppearance()
	}

	func setupBindings() {
		viewModel.selectedImage
			.map { UIImage(named: $0)?.withRenderingMode(.alwaysTemplate) }
			.bind(to: categoryIconImageView.rx.image)
			.disposed(by: disposeBag)

		viewModel.selectedColor
			.subscribe(onNext: { [weak self] in
				self?.categoryIconImageView.tintColor = $0.uiColor
			})
			.disposed(by: disposeBag)

		viewModel.categoryName
			.bind(to: titleTextField.rx.text)
			.disposed(by: disposeBag)

		saveBarButton.rx.tap
			.bind { [weak self] in self?.viewModel.saveTapped() }
			.disposed(by: disposeBag)

		titleTextField.rx.text.orEmpty
			.bind(to: viewModel.categoryName)
			.disposed(by: disposeBag)
	}
}

// MARK: - GestureRecognizer
extension CategoryDetailsViewController {
	func setupGestureRecognizer() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
