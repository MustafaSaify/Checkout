//
//  DefaultPaymentRepository.swift
//  Checkout
//
//  Created by Mustafa Saify on 16/10/2022.
//

import Foundation

class CardPaymentRepository: CardPaymentRepositoryContractor {
    
    private var paymentService: CardPaymentServiceContractor
    
    init(paymentService: CardPaymentServiceContractor) {
        self.paymentService = paymentService
    }
    
    func makeCardPayment(cardNumber: String, expiryMonth: String, expiryYear: String, cvv: String) async throws -> URL {
        let response = try await paymentService.pay(
            cardNumber: cardNumber,
            expiryMonth: expiryMonth,
            expiryYear: expiryYear,
            cvv: cvv
        )
        guard let url = URL(string: response.url) else {
            throw RequestError.unknown
        }
        return url
    }
}
