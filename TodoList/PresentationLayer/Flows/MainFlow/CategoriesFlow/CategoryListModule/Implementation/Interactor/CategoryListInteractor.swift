//
//  CategoryListInteractor.swift
//  TodoList
//
//  Created by Volodymyr Myhailyuk on 24.08.2020.
//  Copyright © 2020 Volodymyr Mykhailiuk. All rights reserved.
//

final class CategoryListInteractor {
	weak var output: CategoryListInteractorOutput!
	private var repository: AnyRepository<Category>
	private var categories: [Category] = [] {
		didSet {
			self.output.didUpdateCategories()
		}
	}

	init(repository: AnyRepository<Category>) {
		self.repository = repository
	}
}

// MARK: - CategoryListInteractorInput
extension CategoryListInteractor: CategoryListInteractorInput {
	var categoriesCount: Int {
		return categories.count
	}

	func category(by index: Int) -> Category {
		return categories[index]
	}

	func delete(by index: Int) {
		let category = categories[index]
		repository.delete(category) { success in
			if success {
				self.categories = self.categories.filter { category.id != $0.id }
			}
		}
	}

	func fetchCategories() {
		repository.fetch(where: nil) { result in
			switch result {
			case .success(let categories):
				self.categories = categories
			case .failure(_):
				break
			}
		}
	}

	func taskCount(by index: Int) -> Int {
		return categories[index].tasksCount
	}
}
