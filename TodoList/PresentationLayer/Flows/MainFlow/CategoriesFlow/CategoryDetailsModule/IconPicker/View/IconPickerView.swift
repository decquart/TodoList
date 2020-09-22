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
	private var selectedIndexPath: IndexPath? = nil

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

		Observable.zip(collectionView.rx.itemSelected, collectionView.rx.modelSelected(String.self))
			.subscribe(onNext: { [unowned self] indexPath, imageName in
				self.didSelectImageName.onNext(imageName)
				self.selectedIndexPath = indexPath
				self.collectionView.reloadData()
			})
			.disposed(by: disposeBag)

		collectionView.rx.willDisplayCell
			.subscribe(onNext: { [unowned self] cell, indexPath in
				cell.layer.borderColor = self.selectedIndexPath == indexPath
					? UIColor.secondaryLabel.cgColor
					: UIColor.clear.cgColor
			})
			.disposed(by: disposeBag)
	}

	func setSelected(_ imageName: String?) {
		guard let imageName = imageName, let index = imageNames.firstIndex(of: imageName) else {
			selectedIndexPath = IndexPath(row: 0, section: 0)
			return
		}

		selectedIndexPath = IndexPath(row: index, section: 0)
	}
}

// MARK: UICollectionViewDelegateFlowLayout
extension IconPickerView: UICollectionViewDelegateFlowLayout {
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		return CGSize(width: 40, height: 40)
	}
}
