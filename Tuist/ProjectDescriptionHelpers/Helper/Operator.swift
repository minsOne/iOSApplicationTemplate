//
//  Operator.swift
//  ProjectDescriptionHelpers
//
//  Created by minsOne on 4/13/24.
//

import Foundation

precedencegroup ForwardPipe {
    associativity: left
}

infix operator |>: ForwardPipe

public func |> <T, U>(value: T, function: (T) -> U) -> U {
    return function(value)
}

infix operator ||>: ForwardPipe

public func ||> <T, U>(value: T?, function: (T) -> U) -> U? {
    guard let value else { return nil }
    return function(value)
}

precedencegroup NilCoalescingPrecedence {
    associativity: left
}

infix operator ?>: NilCoalescingPrecedence // Use the precedence of the nil-coalescing operator

/// Implementation of the operator
func ?> <T>(condition: Bool, resultProvider: @autoclosure () -> T?) -> T? {
    condition
        ? resultProvider()
        : nil
}
