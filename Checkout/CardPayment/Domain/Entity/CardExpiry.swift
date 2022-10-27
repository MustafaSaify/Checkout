//
//  CardExpiry.swift
//  Checkout
//
//  Created by Mustafa Saify on 26/10/2022.
//

import Foundation

struct CardExpiry {
    let month: String
    let year: String

    init(month: String, year: String) {
        self.month = month
        self.year = year
    }
}

extension CardExpiry {
    init(expiry: String) {
        var components = expiry.components(separatedBy: "/")
        let month = components.removeFirst()
        let year = components.joined(separator: "")
        self.init(month: month, year: year)
    }
}

extension CardExpiry: CustomStringConvertible {
    var description: String { return "\(month)/\(year)" }
}
