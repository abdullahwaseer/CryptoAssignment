//
//  CryptoCurrency.swift
//  CryptoCurrencyApp
//
//  Created by Abdullah Waseer on 20/12/2022.
//

import Foundation

struct CryptoCurrency: Decodable {
    let id: Int?
    let name: String?
    let symbol: String?
    let quote: Quote?
}

extension CryptoCurrency: CryptoCurrencyRepresentable {
    var currencyId: Int! {
        id ?? 1
    }
    
    var currencyIconBaseUrl: String! {
        IMAGE_BASE_URL
    }
    
    var currencyName: String! { name ?? "" }
    var currencySymbol: String! { symbol ?? "" }
    var currencyUSDrate: Double! { quote?.usd?.price ?? 0.0 }
    var currencyExchangePerHour: Double! { quote?.usd?.percent_change_1h ?? 0.0}
}
