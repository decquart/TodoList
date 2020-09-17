//
//  AddButton.swift
//  TodoList
//
//  Created by Volodymyr Mykhailiuk on 08.06.2020.
//  Copyright © 2020 Volodymyr Mykhailiuk. All rights reserved.
//

import UIKit

final class AddButton: UIButton {
	override func layoutSubviews() {
		super.layoutSubviews()

		self.layer.cornerRadius = frame.height / 2
		self.layer.backgroundColor = ThemeService.shared.applicationColor.uiColor.cgColor
		self.tintColor = .systemBackground
		self.setImage(UIImage(systemName: "plus"), for: .normal)
	}
}
