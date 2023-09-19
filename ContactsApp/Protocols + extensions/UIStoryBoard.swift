//
//  UIStoryBoard.swift
//  ContactsApp
//
//  Created by Daniel Fratila on 9/15/23.
//

import Foundation
import UIKit

extension UIStoryboard {
    
    func initViewController<T: UIViewController>(creator: @escaping (NSCoder) -> UIViewController?) -> T {
        
        guard let vc = instantiateViewController(identifier: T.storyboardIdentifier, creator: { coder in
            creator(coder)
        }) as? T else {
            fatalError("Unable to instantiate a view controller with identifier \(T.storyboardIdentifier) from storyboard \(self)")
        }
        
        return vc
    }
}

extension UIViewController {
    
    /// The storyboard identifier of a view controller defaults to that view controller's String(describing: self)
    static var storyboardIdentifier: String { String(describing: self) }
}
