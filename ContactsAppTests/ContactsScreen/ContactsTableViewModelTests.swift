//
//  ContactsTableViewModelTests.swift
//  ContactsAppTests
//
//  Created by Daniel Fratila on 9/19/23.
//

import XCTest
import Combine

final class ContactsTableViewModelTests: XCTestCase {
    private var sut: ContactsTableViewModel!
    
    var cancellables = Set<AnyCancellable>()
    
    override func setUp() {
        super.setUp()
        
        sut = .init()
    }
    
    override func tearDown() {
        super.tearDown()
        cancellables.removeAll()
    }
    
    func testContactsDataPublisher() {
        // GIVEN
        sut
            .contactsDataPublisher
            .sink { data in
                // THEN
                XCTAssertEqual(data.title, TestData.contactsDataTitle)
                XCTAssertEqual(data.subtitle, TestData.contactsDataSubtitle)
                XCTAssertTrue(!data.contactViewModels.isEmpty)
            }
            .store(in: &cancellables)
        
        // WHEN init()
    }
    
    func testFirstLaunch() {
        // GIVEN
        
        // THEN
        XCTAssertFalse(sut.firstLaunch)
    }
    
    func testRetrieveContactsFromCoreData() {
        // WHEN
        
        sut.retrieveContactsFromCoreData()
        
        // THEN
        
        XCTAssertNil(sut.selectedContactIndex)
        XCTAssertEqual(sut.contactsData.title, TestData.contactsDataTitle)
        XCTAssertEqual(sut.contactsData.subtitle, TestData.contactsDataSubtitle)
        XCTAssertTrue(!sut.contactsData.contactViewModels.isEmpty)
    }
}

private extension ContactsTableViewModelTests {
    enum TestData {
        static let contactsDataTitle = "Contacte"
        static let contactsDataSubtitle = "CONTACTELE MELE"
    }
}
