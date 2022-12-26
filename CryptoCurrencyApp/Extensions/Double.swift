//
//  Double.swift
//  CryptoCurrencyApp
//
//  Created by Abdullah Waseer on 23/12/2022.
//

import Foundation

extension Double {
    
    func formatNumberWithCurrency(currency: String) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.maximumFractionDigits = 2
        formatter.minimumFractionDigits = 2
        formatter.currencySymbol = currency
        formatter.locale = Locale(identifier: "en_US")

        let formattedAmount = formatter.string(from: self as NSNumber)!
        
        return formattedAmount
    }
    
    func formatNumberWithSuffix(suffix: String) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 2
        formatter.minimumFractionDigits = 2
        formatter.positiveSuffix = suffix
        formatter.negativeSuffix = suffix
        formatter.locale = Locale(identifier: "en_US")

        let formattedAmount = formatter.string(from: self as NSNumber)!
        
        return formattedAmount
    }
}
