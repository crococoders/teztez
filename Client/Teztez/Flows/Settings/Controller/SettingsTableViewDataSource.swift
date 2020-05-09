//
//  SettingsTableViewDataSource.swift
//  Teztez
//
//  Created by Almas Zainoldin on 5/9/20.
//  Copyright © 2020 crococoders. All rights reserved.
//

import UIKit

final class SettingsTableViewDataSource: NSObject, UITableViewDataSource {
    var sections: [SettingsSectionType] = []

    func numberOfSections(in tableView: UITableView) -> Int {
        sections.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch sections[section] {
        case let .profile(rows):
            return rows.count
        case let .appereance(rows):
            return rows.count
        case let .document(rows):
            return rows.count
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch sections[indexPath.section] {
        case let .profile(rows):
            return getCellForRowAt(indexPath: indexPath, withRowType: rows[indexPath.row], tableView: tableView)
        case let .appereance(rows):
            return getCellForRowAt(indexPath: indexPath, withRowType: rows[indexPath.row], tableView: tableView)
        case let .document(rows):
            return getCellForRowAt(indexPath: indexPath, withRowType: rows[indexPath.row], tableView: tableView)
        }
    }

    private func getCellForRowAt(indexPath: IndexPath,
                                 withRowType rowType: SettingsRowType,
                                 tableView: UITableView) -> UITableViewCell {
        switch rowType {
        case let .profile(user):
            let cell: SettingsProfileCell = tableView.dequeueReusableCell(for: indexPath)
            cell.configure(with: user)
            return cell
        case let .web(viewModel):
            let cell: SettingsWebCell = tableView.dequeueReusableCell(for: indexPath)
            cell.configure(with: viewModel)
            return cell
        }
    }
}
