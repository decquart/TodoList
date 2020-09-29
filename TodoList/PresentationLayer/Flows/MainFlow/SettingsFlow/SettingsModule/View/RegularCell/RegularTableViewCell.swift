//
//  RegularTableViewCell.swift
//  TodoList
//
//  Created by Volodymyr Myhailyuk on 07.09.2020.
//  Copyright © 2020 Volodymyr Mykhailiuk. All rights reserved.
//

import UIKit

class RegularTableViewCell: UITableViewCell {
	@IBOutlet weak var emailLabel: UILabel!

	func configure(with model: RegularSettingsCellModel) {
		emailLabel.text = model.title
	}
}
