//
//  ColorTableViewCell.swift
//  TodoList
//
//  Created by Volodymyr Myhailyuk on 14.07.2020.
//  Copyright © 2020 Volodymyr Mykhailiuk. All rights reserved.
//

import UIKit

class ColorTableViewCell: UITableViewCell {

	@IBOutlet weak var descriptionLabel: UILabel!
	@IBOutlet weak var colorLabel: UILabel!

	override func layoutSubviews() {
		super.layoutSubviews()

		colorLabel.layer.cornerRadius = colorLabel.frame.height / 2
		colorLabel.layer.masksToBounds = true
	}

	func configure(with model: ColorCellModel) {
		self.descriptionLabel.text = model.title
		self.colorLabel.backgroundColor = model.color.uiColor
	}
}
