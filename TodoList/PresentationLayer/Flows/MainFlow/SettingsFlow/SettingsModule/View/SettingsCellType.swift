//
//  SettingsCellType.swift
//  TodoList
//
//  Created by Volodymyr Myhailyuk on 26.09.2020.
//  Copyright © 2020 Volodymyr Mykhailiuk. All rights reserved.
//

import Foundation

enum SettingsCellType {
	case photo(PhotoCellModel, type: PhotoCellType)
	case regular(RegularSettingsCellModel, type: RegularCellType)
	case icon(SettingsCellModel, type: IconCellType)
	case `switch`(SwitchCellModel, type: SwitchCellType)
	case color(ColorCellModel)

	enum IconCellType {
		case logOut
	}

	enum PhotoCellType {
		case profile
	}

	enum RegularCellType {
		case email
	}

	enum SwitchCellType {
		case darkMode
	}
}
