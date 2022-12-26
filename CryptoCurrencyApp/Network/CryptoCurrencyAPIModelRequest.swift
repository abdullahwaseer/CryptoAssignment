//
//  CryptoCurrencyAPIModelRequest.swift
//  CryptoCurrencyApp
//
//  Created by Abdullah Waseer on 20/12/2022.
//

import Foundation

enum CryptoCurrencyAPIModelRequest {
    
    case getCryptoCurrencies([String: Any]?)

    var urlRequest : URLRequest {
        let touple : (path: String, parameters: [String: Any]?) = {
            switch self{
            case .getCryptoCurrencies(let params):
                return(API_Crypto_Currency_List_URL, params)
            }
        }()
                
        var urlComps = URLComponents(string: touple.path)!
        urlComps.queryItems = touple.parameters?.queryComponents
        let urlPath = urlComps.url!
        
        var urlRequest = URLRequest(url:urlPath)
                
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.addValue("application/json", forHTTPHeaderField: "Accept")
        urlRequest.addValue(API_KEY, forHTTPHeaderField: "X-CMC_PRO_API_KEY")
        
        return urlRequest
    }
}

extension Dictionary {
    
    var queryComponents : [URLQueryItem] {
        var components = [URLQueryItem]()
        forEach({
            components.append(URLQueryItem(name: ($0.key as! String), value: "\($0.value)"))
        })
        
        return components
    }
}
