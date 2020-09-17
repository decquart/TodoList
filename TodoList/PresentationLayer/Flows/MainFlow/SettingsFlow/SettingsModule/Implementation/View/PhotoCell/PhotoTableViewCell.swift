//
//  UserInfoTableViewCell.swift
//  TodoList
//
//  Created by Volodymyr Myhailyuk on 06.09.2020.
//  Copyright © 2020 Volodymyr Mykhailiuk. All rights reserved.
//

import UIKit

class PhotoTableViewCell: UITableViewCell {
	
	@IBOutlet weak var userImageView: UIImageView! {
		didSet {
			userImageView.layer.cornerRadius = userImageView.frame.height / 2
		}
	}

	@IBOutlet weak var userNameLabel: UILabel!

	func configure(with model: PhotoCellModel) {

		userNameLabel.text = model.name

		if let imageData = model.imageData {
			DispatchQueue.global().async {
				let image = UIImage(data: imageData)

				DispatchQueue.main.async {
					self.userImageView.image = image
				}
			}
		} else {
			userImageView.image = UIImage(named: "default_placeholder")
		}
	}
}
