//
//  SettingsSection.swift
//  TodoList
//
//  Created by Volodymyr Myhailyuk on 25.09.2020.
//  Copyright © 2020 Volodymyr Mykhailiuk. All rights reserved.
//

import RxDataSources

struct SettingsSection {
	var title: String
	var items: [SettingsCellType]
}

extension SettingsSection: SectionModelType {
	init(original: SettingsSection, items: [SettingsCellType]) {
		self = original
		self.items = items
	}
}
