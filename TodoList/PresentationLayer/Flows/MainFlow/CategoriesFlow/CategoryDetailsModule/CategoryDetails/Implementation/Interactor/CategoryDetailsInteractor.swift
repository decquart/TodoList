//
//  CategoryDetailsInteractor.swift
//  TodoList
//
//  Created by Volodymyr Myhailyuk on 24.08.2020.
//  Copyright © 2020 Volodymyr Mykhailiuk. All rights reserved.
//

final class CategoryDetailsInteractor {
	private let repository: AnyRepository<Category>
	weak var output: CategoryDetailsInteractorOutput?

	init(repository: AnyRepository<Category>) {
		self.repository = repository
	}
}

//MARK: - CategoryDetailsInteractorInput
extension CategoryDetailsInteractor: CategoryDetailsInteractorInput {
	func create(_ category: Category) {
		repository.add(category) { [weak self] _ in
			self?.output?.didCategoryPersist()
		}
	}

	func update(_ category: Category) {
		repository.update(category) { [weak self] _ in
			self?.output?.didCategoryPersist()
		}
	}
}
