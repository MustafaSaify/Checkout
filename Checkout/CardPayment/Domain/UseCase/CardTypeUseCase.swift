//
//  CardTypeUseCase.swift
//  Checkout
//
//  Created by Mustafa Saify on 27/10/2022.
//

import Foundation

protocol CardTypeUseCaseContractor {
    func getCardType(from cardNumber: String?) -> CardType
}

struct CardTypeUseCase: CardTypeUseCaseContractor {
    func getCardType(from cardNumber: String?) -> CardType {
        guard let cardNumber = cardNumber else {
            return .other
        }
        var cardType = CardType.other
        CardType.allCases.forEach({ _cardType in
            if matchesRegex(regex: _cardType.regex, text: cardNumber) {
                cardType = _cardType
                return
            }
        })
        return cardType
    }
    
    private func matchesRegex(regex: String, text: String) -> Bool {
        do {
            let regex = try NSRegularExpression(pattern: regex, options: [.caseInsensitive])
            let nsString = text as NSString
            let match = regex.firstMatch(in: text, options: [], range: NSMakeRange(0, nsString.length))
            return (match != nil)
        } catch {
            return false
        }
    }
}

private extension CardType {
    var regex : String {
        switch self {
        case .amex:
           return "^3[47][0-9]{5,}$"
        case .visa:
           return "^4[0-9]{6,}([0-9]{3})?$"
        case .mastercard:
           return "^(5[1-5][0-9]{4}|677189)[0-9]{5,}$"
        case .diners:
           return "^3(?:0[0-5]|[68][0-9])[0-9]{4,}$"
        case .other:
           return ""
        }
    }
}
