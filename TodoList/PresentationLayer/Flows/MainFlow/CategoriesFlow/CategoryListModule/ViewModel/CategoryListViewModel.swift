//
//  CategoryListViewModel.swift
//  TodoList
//
//  Created by Volodymyr Myhailyuk on 20.09.2020.
//  Copyright © 2020 Volodymyr Mykhailiuk. All rights reserved.
//

import Foundation
import RxSwift

final class CategoryListViewModel {

	private let repository: AnyRepository<Category>

	let categoryModels = PublishSubject<[CategoryViewModel]>()

	let onSelectIndexPath = PublishSubject<IndexPath>()
	let onSelectCategory = PublishSubject<Category>()

	let onEditIndex = PublishSubject<Int>()
	let onEditCategory = PublishSubject<Scope<CategoryViewModel>>()

	let disposeBag = DisposeBag()

	//todo: reconsider
	private var categories: [Category] = [] {
		didSet {
			categoryModels.onNext(categories.map {
				return CategoryViewModel(model: $0, taskCount: $0.tasksCount)
			})
		}
	}

	init(repository: AnyRepository<Category>) {
		self.repository = repository

		Observable.zip(onEditIndex, categoryModels)
			.map { index, models in
				return models[index]
			}
			.subscribe(onNext: { [weak self] in
				self?.onEditCategory.onNext(.edit(model: $0))
			})
			.disposed(by: disposeBag)

		onSelectIndexPath
			.subscribe(onNext: { [weak self] in
				guard let category = self?.categories[$0.row] else { return }
				self?.onSelectCategory.onNext(category)
			})
			.disposed(by: disposeBag)
	}

	func loadCategories() {
		repository.fetch(where: nil) { [weak self] result in
			switch result {
			case .success(let categories):
				self?.categories = categories
			case .failure(_):
				break
			}
		}
	}

	func removeItem(at index: Int) {
		let category = categories[index]

		repository.delete(category) { success in
			if success {
				self.categories = self.categories.filter { category.id != $0.id }
			}
		}
	}
	
	func editItem(at index: Int) {
		onEditIndex.onNext(index)
	}

	func createCategory() {
		onEditCategory.onNext(.create)
	}
}
