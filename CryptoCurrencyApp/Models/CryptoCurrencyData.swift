//
//  CryptoCurrencyData.swift
//  CryptoCurrencyApp
//
//  Created by Abdullah Waseer on 20/12/2022.
//

import Foundation

struct CryptoCurrencyData: Decodable {
    let currencies: [CryptoCurrency]?
    let status: ResponseStatus?

    enum CodingKeys: String, CodingKey {
        case currencies = "data"
        case status = "status"
    }
}
