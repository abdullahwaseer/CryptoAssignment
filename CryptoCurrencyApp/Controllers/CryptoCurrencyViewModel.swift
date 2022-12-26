//
//  CryptoCurrencyViewModel.swift
//  CryptoCurrencyApp
//
//  Created by Abdullah Waseer on 20/12/2022.
//

import Foundation
import Combine

typealias Completion = () -> Void

class CryptoCurrencyViewModel {
 
    @Published var currencies: [CryptoCurrency]?
    @Published var errorMessage: CustomError? = nil
    
    var dataSource: [CryptoCurrencyTableViewCellViewModel] = []
    var pageIndex: Int = 1
    
    private var noMoreRecords: Bool = false
    private var isLoadingMore: Bool = false
    
    // Dependencies
    typealias Dependencies = AppDependency
    private let dependencies: Dependencies
    private var subscriptions = Set<AnyCancellable>()

    var repository: CryptoCurrencyRepository { return dependencies.cryptoCurrencyRepository }
    var loading: ActivityIndicator { return dependencies.activity }
    
    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }
    
    func fetchCryptoCurrencies() {
        loading.startAnimation()
        pageIndex = 1
        
        repository.fetch(pageIndex).receive(on: RunLoop.main).sink(receiveCompletion: {[weak self] complition in
            self?.loading.stopAnimation()
            switch complition
            {
            case .failure(let error):
                self?.errorMessage = error
            case .finished:
                print("Finished")
            }
        }, receiveValue: { [weak self] cryptoCurrencyData in
            self?.currencies = cryptoCurrencyData.currencies
            self?.prepareDataSource(with: self?.currencies ?? [])
        }).store(in: &subscriptions)
    }
    
    func fetchMoreCryptoCurrencies() {
        guard isLoadingMore == false else { return }
        
        loading.startAnimation()
        isLoadingMore = true
        pageIndex += 1
        
        repository.fetch(pageIndex).receive(on: RunLoop.main).sink(receiveCompletion: {[weak self] complition in
            self?.loading.stopAnimation()
            self?.isLoadingMore = false
            switch complition
            {
            case .failure(let error):
                self?.errorMessage = error
            case .finished:
                print("Finished")
            }
        }, receiveValue: { [weak self] cryptoCurrencyData in
            self?.currencies = cryptoCurrencyData.currencies
            self?.noMoreRecords = self?.currencies?.count == 0
            self?.appendInDataSource(with: self?.currencies ?? [])
        }).store(in: &subscriptions)
    }
    
    private func prepareDataSource(with cryptoCurrencies: [CryptoCurrency]) {
        dataSource.removeAll()
        cryptoCurrencies.forEach { result in
            let model = CryptoCurrencyTableViewCellViewModel(result)
            dataSource.append(model)
        }
    }
    
    func appendInDataSource(with cryptoCurrencies: [CryptoCurrency]) {
        var newObjects = [CryptoCurrencyTableViewCellViewModel]()
        cryptoCurrencies.forEach {
            let model = CryptoCurrencyTableViewCellViewModel($0)
            newObjects.append(model)
            dataSource.append(model)
        }
    }
}
