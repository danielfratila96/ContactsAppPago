//
//  ContactDetailsViewModelTypeMock.swift
//  ContactsAppTests
//
//  Created by Daniel Fratila on 9/19/23.
//

import Foundation
import Combine

final class ContactDetailsViewModelTypeMock: ContactDetailsViewModelType {

    // MARK: eventPublisher
    
    private(set) var eventPublisherStub = PassthroughSubject<ContactDetailsEvent, Never>()
    var eventPublisher: AnyPublisher<ContactDetailsEvent, Never> {
        eventPublisherStub.eraseToAnyPublisher()
    }
     
    // MARK: nextActionButtonText
    
    private(set) var nextActionButtonTextWasCalled: Int = 0
    var nextActionButtonTextStub: String = ""

    var nextActionButtonText: String {
        nextActionButtonTextWasCalled += 1
        return nextActionButtonTextStub
    }
    
    // MARK: contact
    
    private(set) var contactWasCalled: Int = 0
    var contactStub: ContactCoreDataModel? = .init(id: 123, firstName: "test", lastName: "test", phoneNO: "test", email: "test", gender: "test", status: "test")
    
    var contact: ContactCoreDataModel? {
        contactWasCalled += 1
        return contactStub
    }
    
    // MARK: alert
    
    private(set) var alertWasCalled: Int = 0
    var alertStub = AlertData.init(title: "test", message: "test", actionTitle: "test")
    
    var alert: AlertData {
        alertWasCalled += 1
        return alertStub
    }
    
    // MARK: nextActionButtonTapped
    
    private(set) var nextActionButtonTapped: Int = 0
    private(set) var nextActionButtonTappedReceivedParameters: (lastName: String, firstName: String, phoneNO: String, email: String)?
    
    func nextActionButtonTapped(lastName: String, firstName: String, phoneNO: String, email: String) {
        nextActionButtonTapped += 1
        nextActionButtonTappedReceivedParameters = (lastName: lastName, firstName: firstName, phoneNO: phoneNO, email: email)
    }
}
