//
//  PaymentFailureEndpoint.swift
//  Checkout
//
//  Created by Mustafa Saify on 27/10/2022.
//

import Foundation

struct PaymentFailureEndpoint: Endpoint {
    var path: String {
        ""
    }
    
    var method: RequestMethod {
        .get
    }
    
    var header: [String : String]? {
        return nil
    }
    
    var body: [String : String]? {
        return nil
    }
    
    var host: String {
        return "failure.com"
    }
}
