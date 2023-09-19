//
//  ContactModel.swift
//  ContactsApp
//
//  Created by Daniel Fratila on 9/14/23.
//

import Foundation

struct ContactModel: Decodable {
    let id: Int
    let name: String
    let email: String
    let gender: String
    let status: String
}

extension ContactModel {
    func getFirstNameLastName(name: String) -> (firstName: String, lastName: String) {
        var components = name.components(separatedBy: " ")
        if components.count > 0 {
            let firstName = components.removeFirst()
            let lastName = components.joined(separator: " ")
            return (firstName, lastName)
        }
        
        return ("", "")
    }
}
