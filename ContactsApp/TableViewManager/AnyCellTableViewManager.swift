//
//  AnyCellTableViewManager.swift
//  ContactsApp
//
//  Created by Daniel Fratila on 9/15/23.
//

import UIKit

struct AnyTableViewHeaderFooterView {
    let view: UIView
    let height: CGFloat?
}

struct AnyCellSection {
    let cellItems: [AnyCell]
    let header: AnyTableViewHeaderFooterView?
    let footer: AnyTableViewHeaderFooterView?
    
    init(
        cellItems: [AnyCell],
        header: AnyTableViewHeaderFooterView? = nil,
        footer: AnyTableViewHeaderFooterView? = nil
    ) {
        self.cellItems = cellItems
        self.header = header
        self.footer = footer
    }
}

protocol ManagesAnyCellTableView: UITableViewDelegate, UITableViewDataSource {
    var sections: [AnyCellSection] { get set }
}

final class AnyCellTableViewManager: NSObject, ManagesAnyCellTableView {
    var sections: [AnyCellSection] = []
}

// MARK: - UITableViewDataSource

extension AnyCellTableViewManager {
    func numberOfSections(in tableView: UITableView) -> Int {
        sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        sections[section].cellItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        sections[indexPath.section].cellItems[indexPath.row].tableViewDequeueReusableCell(tableView)
    }
}

// MARK: - UITableViewDelegate

extension AnyCellTableViewManager {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        sections[indexPath.section].cellItems[indexPath.row].tableViewDidSelectRowHandler?()
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        sections[section].header?.view
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if #available(iOS 15.0, *) {
            tableView.sectionHeaderTopPadding = .leastNonzeroMagnitude
        }
        return sections[section].header?.height ?? .leastNonzeroMagnitude
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        sections[section].footer?.view
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        sections[section].footer?.height ?? .leastNonzeroMagnitude
    }
}

