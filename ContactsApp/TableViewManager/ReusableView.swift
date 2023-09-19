//
//  ReusableView.swift
//  ContactsApp
//
//  Created by Daniel Fratila on 9/15/23.
//

import UIKit

protocol ReusableView: AnyObject {
    static var defaultReuseIdentifier: String { get }
}

extension ReusableView where Self: UIView {
    static var defaultReuseIdentifier: String {
        String(describing: self)
    }
}
