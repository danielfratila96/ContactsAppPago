//
//  CellModelMock.swift
//  ContactsAppTests
//
//  Created by Daniel Fratila on 9/19/23.
//

import UIKit

final class CellModelMock: CellModel {
    
    // MARK: - tableViewDequeueReusableCell
    
    private(set) var tableViewDequeueReusableCellWasCalled: Int = 0
    private(set) var tableViewDequeueReusableCellTableView: UITableView?
    var tableViewDequeueReusableCellStub: UITableViewCell!
    
    func tableViewDequeueReusableCell(_ tableView: UITableView) -> UITableViewCell {
        tableViewDequeueReusableCellWasCalled += 1
        tableViewDequeueReusableCellTableView = tableView
        return tableViewDequeueReusableCellStub
    }
}
