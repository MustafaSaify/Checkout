//
//  CardCvvValidationUseCase.swift
//  Checkout
//
//  Created by Mustafa Saify on 26/10/2022.
//

import Foundation

protocol CardCvvValidationContractor {
    func isCardCvvValid(_ cvv: String?, cardType: CardType) -> Bool
}

struct CardCvvValidationUseCase: CardCvvValidationContractor {
    func isCardCvvValid(_ cvv: String?, cardType: CardType) -> Bool {
        guard let cvv = cvv else {
            return false
        }
        return cvv.count == cardType.cvvLength
    }
}

private extension CardType {
    var cvvLength: Int {
        return 3
    }
}

