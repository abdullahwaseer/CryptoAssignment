//
//  CryptoCurrencyRepresentable.swift
//  CryptoCurrencyApp
//
//  Created by Abdullah Waseer on 20/12/2022.
//

import Foundation

protocol CryptoCurrencyRepresentable {
    var currencyId: Int! { get }
    var currencyIconBaseUrl: String! { get }
    var currencyName: String! { get }
    var currencySymbol: String! { get }
    var currencyUSDrate: Double! { get }
    var currencyExchangePerHour: Double! { get }
}
