//
//  ThemesViewController.swift
//  TodoList
//
//  Created by Volodymyr Myhailyuk on 16.07.2020.
//  Copyright © 2020 Volodymyr Mykhailiuk. All rights reserved.
//

import UIKit
import RxSwift

class ThemesViewController: UIViewController {
	var viewModel: ThemesViewModel!
	var colorPickerView: UIView!

	let disposeBag = DisposeBag()

	@IBOutlet weak private var colorPickerContainerView: UIView!
	@IBOutlet weak var closeButton: UIButton!
	@IBOutlet weak var applyButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

		if let colorView = colorPickerView {
			colorPickerContainerView.add(colorView)
		}

		setupBindings()
		viewModel.viewDodLoad()
    }

	func setupBindings() {
		viewModel.selectedColor
			.subscribe(onNext: { [weak self] in
				self?.closeButton.tintColor = $0.uiColor
				self?.applyButton.tintColor = $0.uiColor
				self?.navigationController?.tabBarController?.tabBar.tintColor = $0.uiColor
			})
			.disposed(by: disposeBag)

		applyButton.rx.tap
			.bind { [weak self] in self?.viewModel.applySelectedColor() }
			.disposed(by: disposeBag)

		closeButton.rx.tap
			.bind { [weak self] in self?.viewModel.onDismiss.onNext(()) }
			.disposed(by: disposeBag)
	}
}
