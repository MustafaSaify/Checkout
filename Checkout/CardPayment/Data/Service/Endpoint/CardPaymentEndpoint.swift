//
//  CardPaymentEndpoint.swift
//  Checkout
//
//  Created by Mustafa Saify on 26/10/2022.
//

import Foundation

struct CardPaymentEndpoint: Endpoint {
    
    var cardNumber: String
    var expiryMonth: String
    var expiryYear: String
    var cvv: String
    var successUrl: String = PaymentSuccessEndpoint().url?.absoluteString ?? ""
    var failureUrl: String = PaymentFailureEndpoint().url?.absoluteString ?? ""
    
    var path: String {
        "/pay"
    }

    var method: RequestMethod {
        .post
    }

    var header: [String: String]? {
        ["content-type":"application/json"]
    }
    
    var body: [String: String]? {
        [
            "number" : cardNumber,
            "expiry_month": expiryMonth,
            "expiry_year": expiryYear,
            "cvv": cvv,
            "success_url": successUrl,
            "failure_url": failureUrl
        ]
    }
}
