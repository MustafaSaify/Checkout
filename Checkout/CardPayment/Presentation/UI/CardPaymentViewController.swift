//
//  CardPaymentViewController.swift
//  Checkout
//
//  Created by Mustafa Saify on 26/10/2022.
//

import UIKit
import Combine

class CardPaymentViewController: UIViewController {
    
    var viewModel: CardPaymentViewModelContractor?
    private var cancellables: Set<AnyCancellable> = []
    
    @IBOutlet weak var cardNumberTextField: UITextField!
    @IBOutlet weak var cardTypeImageView: UIImageView!
    @IBOutlet weak var cardExpiryTextField: UITextField!
    @IBOutlet weak var cardCvvTextField: UITextField!
    @IBOutlet weak var payButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        CardPaymentFactory.setupDependencies(viewController: self)
        observeTextFieldChanges()
        bindViewModel()
    }
    
    private func observeTextFieldChanges() {
        cardNumberTextField.addTarget(self, action: #selector(CardPaymentViewController.textFieldDidChange(_:)), for: .editingChanged)
        cardExpiryTextField.addTarget(self, action: #selector(CardPaymentViewController.textFieldDidChange(_:)), for: .editingChanged)
        cardCvvTextField.addTarget(self, action: #selector(CardPaymentViewController.textFieldDidChange(_:)), for: .editingChanged)
    }
    
    private func bindViewModel() {
        
        viewModel?.cardTypePublisher
            .receive(on: RunLoop.main)
            .sink(receiveValue: { [weak self] (cardType) in
                self?.cardTypeImageView.image = cardType.image
            })
            .store(in: &cancellables)
        
        viewModel?.isCardDetailsValidPublisher
            .receive(on: RunLoop.main)
            .sink(receiveValue: { [weak self] (isCardDetailsValid) in
                self?.payButton.isEnabled = isCardDetailsValid
            })
            .store(in: &cancellables)
        
        viewModel?.redirectionURLPublisher
            .receive(on: RunLoop.main)
            .sink(receiveValue: { [weak self] (redirectionUrl) in
                if let redirectionUrl = redirectionUrl {
                    self?.openPaymentRedirectionWebView(redirectionUrl)
                }
            })
            .store(in: &cancellables)
    }
    
    @IBAction func pay() {
        Task {
            await viewModel?.payWith(
                cardNumber: cardNumberTextField.text!,
                expiry: cardExpiryTextField.text!,
                cvv: cardCvvTextField.text!
            )
        }
    }
}

extension CardPaymentViewController: UITextFieldDelegate {
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        if textField == cardNumberTextField {
            viewModel?.determineCardType(cardNumber: textField.text)
        }
        viewModel?.validateCardDetails(
            cardNumber: cardNumberTextField.text,
            expiry: cardExpiryTextField.text,
            cvv: cardCvvTextField.text
        )
    }
}

extension CardPaymentViewController {
    
    private func openPaymentRedirectionWebView(_ url: URL) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let redirectionViewController = storyboard.instantiateViewController(withIdentifier: "PaymentRedirectionWebViewController") as! PaymentRedirectionWebViewController
        let navigationController = UINavigationController(rootViewController: redirectionViewController)
        self.present(navigationController, animated: true, completion: {
            redirectionViewController.loadURL(url)
        })
    }
}
