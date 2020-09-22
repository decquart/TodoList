//
//  IconPickerView.swift
//  TodoList
//
//  Created by Volodymyr Myhailyuk on 25.06.2020.
//  Copyright © 2020 Volodymyr Mykhailiuk. All rights reserved.
//

import UIKit
import RxSwift

class IconPickerView: UIView {
	private var selectedCell: IconPickerCollectionViewCell? = nil

	private let imageNames = ["shopping", "todo", "work"]
	let didSelectImageName = PublishSubject<String>()

	let disposeBag = DisposeBag()

	@IBOutlet weak private var collectionView: UICollectionView! {
		didSet {
			collectionView.rx.setDelegate(self).disposed(by: disposeBag)
			collectionView.registerNib(cellType: IconPickerCollectionViewCell.self)
			collectionView.allowsSelection = true
		}
	}

	override func awakeFromNib() {
		super.awakeFromNib()
		
		setupBindings()
	}

	func setupBindings() {
		Observable.from(optional: imageNames).bind(to: collectionView.rx.items(cellIdentifier: "IconPickerCollectionViewCell", cellType: IconPickerCollectionViewCell.self)) { row, name, cell in
			cell.imageView.image = UIImage(named: name)
		}
		.disposed(by: disposeBag)

		collectionView.rx.itemSelected
			.subscribe(onNext: { [unowned self] in
				self.didSelectImageName.onNext(self.imageNames[$0.row])
			})
			.disposed(by: disposeBag)
	}
}

extension IconPickerView: UICollectionViewDelegate {
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		guard let cell = collectionView.cellForItem(at: indexPath) as? IconPickerCollectionViewCell else {
			return
		}

		selectedCell?.layer.backgroundColor = UIColor.clear.cgColor
		cell.layer.backgroundColor = UIColor.secondarySystemBackground.cgColor
		selectedCell = cell
	}
}

// MARK: UICollectionViewDelegateFlowLayout
extension IconPickerView: UICollectionViewDelegateFlowLayout {
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		return CGSize(width: 40, height: 40)
	}
}
