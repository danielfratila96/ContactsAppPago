//
//  NibLoadableView.swift
//  ContactsApp
//
//  Created by Daniel Fratila on 9/15/23.
//

import UIKit

protocol NibLoadableView: AnyObject {
    static var nibName: String { get }
}

extension NibLoadableView where Self: UIView {
    static var nibName: String {
        String(describing: self)
    }
    
    static func initFromNib<T>() -> T {
        Bundle.main.loadNibNamed(nibName, owner: nil, options: nil)?[0] as! T // swiftlint:disable:this force_cast
    }
}
