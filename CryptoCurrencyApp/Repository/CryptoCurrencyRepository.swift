//
//  CryptoCurrencyRepository.swift
//  CryptoCurrencyApp
//
//  Created by Abdullah Waseer on 20/12/2022.
//

import Foundation
import Combine

protocol CryptoCurrencyRepository {
    
    func fetch(_ pageIndex: Int) -> Future<CryptoCurrencyData,CustomError>
}
