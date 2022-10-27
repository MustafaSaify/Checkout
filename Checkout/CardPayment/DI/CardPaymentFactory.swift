//
//  CardPaymentFactory.swift
//  Checkout
//
//  Created by Mustafa Saify on 26/10/2022.
//

import Foundation

class CardPaymentFactory {
    
    class func setupDependencies(viewController: CardPaymentViewController) {
        let viewModel = CardPaymentViewModel(
            paymentUseCase: getCardPaymentUseCase(),
            cardNumberValidator: CardNumberValidationUseCase(),
            cardExpiryValidator: CardExpiryValidationUseCase(),
            cardCvvValidator: CardCvvValidationUseCase(),
            cardTypeUseCase: CardTypeUseCase()
        )
        viewController.viewModel = viewModel
    }
}

extension CardPaymentFactory {
    
    private class func getCardPaymentUseCase() -> CardPaymentUseCaseContractor {
        return CardPaymentUseCase(repository: getCardPaymentRepository())
    }
    
    private class func getCardPaymentRepository() -> CardPaymentRepositoryContractor {
        return CardPaymentRepository(paymentService: getCardPaymentService())
    }
    
    private class func getCardPaymentService() -> CardPaymentServiceContractor {
        return CardPaymentService()
    }
}
