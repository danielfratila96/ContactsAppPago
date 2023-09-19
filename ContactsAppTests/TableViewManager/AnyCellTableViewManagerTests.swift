//
//  AnyCellTableViewManagerTests.swift
//  ContactsAppTests
//
//  Created by Daniel Fratila on 9/19/23.
//

import XCTest

final class AnyCellTableViewManagerTests: XCTestCase {
    
    private var sut: AnyCellTableViewManager!
    private var tableViewMock: UITableViewMock!
    private var cellModelMock: CellModelMock!
    private var completionHandlerMock: CompletionHandlerMock!
    
    override func setUp() {
        super.setUp()
        
        sut = AnyCellTableViewManager()
        tableViewMock = UITableViewMock()
        cellModelMock = CellModelMock()
        completionHandlerMock = CompletionHandlerMock()
        
        sut.sections = [TestData.section]
    }
    
    func testNumberOfSections() {
        // when
        let numberOfSections = sut.numberOfSections(in: tableViewMock)
        
        // then
        XCTAssertEqual(numberOfSections, 1)
    }
    
    func testNumberOfRowsInSection() {
        // when
        let numberOfRows = sut.tableView(tableViewMock, numberOfRowsInSection: 0)
        
        // then
        XCTAssertEqual(numberOfRows, TestData.section.cellItems.count)
    }
    
    func testCellForRowAtIndexPath() {
        // given
        let resultCell = UITableViewCell()
        sut.sections = [AnyCellSection(cellItems: [AnyCell(cellModelMock)])]
        cellModelMock.tableViewDequeueReusableCellStub = resultCell
        
        // when
        let cell = sut.tableView(tableViewMock, cellForRowAt: TestData.indexPath)
        
        // then
        XCTAssertEqual(cellModelMock.tableViewDequeueReusableCellWasCalled, 1)
        XCTAssertIdentical(cellModelMock.tableViewDequeueReusableCellTableView, tableViewMock)
        XCTAssertIdentical(cell, resultCell)
    }
    
    func testDidSelectRow() {
        // given
        let cell = AnyCell(
            cellModelMock,
            tableViewDidSelectRowHandler: completionHandlerMock.completion
        )
        sut.sections = [.init(cellItems: [cell])]
        
        // when
        sut.tableView(tableViewMock, didSelectRowAt: TestData.indexPath)
        
        // then
        XCTAssertEqual(completionHandlerMock.completionWasCalled, 1)
    }
}

// MARK: - TestData

private extension AnyCellTableViewManagerTests {
    enum TestData {
        static let indexPath = IndexPath(row: 0, section: 0)
        static let section = AnyCellSection(
            cellItems: [
                AnyCell(CellModelMock())
            ]
        )
    }
}

