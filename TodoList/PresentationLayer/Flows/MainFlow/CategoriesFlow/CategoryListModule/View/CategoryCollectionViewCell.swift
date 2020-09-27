//
//  TaskCollectionViewCell.swift
//  TodoList
//
//  Created by Volodymyr Mykhailiuk on 28.05.2020.
//  Copyright © 2020 Volodymyr Mykhailiuk. All rights reserved.
//

import UIKit
import RxSwift

class CategoryCollectionViewCell: UICollectionViewCell {

	private(set) var disposeBag = DisposeBag()

	@IBOutlet weak private var taskImageView: UIImageView!
	@IBOutlet weak private var taskNameLabel: UILabel!
	@IBOutlet weak private var taskStatusLabel: UILabel!
	@IBOutlet weak var editButton: UIButton!

	override func prepareForReuse() {
		super.prepareForReuse()

		disposeBag = DisposeBag()
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

	func configure(with viewModel: CategoryViewModel) {
		taskImageView.image = viewModel.image
		taskImageView.tintColor = viewModel.color.uiColor
		taskNameLabel.text = viewModel.name
		taskStatusLabel.text = viewModel.taskStatus
	}
}
