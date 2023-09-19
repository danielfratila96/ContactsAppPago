//
//  Subscribing.swift
//  ContactsApp
//
//  Created by Daniel Fratila on 9/15/23.
//

import Combine
import Foundation
import UIKit

/// Protocol that defines a standards method to subscribe to publishers
///
protocol Subscribing {
    func subscribe()
}

/// Protocol that defines a standard method for binding between view and view model
protocol Binding {
    func createBinding()
}
