//
//  ColorPickerCollectionViewCell.swift
//  TodoList
//
//  Created by Volodymyr Myhailyuk on 14.07.2020.
//  Copyright © 2020 Volodymyr Mykhailiuk. All rights reserved.
//

import UIKit

class ColorPickerCollectionViewCell: UICollectionViewCell {
	override func layoutSubviews() {
		super.layoutSubviews()

		self.layer.cornerRadius = self.frame.height / 2
		self.layer.borderColor = UIColor.selectedBorderColor.cgColor
	}
}
