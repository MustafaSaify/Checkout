//
//  Endpoint.swift
//  Checkout
//
//  Created by Mustafa Saify on 26/10/2022.
//

import Foundation

protocol Endpoint {
    var scheme: String { get }
    var host: String { get }
    var path: String { get }
    var method: RequestMethod { get }
    var header: [String: String]? { get }
    var body: [String: String]? { get }
}

extension Endpoint {
    var scheme: String {
        return "https"
    }

    var host: String {
        return "integrations-cko.herokuapp.com"
    }
    
    var url: URL? {
        var urlComponents = URLComponents()
        urlComponents.scheme = self.scheme
        urlComponents.host = self.host
        urlComponents.path = self.path
        return urlComponents.url
    }
}
