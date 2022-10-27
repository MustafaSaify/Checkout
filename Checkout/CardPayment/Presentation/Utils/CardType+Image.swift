//
//  CardType+Image.swift
//  Checkout
//
//  Created by Mustafa Saify on 27/10/2022.
//

import Foundation
import UIKit

extension CardType {
    var image: UIImage? {
        switch self {
        case .visa:
            return UIImage(named: "ic-card-visa")
        case .mastercard:
            return UIImage(named: "ic-card-mastercard")
        case .amex:
            return UIImage(named: "ic-card-amex")
        case .diners:
            return UIImage(named: "ic-card-dinners")
        case .other:
            return nil
        }
    }
}
