//
//  AppDependency.swift
//  CryptoCurrencyApp
//
//  Created by Abdullah Waseer on 20/12/2022.
//

import UIKit

protocol HasActivityIndicator {
    var activity: ActivityIndicator { get }
}

protocol HasCryptoCurrencyRepository {
    var cryptoCurrencyRepository: CryptoCurrencyRepository { get }
}

class AppDependency: HasCryptoCurrencyRepository {
 
    lazy var activity: ActivityIndicator = ActivityIndicator()
    
    lazy var cryptoCurrencyRepository: CryptoCurrencyRepository = {
        return CryptoCurrencyDataRepository(client: client)
    }()
}

extension AppDependency {
    
    private var client: NetworkClient {
        return NetworkClient()
    }
}
