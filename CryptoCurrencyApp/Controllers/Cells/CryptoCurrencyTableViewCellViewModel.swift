//
//  CryptoCurrencyTableViewCellViewModel.swift
//  CryptoCurrencyApp
//
//  Created by Abdullah Waseer on 20/12/2022.
//

import Foundation


class CryptoCurrencyTableViewCellViewModel {
    
    // MARK: - Properties
    var model: CryptoCurrencyRepresentable!
    
    var currencyName: String{ model.currencyName ?? ""}
    var currencySymbol: String{ model.currencySymbol ?? ""}
    var currencyUSDrate: String { "\((model.currencyUSDrate ?? 1.0).formatNumberWithCurrency(currency:"$"))"}
    var currencyExchangePerHour: String { "\((model.currencyExchangePerHour ?? 1.0).formatNumberWithSuffix(suffix:"%"))" }
    var currencyImageUrl: String { model.currencyIconBaseUrl + "/\(model.currencyId ?? 1).png" }
    
    init(_ model: CryptoCurrencyRepresentable) {
        self.model = model
    }
}

extension CryptoCurrencyTableViewCellViewModel: Hashable {
    
    static func == (lhs: CryptoCurrencyTableViewCellViewModel, rhs: CryptoCurrencyTableViewCellViewModel) -> Bool {
        return lhs.model.currencyId == rhs.model.currencyId
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(model.currencyId)
    }
}
