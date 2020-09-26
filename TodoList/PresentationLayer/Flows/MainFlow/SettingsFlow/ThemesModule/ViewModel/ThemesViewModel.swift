//
//  ThemesViewModel.swift
//  TodoList
//
//  Created by Volodymyr Myhailyuk on 26.09.2020.
//  Copyright © 2020 Volodymyr Mykhailiuk. All rights reserved.
//

import Foundation
import RxSwift

final class ThemesViewModel {
	private var themeService: ThemeServiceProtocol

	let disposeBag = DisposeBag()

	let selectedColor = BehaviorSubject<Color>(value: .customBlue)

	let didApplyColor = PublishSubject<Color>()
	let onDismiss = PublishSubject<Void>()
	
	init(themeService: ThemeServiceProtocol) {
		self.themeService = themeService

	}

	func viewDodLoad() {
		selectedColor.onNext(themeService.applicationColor)
	}

	func applySelectedColor() {
		selectedColor.asObservable()
			.observeOn(MainScheduler.instance)
			.subscribe(onNext: { [weak self] in
				self?.themeService.applicationColor = $0
				self?.didApplyColor.onNext($0)
				self?.onDismiss.onNext(())
			})
			.disposed(by: disposeBag)
	}
}
