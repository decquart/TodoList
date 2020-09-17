//
//  IconPickerView.swift
//  TodoList
//
//  Created by Volodymyr Myhailyuk on 25.06.2020.
//  Copyright © 2020 Volodymyr Mykhailiuk. All rights reserved.
//

import UIKit

class IconPickerView: UIView {
	private var selectedCell: IconPickerCollectionViewCell? = nil
	var presenter: IconPickerPresenterProtocol!

	@IBOutlet weak private var collectionView: UICollectionView! {
		didSet {
			collectionView.delegate = self
			collectionView.dataSource = self
			collectionView.registerNib(cellType: IconPickerCollectionViewCell.self)
			collectionView.allowsSelection = true
		}
	}
}

extension IconPickerView: IconPickerViewProtocol {
	func iconDidSelect(_ imagePath: String) {

	}
}

// MARK: UICollectionViewDelegate, UICollectionViewDataSource
extension IconPickerView: UICollectionViewDelegate, UICollectionViewDataSource {
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		presenter.imageNames.count
	}

	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeue(cellType: IconPickerCollectionViewCell.self, for: indexPath)
		cell.imageView.image = UIImage(named: presenter.imageNames[indexPath.row])
		return cell
	}

	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		guard let cell = collectionView.cellForItem(at: indexPath) as? IconPickerCollectionViewCell else {
			return
		}

		selectedCell?.layer.backgroundColor = UIColor.clear.cgColor
		cell.layer.backgroundColor = UIColor.secondarySystemBackground.cgColor
		selectedCell = cell

		presenter.updateIcon(at: indexPath.row)
	}
}

// MARK: UICollectionViewDelegateFlowLayout
extension IconPickerView: UICollectionViewDelegateFlowLayout {
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		return CGSize(width: 40, height: 40)
	}
}
