//
//  ColorPickerView.swift
//  TodoList
//
//  Created by Volodymyr Myhailyuk on 14.07.2020.
//  Copyright © 2020 Volodymyr Mykhailiuk. All rights reserved.
//

import UIKit
import RxSwift

class ColorPickerView: UIView {
	private var selectedCell: ColorPickerCollectionViewCell? = nil

	private var colors: [Color] {
		return [.customBlue, .customGreen, .customIndigo, .customOrange, .customPink, .customPurple, .customRed, .customTeal, .customYellow]
	}

	let disposeBag = DisposeBag()
	let onSelectColor = BehaviorSubject<Color>(value: .customBlue)
	
	private let inset: CGFloat = 12.0
	private let minimumInteritemSpacing: CGFloat = 24

	@IBOutlet weak var collectionView: UICollectionView! {
		didSet {
			collectionView.register(cellType: ColorPickerCollectionViewCell.self)
			collectionView.rx
				.setDelegate(self)
				.disposed(by: disposeBag)
		}
	}

	override func awakeFromNib() {
		super.awakeFromNib()

		Observable.from(optional: colors).bind(to: collectionView.rx.items(cellIdentifier: "ColorPickerCollectionViewCell", cellType: ColorPickerCollectionViewCell.self)) { [weak self] row, name, cell in
			cell.backgroundColor = self?.colors[row].uiColor
		}
		.disposed(by: disposeBag)

		Observable.zip(collectionView.rx.itemSelected, collectionView.rx.modelSelected(Color.self))
			.subscribe(onNext: { [unowned self] in
				self.setSelected(false, cell: self.selectedCell)

				let cell = self.collectionView.cellForItem(at: $0) as? ColorPickerCollectionViewCell
				self.setSelected(true, cell: cell)
				self.selectedCell = cell

				self.onSelectColor.onNext($1)
			})
			.disposed(by: disposeBag)
	}
}

// MARK: - UICollectionViewDelegateFlowLayout
extension ColorPickerView: UICollectionViewDelegateFlowLayout {
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

		 let noOfCellsInRow = 6
		 let totalSpace = (minimumInteritemSpacing * CGFloat(noOfCellsInRow - 1)) + inset * 2
		 let size = Int((collectionView.bounds.width - totalSpace) / CGFloat(noOfCellsInRow))

		 return CGSize(width: size, height: size)
	}

	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
		UIEdgeInsets(top: 0, left: inset, bottom: 0, right: inset)
	}

	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
		return minimumInteritemSpacing
	}
}

private extension ColorPickerView {
	func setSelected(_ isSelected: Bool, cell: UICollectionViewCell?) {
		let borderWidth: CGFloat = isSelected ? 2.0 : .zero

		UIView.transition(with: self,
						  duration: 0.3,
						  options: .transitionCrossDissolve,
						  animations: { cell?.layer.borderWidth = borderWidth },
						  completion: nil)
	}
}
