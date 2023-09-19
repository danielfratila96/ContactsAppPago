//
//  ContactDetailsViewModel.swift
//  ContactsApp
//
//  Created by Daniel Fratila on 9/16/23.
//

import Foundation
import Combine

// MARK: - ContactDetailsViewModelType

protocol ContactDetailsViewModelType {
    // MARK: Publishers
    var eventPublisher: AnyPublisher<ContactDetailsEvent, Never> { get }
    
    var nextActionButtonText: String { get }
    var contact: ContactCoreDataModel? { get }
    var alert: AlertData { get }
    
    func nextActionButtonTapped(lastName: String, firstName: String, phoneNO: String, email: String)
}

enum ContactDetailsEvent {
    case pop
    case alert
}

struct AlertData {
    let title: String
    let message: String
    let actionTitle: String
}

final class ContactDetailsViewModel: ContactDetailsViewModelType {
    // MARK: Publishers
    private var event = PassthroughSubject<ContactDetailsEvent, Never>()
    var eventPublisher: AnyPublisher<ContactDetailsEvent, Never> {
        event.eraseToAnyPublisher()
    }
    
    var nextActionButtonText: String {
        return contact == nil ? HardcodedStrings.ContactDetailScreen.save : HardcodedStrings.ContactDetailScreen.update
    }
    
    var contact: ContactCoreDataModel?
    
    var alert: AlertData = .init(title: "Eroare",
                                 message: "Numele si prenumele nu pot fi lasate necompletate",
                                 actionTitle: "OK")
    
    init(contact: ContactCoreDataModel?) {
        self.contact = contact
    }
    
    func nextActionButtonTapped(lastName: String, firstName: String, phoneNO: String, email: String) {
        if !lastName.isEmpty, !firstName.isEmpty{
            let contactCoreDataModel: ContactCoreDataModel = .init(id: contact?.id ?? Int(arc4random_uniform(6) + 1),
                                                                   firstName: firstName,
                                                                   lastName: lastName,
                                                                   phoneNO: phoneNO.applyPatternOnNumbers(pattern: "#### ### ###", replacmentCharacter: "#"),
                                                                   email: email,
                                                                   gender: contact?.gender ?? "male",
                                                                   status: contact?.status ?? "active")
            CoreDataManager.sharedManager.updateData(contact: contactCoreDataModel)
            event.send(.pop)
        } else {
            event.send(.alert)
        }
    }
}
