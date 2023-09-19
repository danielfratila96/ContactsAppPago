//
//  ContactsViewController.swift
//  ContactsApp
//
//  Created by Daniel Fratila on 9/14/23.
//

import UIKit
import Combine

final class ContactsTableViewController: UIViewController {
    // MARK: Properties
    
    private var viewModel: ContactsTableViewModelType
    private var tableViewManager: ManagesAnyCellTableView
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: IBOutlets
    
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var subtitleLabel: UILabel!
    @IBOutlet private weak var tableView: UITableView!
    
    // MARK: Lifecycle
    
    init?(coder: NSCoder,
          viewModel: ContactsTableViewModelType = ContactsTableViewModel(),
          tableViewManager: ManagesAnyCellTableView = AnyCellTableViewManager()) {
        self.viewModel = viewModel
        self.tableViewManager = tableViewManager
        
        super.init(coder: coder)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLayout()
        createBinding()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        viewModel.retrieveContactsFromCoreData()
    }
}

// MARK: - Private

private extension ContactsTableViewController {
    func setupLayout() {
        tableView.delegate = tableViewManager
        tableView.dataSource = tableViewManager
    }
    
    func updateUI(_ contactsData: ContactScreen.ViewData) {
        titleLabel.text = contactsData.title
        subtitleLabel.text = contactsData.subtitle
        
        let contactCells = contactsData.contactViewModels.map { model in
            AnyCell(
                ViewModelConfigurableCellAdapter<ContactTableViewCell>(
                    viewModel: model
                )
            ) {  [weak self] in
                self?.viewModel.selectedContactIndex = model.index
                if let contactDetailsViewController = self?.viewModel.contactDetailsViewController {
                    self?.navigationController?.pushViewController(contactDetailsViewController, animated: true)
                }
            }
        }
        
        tableViewManager.sections = [
            .init(cellItems: contactCells)
        ]
        
        tableView.reloadData()
    }
    
    @IBAction func addNewContact(_ sender: Any) {
        self.navigationController?.pushViewController(viewModel.contactDetailsViewController, animated: true)
    }
}

// MARK: - ContactsTableViewController (Binding)

extension ContactsTableViewController: Binding {
    func createBinding() {
        viewModel.contactsDataPublisher
            .sink { [weak self] contactsData in
                DispatchQueue.main.async {
                    self?.updateUI(contactsData)
                }
            }
            .store(in: &cancellables)
    }
}

enum ContactScreen {
    struct ViewData: Equatable {
        let title: String
        let subtitle: String
        let contactViewModels: [ContactCellViewModel]
        
        static let emptyConfiguration = ViewData(title: "", subtitle: "", contactViewModels: [])
    }
    
    struct ContactCellViewModel: Equatable {
        let imageString: String?
        let personLabelString: String?
        let title: String?
        let index: Int?
    }
}
