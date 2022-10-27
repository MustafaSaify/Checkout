//
//  CardPaymentUseCase.swift
//  Checkout
//
//  Created by Mustafa Saify on 16/10/2022.
//

import Foundation

protocol CardPaymentUseCaseContractor {
    func makeCardPayment(cardNumber: String, expiryMonth: String, expiryYear: String, cvv: String) async throws -> URL
}

class CardPaymentUseCase: CardPaymentUseCaseContractor {
    
    private let repository: CardPaymentRepositoryContractor
    
    init(repository: CardPaymentRepositoryContractor) {
        self.repository = repository
    }
    
    func makeCardPayment(cardNumber: String, expiryMonth: String, expiryYear: String, cvv: String) async throws -> URL {
        try await repository.makeCardPayment(
            cardNumber: cardNumber,
            expiryMonth: expiryMonth,
            expiryYear: expiryYear,
            cvv: cvv
        )
    }
}
