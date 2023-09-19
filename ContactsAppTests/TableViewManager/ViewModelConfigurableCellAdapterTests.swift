//
//  ViewModelConfigurableCellAdapterTests.swift
//  ContactsAppTests
//
//  Created by Daniel Fratila on 9/19/23.
//

import XCTest

final class ViewModelConfigurableCellAdapterTests: XCTestCase {
    
    private var sut: ViewModelConfigurableCellAdapter<GenericConfigurableCellMock<String>>!
    private var cellMock: GenericConfigurableCellMock<String>!
    private var tableViewMock: UITableViewMock!
    
    override func setUp() {
        super.setUp()
        
        tableViewMock = .init()
        cellMock = .init()
        sut = .init(viewModel: TestData.viewModel)
    }
    
    func testTableViewDequeueReusableCell() {
        // given
        tableViewMock.dequeueReusableCellWithIdentifierStub = cellMock
        
        // when
        _ = sut.tableViewDequeueReusableCell(tableViewMock)
        
        // then
        XCTAssertEqual(cellMock.configureWasCalled, 1)
        XCTAssertEqual(cellMock.configureViewModel, TestData.viewModel)
        XCTAssertEqual(tableViewMock.dequeueReusableCellWithIdentifierWasCalled, 1)
    }
}

// MARK: - TestData

private extension ViewModelConfigurableCellAdapterTests {
    enum TestData {
        static let viewModel: String = "Test"
    }
}

private final class GenericConfigurableCellMock<T>: UITableViewCell, NibLoadableView, ReusableView, Configurable {
    
    // MARK: - configure
    
    private(set) var configureWasCalled: Int = 0
    private(set) var configureViewModel: T?
    
    func configure(with viewModel: T) {
        configureWasCalled += 1
        configureViewModel = viewModel
    }
}
