//
//  CryptoCurrencyDataRepository.swift
//  CryptoCurrencyApp
//
//  Created by Abdullah Waseer on 20/12/2022.
//

import Foundation
import Combine

public class CryptoCurrencyDataRepository: CryptoCurrencyRepository {
    
    var cancelable = Set<AnyCancellable>()
    let networkClient: NetworkClient

    public init(client: NetworkClient) {
        self.networkClient = client
    }
    
    func fetch(_ pageNumber: Int = 1) -> Future<CryptoCurrencyData,CustomError> {
        
        return Future<CryptoCurrencyData,CustomError> { [weak self] promise in
            
            let parameters: [String:Any] =
            [APIParams.start.rawValue: pageNumber,
             APIParams.limit.rawValue: PAGE_LIMIT]
                                    
            self?.networkClient.get(from: API_CRYPTO_CURRENCY_LIST_URL, params: parameters).sink(receiveCompletion: { completion in
                if case let .failure(error) = completion {
                    switch error {
                    case _ as DecodingError:
                        let customError  = CustomError(description: "Decoding Error".localized)
                        promise(.failure(customError))
                    default:
                        let error  = CustomError(description: error.localizedDescription.localized)
                        promise(.failure(error))
                    }
                }
            },receiveValue:{
                promise(.success($0))
            })
            .store(in: &self!.cancelable)
        }
    }
}
