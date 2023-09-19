//
//  ContactDetailsViewModelTests.swift
//  ContactsAppTests
//
//  Created by Daniel Fratila on 9/19/23.
//

import XCTest
import Combine

final class ContactDetailsViewModelTests: XCTestCase {
    private var sut: ContactDetailsViewModel!
    
    var cancellables = Set<AnyCancellable>()
    
    override func setUp() {
        super.setUp()
        
        sut = .init(contact: TestData.contact)
    }
    
    override func tearDown() {
        super.tearDown()
        cancellables.removeAll()
    }
    
    func testEventPublisher() {
        let expectation = expectation(description: "testEventPublisher")
        expectation.expectedFulfillmentCount = 1
        
        // GIVEN
        sut
            .eventPublisher
            .sink { event in
                // THEN
                switch event {
                case .pop:
                    expectation.fulfill()
                case .alert:
                    expectation.fulfill()
                }
            }
            .store(in: &cancellables)
        
        // WHEN
        
        sut.nextActionButtonTapped(lastName: "", firstName: "", phoneNO: "", email: "")
        waitForExpectations(timeout: 0.1)
    }
    
    func testNextActionButtonText() {
        // WHEN init()
        
        // THEN
        XCTAssertEqual(sut.nextActionButtonText, TestData.update)
        
        // WHEN
        sut = .init(contact: nil)
        
        // THEN
        XCTAssertEqual(sut.nextActionButtonText, TestData.save)
    }

    func testContact() {
        // WHEN init()
        
        // THEN
        XCTAssertEqual(sut.contact?.id, TestData.contact.id)
        XCTAssertEqual(sut.contact?.firstName, TestData.contact.firstName)
        XCTAssertEqual(sut.contact?.lastName, TestData.contact.lastName)
        XCTAssertEqual(sut.contact?.phoneNO, TestData.contact.phoneNO)
        XCTAssertEqual(sut.contact?.email, TestData.contact.email)
        XCTAssertEqual(sut.contact?.gender, TestData.contact.gender)
        XCTAssertEqual(sut.contact?.status, TestData.contact.status)
    }
    
    func testAlert() {
        // WHEN
        
        // THEN
        XCTAssertEqual(sut.alert.title, TestData.alertTitle)
        XCTAssertEqual(sut.alert.message, TestData.alertMessage)
        XCTAssertEqual(sut.alert.actionTitle, TestData.actionTitle)
    }
    
    func testNextActionButtonTappedShowAlert() {
        let expectation = expectation(description: "testEventPublisher")
        expectation.expectedFulfillmentCount = 1
        
        // GIVEN
        sut
            .eventPublisher
            .sink { event in
                // THEN
                switch event {
                case .pop:
                    break
                case .alert:
                    expectation.fulfill()
                }
            }
            .store(in: &cancellables)
        
        // WHEN
        
        sut.nextActionButtonTapped(lastName: "",
                                   firstName: "",
                                   phoneNO: TestData.nextAction.phoneNO,
                                   email: TestData.nextAction.email)
        waitForExpectations(timeout: 0.1)
    }
    
    func testNextActionButtonTappedPop() {
        let expectation = expectation(description: "testEventPublisher")
        expectation.expectedFulfillmentCount = 1
        
        // GIVEN
        sut
            .eventPublisher
            .sink { event in
                // THEN
                switch event {
                case .pop:
                    expectation.fulfill()
                case .alert:
                    break
                }
            }
            .store(in: &cancellables)
        
        // WHEN
        
        sut.nextActionButtonTapped(lastName: TestData.nextAction.lastName,
                                   firstName: TestData.nextAction.firstName,
                                   phoneNO: TestData.nextAction.phoneNO,
                                   email: TestData.nextAction.email)
        waitForExpectations(timeout: 0.1)
    }
}

private extension ContactDetailsViewModelTests {
    enum TestData {
        static let contact: ContactCoreDataModel = .init(id: 123,
                                                         firstName: "test",
                                                         lastName: "test",
                                                         phoneNO: "07452312314",
                                                         email: "test",
                                                         gender: "test",
                                                         status: "test")
        public static let update = "Update"
        public static let save = "Save"
        public static let alertTitle = "Eroare"
        public static let alertMessage = "Numele si prenumele nu pot fi lasate necompletate"
        public static let actionTitle = "OK"
        public static let nextAction: NextAction = .init(lastName: "test",
                                                         firstName: "test",
                                                         phoneNO: "07452312314",
                                                         email: "test")
        
        public struct NextAction {
            let lastName: String
            let firstName: String
            let phoneNO: String
            let email: String
        }
    }
}
