//
//  CardNumberValidationUseCase.swift
//  Checkout
//
//  Created by Mustafa Saify on 26/10/2022.
//

import Foundation

private let validCardNumberLength = 16

protocol CardNumberValidationContractor {
    func isCardNumberValid(_ cardNumber: String?) -> Bool
}

struct CardNumberValidationUseCase: CardNumberValidationContractor {
    func isCardNumberValid(_ cardNumber: String?) -> Bool {
        cardNumber != nil && cardNumber?.count == validCardNumberLength
    }
}
