//
//  APIModelRequest.swift
//  CryptoCurrencyApp
//
//  Created by Abdullah Waseer on 23/12/2022.
//

import Foundation

final class APIModelRequest {
 
    static func request(with url: URL, httpMethod: String) -> URLRequest {
        
        var request = URLRequest(url:url)
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue(API_KEY, forHTTPHeaderField: "X-CMC_PRO_API_KEY")
        
        request.httpMethod = httpMethod
        
        return request
    }
    
    static func createRequest(url: String, params: [String : Any]?, httpMethod : String) -> URLRequest {
        
        var urlComps = URLComponents(string: url)!
        urlComps.queryItems = params?.queryItems
        
        let request = request(with: urlComps.url!, httpMethod: httpMethod)
        return request
    }
}

extension Dictionary {
    
    var queryItems: [URLQueryItem] {
        var items = [URLQueryItem]()
        forEach({
            items.append(URLQueryItem(name: ($0.key as! String), value: "\($0.value)"))
        })
        
        return items
    }
}


extension URLResponse {
    //Return error if the status code is not inside 200-299 range.
    func validate() -> NetworkError? {
        let acceptableStatusCodes: Range<Int> = 200..<300
        
        let response = self as! HTTPURLResponse
    
        if !acceptableStatusCodes.contains(response.statusCode) {
            return NetworkError.checkErrorCode(response.statusCode)
        }
        
        return nil
    }
}

extension Error {
    var errorCode:Int? {
        return (self as NSError).code
    }
    
    func validate() -> NetworkError? {
        let acceptableStatusCodes: Range<Int> = 200..<300
        
        let code = self.errorCode
    
        if !acceptableStatusCodes.contains(code ?? 0) {
            return NetworkError.checkErrorCode(code ?? 0)
        }
        
        return nil
    }
}
