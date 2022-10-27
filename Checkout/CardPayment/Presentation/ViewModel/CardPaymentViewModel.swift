//
//  CardPaymentViewModel.swift
//  Checkout
//
//  Created by Mustafa Saify on 26/10/2022.
//

import Foundation

protocol CardPaymentViewModelContractor {
    func determineCardType(cardNumber: String?)
    func payWith(cardNumber: String, expiry: String, cvv: String) async
    func validateCardDetails(cardNumber: String?, expiry: String?, cvv: String?)
    
    // Bindings
    var cardTypePublisher: Published<CardType>.Publisher { get }
    var isCardDetailsValidPublisher: Published<Bool>.Publisher { get }
    var redirectionURLPublisher: Published<URL?>.Publisher { get }
}

final class CardPaymentViewModel: CardPaymentViewModelContractor {
    
    private let paymentUseCase: CardPaymentUseCaseContractor
    private let cardNumberValidator: CardNumberValidationContractor
    private let cardExpiryValidator: CardExpiryValidationContractor
    private let cardCvvValidator: CardCvvValidationContractor
    private let cardTypeUseCase: CardTypeUseCaseContractor
    
    @Published private var cardType: CardType = .other
    var cardTypePublisher: Published<CardType>.Publisher { $cardType }
    
    @Published private var isCardDetailsValid: Bool = false
    var isCardDetailsValidPublisher: Published<Bool>.Publisher { $isCardDetailsValid }
    
    @Published private var redirectionURL: URL?
    var redirectionURLPublisher: Published<URL?>.Publisher { $redirectionURL }
    
    init(
        paymentUseCase: CardPaymentUseCaseContractor,
        cardNumberValidator: CardNumberValidationContractor,
        cardExpiryValidator: CardExpiryValidationContractor,
        cardCvvValidator: CardCvvValidationContractor,
        cardTypeUseCase: CardTypeUseCaseContractor
    ) {
        self.paymentUseCase = paymentUseCase
        self.cardNumberValidator = cardNumberValidator
        self.cardExpiryValidator = cardExpiryValidator
        self.cardCvvValidator = cardCvvValidator
        self.cardTypeUseCase = cardTypeUseCase
    }
    
    func determineCardType(cardNumber: String?) {
        cardType = cardTypeUseCase.getCardType(from: cardNumber)
    }
    
    func validateCardDetails(cardNumber: String?, expiry: String?, cvv: String?) {
        let isCardNumberValid = cardNumberValidator.isCardNumberValid(cardNumber)
        let isCardExpiryValid = cardExpiryValidator.isCardExpiryValid(expiry)
        let isCardCvvValid = cardCvvValidator.isCardCvvValid(cvv, cardType: cardType)
        isCardDetailsValid = isCardNumberValid && isCardExpiryValid && isCardCvvValid
    }
    
    func payWith(cardNumber: String, expiry: String, cvv: String) async {
        let cardExpiry = CardExpiry(expiry: expiry)
        do {
            redirectionURL = try await paymentUseCase.makeCardPayment(
                cardNumber: cardNumber,
                expiryMonth: cardExpiry.month,
                expiryYear: cardExpiry.year,
                cvv: cvv
            )
        } catch (let error) {
            print(error)
        }
    }
}
