//
//  ThemesViewController.swift
//  TodoList
//
//  Created by Volodymyr Myhailyuk on 16.07.2020.
//  Copyright © 2020 Volodymyr Mykhailiuk. All rights reserved.
//

import UIKit

class ThemesViewController: UIViewController {
	var presenter: ThemesPresenterProtocol!
	var colorPickerView: UIView!

	@IBOutlet weak private var colorPickerContainerView: UIView!
	@IBOutlet weak var closeButton: UIButton!
	@IBOutlet weak var applyButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

		if let colorView = colorPickerView {
			colorPickerContainerView.add(colorView)
		}

		presenter.viewDodLoad()
    }

	@IBAction func applyButtonPressed(_ sender: Any) {
		presenter.applyTheme()
	}

	@IBAction func closeButtonPressed(_ sender: Any) {
		presenter.close()
	}
}

//MARK: - ThemesViewProtocol
extension ThemesViewController: ThemesViewProtocol {

	func updateButtonsColor(_ color: Color) {
		closeButton.tintColor = color.uiColor
		applyButton.tintColor = color.uiColor
		self.navigationController?.tabBarController?.tabBar.tintColor = color.uiColor
	}
}
