//
//  TaskCollectionViewCell.swift
//  TodoList
//
//  Created by Volodymyr Mykhailiuk on 28.05.2020.
//  Copyright © 2020 Volodymyr Mykhailiuk. All rights reserved.
//

import UIKit

class CategoryCollectionViewCell: UICollectionViewCell {
	private var editButtonPressedCallback: (() -> Void)?

	@IBOutlet weak private var taskImageView: UIImageView!
	@IBOutlet weak private var taskNameLabel: UILabel!
	@IBOutlet weak private var subTaskCountLabel: UILabel!

	@IBAction func editButtonPressed(_ sender: Any) {
		editButtonPressedCallback?()
	}

	override func layoutSubviews() {
		super.layoutSubviews()

		layer.cornerRadius = 12.0
		layer.shadowOffset = CGSize(width: 0, height: 2)
		layer.shadowRadius = 5.0
		layer.shadowOpacity = 0.4
		layer.masksToBounds = false
		clipsToBounds = false

	}

	func configure(with viewModel: CategoryViewModel, tasksCount: Int, callback: @escaping () -> Void) {
		taskImageView.image = viewModel.image
		taskImageView.tintColor = viewModel.color.uiColor
		taskNameLabel.text = viewModel.name
		subTaskCountLabel.text = String(tasksCount)
		editButtonPressedCallback = callback
	}
}
