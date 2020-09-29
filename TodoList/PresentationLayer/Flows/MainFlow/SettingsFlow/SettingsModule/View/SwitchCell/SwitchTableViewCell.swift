//
//  SwitchTableViewCell.swift
//  TodoList
//
//  Created by Volodymyr Myhailyuk on 07.09.2020.
//  Copyright © 2020 Volodymyr Mykhailiuk. All rights reserved.
//

import UIKit

class SwitchTableViewCell: UITableViewCell {
	@IBOutlet weak var descriptionLabel: UILabel!
	@IBOutlet weak var cellSwitch: UISwitch!

	var onSwitch: ((Bool) -> Void)?

	@IBAction func valueChanged(_ sender: UISwitch) {
		onSwitch?(sender.isOn)
	}

	func configure(with model: SwitchCellModel) {
		descriptionLabel.text = model.title
		cellSwitch.isOn = model.isOn
		onSwitch = model.onSwitch
		self.cellSwitch.onTintColor = ThemeService.shared.applicationColor.uiColor
	}
}
