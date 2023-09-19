//
//  CompletionHandlerMock.swift
//  ContactsAppTests
//
//  Created by Daniel Fratila on 9/19/23.
//

import Foundation

final class CompletionHandlerMock {
    
    // MARK: - completion
    
    private(set) var completionWasCalled: Int = 0
    
    func completion() {
        completionWasCalled += 1
    }
}

final class ParametrizedCompletionHandlerMock<T, U> {
    
    // MARK: - completion
    
    private(set) var completionWasCalled: Int = 0
    private(set) var completionParameter: T?
    var completionStub: U!
    
    func completion(_ parameter: T) -> U {
        completionWasCalled += 1
        completionParameter = parameter
        return completionStub
    }
}
