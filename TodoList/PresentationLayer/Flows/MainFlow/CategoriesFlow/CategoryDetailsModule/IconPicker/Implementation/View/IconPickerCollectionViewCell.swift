//
//  IconPickerCollectionViewCell.swift
//  TodoList
//
//  Created by Volodymyr Myhailyuk on 26.06.2020.
//  Copyright © 2020 Volodymyr Mykhailiuk. All rights reserved.
//

import UIKit

class IconPickerCollectionViewCell: UICollectionViewCell {

	@IBOutlet weak var imageView: UIImageView!

	override func layoutSubviews() {
		super.layoutSubviews()
		self.layer.cornerRadius = self.frame.height / 2
	}
}
