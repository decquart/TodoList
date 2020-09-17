//
//  CategoryListPresenterProtocol.swift
//  TodoList
//
//  Created by Volodymyr Myhailyuk on 13.07.2020.
//  Copyright © 2020 Volodymyr Mykhailiuk. All rights reserved.
//

import Foundation

protocol CategoryListPresenterProtocol: class {
	var view: CategoryListViewProtocol? { get }

	var categoriesCount: Int { get }

	func category(at index: Int) -> CategoryViewModel
	func tasksCount(at index: Int) -> Int
	func loadCategories()
	func addCategoryButtonPressed()
	func didSelectCategory(with index: Int)
	func deleteButtonPressed(with index: Int)
	func editButtonPressed(with index: Int)
}
