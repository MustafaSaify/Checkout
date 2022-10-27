//
//  CardPaymentService.swift
//  Checkout
//
//  Created by Mustafa Saify on 16/10/2022.
//

import Foundation

protocol CardPaymentServiceContractor {
    func pay(cardNumber: String, expiryMonth: String, expiryYear: String, cvv: String) async throws -> CardPaymentResponse
}

final class CardPaymentService: CardPaymentServiceContractor, HTTPClient {
    func pay(cardNumber: String, expiryMonth: String, expiryYear: String, cvv: String) async throws -> CardPaymentResponse {
        let cardPaymentEndpoint = CardPaymentEndpoint(cardNumber: cardNumber, expiryMonth: expiryMonth, expiryYear: expiryYear, cvv: cvv)
        return try await sendRequest(endpoint: cardPaymentEndpoint, responseModel: CardPaymentResponse.self)
    }
}
