//
//  CategoryDetailsViewProtocol.swift
//  TodoList
//
//  Created by Volodymyr Myhailyuk on 13.07.2020.
//  Copyright © 2020 Volodymyr Mykhailiuk. All rights reserved.
//

import UIKit

protocol CategoryDetailsViewProtocol: class {
	var presenter: CategoryDetailsPresenterProtocol! { get }

	var isNewCategory: Bool { get }
	func refreshIcon(_ imagePath: String)
	func refreshColor(_ color: Color)
}
