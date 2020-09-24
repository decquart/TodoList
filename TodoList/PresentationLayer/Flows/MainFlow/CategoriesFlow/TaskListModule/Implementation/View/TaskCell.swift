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

	override func prepareForReuse() {
		super.prepareForReuse()

		disposeBag = DisposeBag()
	}

	func configure(with viewModel: TaskViewModel) {
		self.descriptionLabel.text = viewModel.description
		self.checkButton.setImage(viewModel.checkmarkIcon, for: .normal)
		self.dateLabel.text = viewModel.dateText
		self.importantButton.setImage(viewModel.importantIcon, for: .normal)
		self.importantButton.tintColor = viewModel.importantIconColor
	}
}
