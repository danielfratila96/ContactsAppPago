//
//  ViewModelConfigurableCellAdapter.swift
//  ContactsApp
//
//  Created by Daniel Fratila on 9/15/23.
//

import UIKit

protocol Configurable {
    associatedtype Configuration
    func configure(with configuration: Configuration)
}

struct ViewModelConfigurableCellAdapter<T: UITableViewCell & ReusableView & NibLoadableView & Configurable>: CellModel {
    
    let viewModel: T.Configuration
    
    func tableViewDequeueReusableCell(_ tableView: UITableView) -> T {
        let cell: T = tableView.dequeueReusableCellWithAutoregistration()
        cell.configure(with: viewModel)
        return cell
    }
}

struct VoidConfigurableCellAdapter<T: UITableViewCell & ReusableView & NibLoadableView>: CellModel {
    
    func tableViewDequeueReusableCell(_ tableView: UITableView) -> T {
        let cell: T = tableView.dequeueReusableCellWithAutoregistration()
        return cell
    }
}

