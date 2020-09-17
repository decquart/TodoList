//
//  CategoryListUseCase.swift
//  TodoList
//
//  Created by Volodymyr Myhailyuk on 24.08.2020.
//  Copyright © 2020 Volodymyr Mykhailiuk. All rights reserved.
//

protocol CategoryListInteractorInput {
	var categoriesCount: Int { get }
	func fetchCategories()
	func category(by index: Int) -> Category
	func delete(by index: Int)
	func taskCount(by index: Int) -> Int
}

protocol CategoryListInteractorOutput: class {
	func didUpdateCategories()
}
