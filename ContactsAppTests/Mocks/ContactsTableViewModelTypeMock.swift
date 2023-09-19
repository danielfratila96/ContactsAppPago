//
//  ContactsTableViewModelTypeMock.swift
//  ContactsAppTests
//
//  Created by Daniel Fratila on 9/19/23.
//

import Foundation
import Combine
import UIKit

final class ContactsTableViewModelTypeMock: ContactsTableViewModelType {
    // MARK: contactsDataPublisher
    
    private(set) var contactsDataPublisherStub = PassthroughSubject<ContactScreen.ViewData, Never>()
    var contactsDataPublisher: AnyPublisher<ContactScreen.ViewData, Never> {
        contactsDataPublisherStub.eraseToAnyPublisher()
    }
    
    // MARK: contactDetailsViewController
    
    private (set) var contactDetailsViewControllerWasCalled: Int = 0
    var contactDetailsViewControllerStub: ContactDetailsViewController = UIStoryboard(name: "Main", bundle: Bundle.main)
        .initViewController { coder in
            ContactsTableViewController(coder: coder)
        }
    
    var contactDetailsViewController: ContactDetailsViewController {
        contactDetailsViewControllerWasCalled += 1
        return contactDetailsViewControllerStub
    }
    
    // MARK: selectedContactIndex
    
    private(set) var getSelectedContactIndexWasCalled: Int = 0
    private(set) var setSelectedContactIndexWasCalled: Int = 0
    
    var selectedContactIndexStub: Int? = 0
    
    var selectedContactIndex: Int? {
        get {
            getSelectedContactIndexWasCalled += 1
            return selectedContactIndexStub
        }
        set {
            setSelectedContactIndexWasCalled += 1
            selectedContactIndexStub = newValue
        }
    }
    
    // MARK: retrieveContactsFromCoreData
    
    private(set) var retrieveContactsFromCoreDataWasCalled: Int = 0
    
    func retrieveContactsFromCoreData() {
        retrieveContactsFromCoreDataWasCalled += 1
    }
}


