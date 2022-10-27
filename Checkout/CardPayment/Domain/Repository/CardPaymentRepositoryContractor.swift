//
//  PaymentRepository.swift
//  Checkout
//
//  Created by Mustafa Saify on 16/10/2022.
//

import Foundation

protocol CardPaymentRepositoryContractor {
    func makeCardPayment(cardNumber: String, expiryMonth: String, expiryYear: String, cvv: String) async throws -> URL
}
