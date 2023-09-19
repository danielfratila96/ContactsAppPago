//
//  ContactsTableViewModel.swift
//  ContactsApp
//
//  Created by Daniel Fratila on 9/14/23.
//

import Foundation
import Combine
import UIKit

// MARK: - ContactsTableViewModelType

protocol ContactsTableViewModelType {
    // Publishers
    
    var contactsDataPublisher: AnyPublisher<ContactScreen.ViewData, Never> { get }
    
    // Accessors
    
    var contactDetailsViewController: ContactDetailsViewController { get }
    var selectedContactIndex: Int? { get set }
    
    func retrieveContactsFromCoreData()
}

final class ContactsTableViewModel: ContactsTableViewModelType {
    // MARK: Publishers
    
    @Published private(set) var contactsData: ContactScreen.ViewData = .emptyConfiguration
    var contactsDataPublisher: AnyPublisher<ContactScreen.ViewData, Never> {
        $contactsData
            .eraseToAnyPublisher()
    }
    private var cancellables = Set<AnyCancellable>()
    
    private let networking: NetworkingType
    
    var contactDetailsViewController: ContactDetailsViewController {
        var contact: ContactCoreDataModel?
        if let selectedContactIndex = selectedContactIndex {
            contact = contactsCoreDataModel[selectedContactIndex]
        } else {
            contact = nil
        }
        
        let viewModel: ContactDetailsViewModelType = ContactDetailsViewModel(contact: contact)
        
        return UIStoryboard(name: "Main", bundle: Bundle.main)
            .initViewController { coder in
                ContactDetailsViewController(coder: coder, viewModel: viewModel)
            }
    }
    
    lazy var firstLaunch: Bool = {
        let launchedBefore = UserDefaults.standard.bool(forKey: "launchedBefore")
        if launchedBefore  {
            return false
        }
        else {
            UserDefaults.standard.set(true, forKey: "launchedBefore")
            return true
        }
    }()
    
    var contactsCoreDataModel: [ContactCoreDataModel] = []
    var selectedContactIndex: Int?
    
    init(networking: NetworkingType = Networking()) {
        self.networking = networking
        
        self.firstLaunch ? fetchContacts() : retrieveContactsFromCoreData()
    }
    
    private func fetchContacts() {
        networking.fetchData(at: NetworkingURLStrings.contacts) { (result: Result<[ContactModel], Error>) in
            switch result {
            case .success(let decodedData):
                let contactModels: [ContactCoreDataModel] = decodedData.map { .init(id: $0.id,
                                                                                    firstName: $0.getFirstNameLastName(name: $0.name).firstName,
                                                                                    lastName: $0.getFirstNameLastName(name: $0.name).lastName,
                                                                                    phoneNO: "",
                                                                                    email: $0.email,
                                                                                    gender: $0.gender,
                                                                                    status: $0.status) }
                CoreDataManager.sharedManager.createData(contacts: contactModels)
                self.constructData(contacts: contactModels)
            case .failure(let error):
                print("Error: \(error)") // maybe display an alert to inform the user
            }
        }
    }
    
    func retrieveContactsFromCoreData() {
        selectedContactIndex = nil
        let contactCoreDataModels: [ContactCoreDataModel] = CoreDataManager.sharedManager.retrieveData()
        constructData(contacts: contactCoreDataModels)
    }
    
    private func constructData(contacts: [ContactCoreDataModel]) {
        var contactViewModels: [ContactScreen.ContactCellViewModel] = []

        let filteredContacts = contacts.filter { $0.status == Status.active }
        
        for (index, element) in filteredContacts.enumerated() {
            let fullName = element.firstName + " " + element.lastName
            contactViewModels.append(index % 2 == 0 ?
                .init(imageString: HardcodedStrings.ContactsScreen.personImageString,
                      personLabelString: nil,
                      title: fullName,
                      index: index) :
                    .init(imageString: nil,
                          personLabelString: getNameInitials(name: fullName),
                          title: fullName,
                          index: index))
        }
        contactsData = .init(title: HardcodedStrings.ContactsScreen.contacts, subtitle: HardcodedStrings.ContactsScreen.myContacts.uppercased(), contactViewModels: contactViewModels)
        
        contactsCoreDataModel = filteredContacts
    }
    
    private func getNameInitials(name: String) -> String {
        let nameArr = name.components(separatedBy:" ")
        var initials = ""

        for name in nameArr {
            if let firstChar = name.first {
                initials += String(firstChar)
            }
        }

        return initials
    }
    
    private enum Status {
        static let active = "active"
        static let inactive = "inactive"
    }
}
