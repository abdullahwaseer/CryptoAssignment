//
//  NetworkClient.swift
//  CryptoCurrencyApp
//
//  Created by Abdullah Waseer on 22/12/2022.
//

import Foundation
import Combine

public class NetworkClient {
    
    func get<T: Decodable>(from url: String, params: [String : Any]?) -> AnyPublisher<T, Error> {
        
        let urlRequest = APIModelRequest.createRequest(url: url, params: params, httpMethod: HTTPMethod.GET.rawValue)

        return URLSession.DataTaskPublisher(request: urlRequest, session: .shared)
            .tryMap { data, response in
                guard response.validate() == nil else {
                    throw (response.validate() ?? NetworkError.unknownError)
                }
                return data
            }
            .decode(type: T.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}
