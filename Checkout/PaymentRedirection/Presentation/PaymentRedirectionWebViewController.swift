//
//  PaymentRedirectionWebViewController.swift
//  Checkout
//
//  Created by Mustafa Saify on 26/10/2022.
//

import UIKit
import WebKit

class PaymentRedirectionWebViewController: UIViewController {

    @IBOutlet weak var webview: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        webview.navigationDelegate = self
    }
    
    func loadURL(_ redirectionUrl: URL) {
        webview.load(URLRequest(url: redirectionUrl))
    }
}

extension PaymentRedirectionWebViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        if navigationAction.request.url?.host == PaymentSuccessEndpoint().host {
            performSegue(withIdentifier: "PaymentSuccess", sender: nil)
            decisionHandler(.cancel)
        }
        else if navigationAction.request.url?.host == PaymentFailureEndpoint().host {
            performSegue(withIdentifier: "PaymentFailed", sender: nil)
            decisionHandler(.cancel)
        }
        else {
            decisionHandler(.allow)
        }
    }
}
