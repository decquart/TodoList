//
//  TaskCell.swift
//  TodoList
//
//  Created by Volodymyr Mykhailiuk on 08.06.2020.
//  Copyright © 2020 Volodymyr Mykhailiuk. All rights reserved.
//

import UIKit
import RxSwift

class TaskCell: UITableViewCell {
	private(set) var disposeBag = DisposeBag()

	@IBOutlet weak private var descriptionLabel: UILabel!
	@IBOutlet weak var checkButton: UIButton!
	@IBOutlet weak var importantButton: UIButton!
	@IBOutlet weak var dateLabel: UILabel!
	@IBOutlet weak var containerView: UIView!

	override func prepareForReuse() {
		super.prepareForReuse()

		disposeBag = DisposeBag()
	}

	override func layoutSubviews() {
		super.layoutSubviews()

		containerView.layer.cornerRadius = 12.0
		containerView.layer.shadowOffset = CGSize(width: 0, height: 2)
		containerView.layer.shadowRadius = 2.0
		containerView.layer.shadowOpacity = 0.4
	}

	func configure(with viewModel: TaskViewModel) {
		self.descriptionLabel.text = viewModel.description
		self.checkButton.setImage(viewModel.checkmarkIcon, for: .normal)
		self.dateLabel.text = viewModel.dateText
		self.importantButton.setImage(viewModel.importantIcon, for: .normal)
		self.importantButton.tintColor = viewModel.importantIconColor
	}
}
