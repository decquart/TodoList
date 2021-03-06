//
//  CategoryDetailsViewModel.swift
//  TodoList
//
//  Created by Volodymyr Myhailyuk on 21.09.2020.
//  Copyright © 2020 Volodymyr Mykhailiuk. All rights reserved.
//

import Foundation
import RxSwift

final class CategoryDetailsViewModel {
	private let repository: AnyRepository<Category>
	private let scope: Scope<CategoryViewModel>

	let disposeBag = DisposeBag()

	let model = PublishSubject<CategoryViewModel>()

	let selectedImage = BehaviorSubject<String>(value: "shopping")
	let selectedColor = BehaviorSubject<Color>(value: Color.customBlue)
	let categoryName = BehaviorSubject<String>(value: "")

	let isValidSaveButton = BehaviorSubject<Bool>(value: false)

	var onDismiss: Completion?

	init(repository: AnyRepository<Category>, scope: Scope<CategoryViewModel>, didSelectImageName:  PublishSubject<String>, onSelectColor: BehaviorSubject<Color>) {
		self.repository = repository
		self.scope = scope

		categoryName
			.subscribe(onNext: { [weak self] in
				self?.isValidSaveButton.onNext(!$0.isEmpty)
			})
			.disposed(by: disposeBag)

		didSelectImageName
			.subscribe(onNext: { [weak self] in
				self?.selectedImage.onNext($0)
			})
			.disposed(by: disposeBag)

		onSelectColor
			.subscribe(onNext: { [weak self] in
				self?.selectedColor.onNext($0)
			})
			.disposed(by: disposeBag)

	}

	func initAppearance() {
		switch scope {
		case .edit(let model):
			categoryName.onNext(model.name)
			selectedImage.onNext(model.imagePath)
			selectedColor.onNext(model.color)
		default:
			break
		}
	}

	func saveTapped() {
		Observable.zip(categoryName, selectedImage, selectedColor)
			.flatMap { [unowned self] name, imagePath, color -> Observable<Category> in
				return Observable.create { observer in
					let disposable = Disposables.create()
					var category = CategoryViewModel()

					switch self.scope {
					case .edit(let model):
						category = model
					case .create:
						category = CategoryViewModel()
					}

					category.name = name
					category.imagePath = imagePath
					category.colorName = color.rawValue

					observer.onNext(category.mapToModel)
					observer.onCompleted()

					return disposable
				}
			}
			.flatMap { [unowned self] in
				self.persistCategory($0)
			}
			.observeOn(MainScheduler.instance)
			.subscribe(onNext: { [weak self] success in
				if success {
					self?.onDismiss?()
				}
			})
			.disposed(by: disposeBag)
	}

	func persistCategory(_ category: Category) -> Observable<Bool> {
		return Observable.create { [unowned self] observer in
			let disposable = Disposables.create()

			switch self.scope {
			case .create:
				self.repository.add(category) { success in
					observer.onNext(success)
				}
			case .edit:
				self.repository.update(category) { success in
					observer.onNext(success)
				}
			}

			return disposable
		}
	}

}
