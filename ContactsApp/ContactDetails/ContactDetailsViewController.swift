//
//  ContactDetailsViewController.swift
//  ContactsApp
//
//  Created by Daniel Fratila on 9/16/23.
//

import UIKit
import Combine

// MARK: - ContactDetailsViewController

final class ContactDetailsViewController: UIViewController {
    
    // MARK: IBOutlets
    
    @IBOutlet private weak var lastNameTextField: UITextField!
    @IBOutlet private weak var firstNameTextField: UITextField!
    @IBOutlet private weak var phoneTextField: UITextField!
    @IBOutlet private weak var emailTextField: UITextField!
    @IBOutlet private weak var nextActionButton: UIButton!
    
    // MARK: Properties
    
    private var viewModel: ContactDetailsViewModelType

    // MARK: Publisher
    
    var cancellables = Set<AnyCancellable>()
    
    // MARK: Lifecycle
    
    init?(coder: NSCoder, viewModel: ContactDetailsViewModelType) {
        self.viewModel = viewModel
        
        super.init(coder: coder)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLayout()
        subscribe()
    }
    
    private func setupLayout() {
        navigationItem.setHidesBackButton(true, animated: true)
        if let contact = viewModel.contact {
            lastNameTextField.text = contact.lastName
            firstNameTextField.text = contact.firstName
            phoneTextField.text = contact.phoneNO
            emailTextField.text = contact.email
        }
        nextActionButton.setTitle(viewModel.nextActionButtonText, for: .normal)
    }
    
    @IBAction private func nextActionButtonTapped(_ sender: Any) {
        viewModel.nextActionButtonTapped(lastName: lastNameTextField.text ?? "",
                                         firstName: firstNameTextField.text ?? "",
                                         phoneNO: phoneTextField.text ?? "",
                                         email: emailTextField.text ?? "")
    }
    
    private func createAlert() {
        let alert = UIAlertController(title: viewModel.alert.title, message: viewModel.alert.message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: viewModel.alert.actionTitle, style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}

// MARK: - Subscribing

extension ContactDetailsViewController: Subscribing {
    func subscribe() {
        viewModel
            .eventPublisher
            .sink { [weak self] event in
                switch event {
                case .pop:
                    self?.navigationController?.popViewController(animated: true)
                case .alert:
                    self?.createAlert()
                }
            }
            .store(in: &cancellables)
    }
}
