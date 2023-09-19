//
//  AnyCell.swift
//  ContactsApp
//
//  Created by Daniel Fratila on 9/15/23.
//

import UIKit.UITableViewCell

/// Cell `Interface`
protocol CellModel {
    /// PAT Placeholder for unknown Concrete Type `Model`
    associatedtype Cell: UITableViewCell
    /// Recieves a parameter of Concrete Type `Model`
    func tableViewDequeueReusableCell(_ tableView: UITableView) -> Cell
}

/// Wrapper `AnyCell`
struct AnyCell {
    private let _tableViewDequeueReusableCell: (_ tableView: UITableView) -> UITableViewCell
    
    var tableViewDidSelectRowHandler: (() -> Void)?
    
    init<Model: CellModel>(_ model: Model, tableViewDidSelectRowHandler: (() -> Void)? = nil) {
        self._tableViewDequeueReusableCell = model.tableViewDequeueReusableCell
        self.tableViewDidSelectRowHandler = tableViewDidSelectRowHandler
    }
    
    /// Conforming to `AnyCell` protocol
    func tableViewDequeueReusableCell(_ tableView: UITableView) -> UITableViewCell {
        _tableViewDequeueReusableCell(tableView)
    }
}

