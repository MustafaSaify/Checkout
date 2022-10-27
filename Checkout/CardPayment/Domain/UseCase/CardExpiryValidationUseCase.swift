//
//  CardExpiryValidationUseCase.swift
//  Checkout
//
//  Created by Mustafa Saify on 26/10/2022.
//

import Foundation

private let validCardExpiryLength = 4

protocol CardExpiryValidationContractor {
    func isCardExpiryValid(_ cardExpiry: String?) -> Bool
}

struct CardExpiryValidationUseCase: CardExpiryValidationContractor {
    func isCardExpiryValid(_ cardExpiry: String?) -> Bool {
        guard let cardExpiry = cardExpiry else {
            return false
        }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/yyyy"
        guard let expiryDate = dateFormatter.date(from: cardExpiry) else {
            return false
        }
        let calendar = Calendar.current
        let expiryDateComponents = calendar.dateComponents([.month, .year], from: expiryDate)
        let currentDateComponents = calendar.dateComponents([.month, .year], from: Date())
        let expiryYear = expiryDateComponents.year ?? 0
        let expiryMonth = expiryDateComponents.month ?? 0
        let currentYear = currentDateComponents.year ?? 0
        let currentMonth = currentDateComponents.month ?? 0
        if expiryYear < currentYear {
            return false
        }
        return expiryYear > currentYear ? true : expiryMonth >= currentMonth
    }
}
