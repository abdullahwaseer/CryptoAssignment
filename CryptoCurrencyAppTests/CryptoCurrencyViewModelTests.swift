//
//  CryptoCurrencyViewModelTests.swift
//  CryptoCurrencyAppTests
//
//  Created by Abdullah Waseer on 21/12/2022.
//

import XCTest
import Combine

@testable import CryptoCurrencyApp
final class CryptoCurrencyViewModelTests: XCTestCase {

    override class func setUp() {
        super.setUp()
        
        URLProtocolStub.startInterceptingRequests()
    }
    
    override class func tearDown() {
        super.tearDown()
        
        URLProtocolStub.stopInterceptingRequests()
    }
    
    func test_fetchCryptoCurrenciesSuccessfully() {
        let url = URL(string: API_CRYPTO_CURRENCY_LIST_URL)!
        
        let data = "{}".data(using: .utf8)
        let response = HTTPURLResponse(url: url, statusCode: 200, httpVersion: nil, headerFields: nil)
        
        let exp = expectation(description: "Wait for response")
        exp.expectedFulfillmentCount = 2
        exp.assertForOverFulfill = false
        
        URLProtocolStub.stub(data: data, response: response, error: nil)
        URLProtocolStub.observeRequests { request in
            XCTAssertEqual("GET", request.httpMethod)
            
            /* 1 */ exp.fulfill()
        }
    
        var subscriptions = Set<AnyCancellable>()
        let viewModel = CryptoCurrencyViewModel(dependencies: AppDependency())
        
        viewModel.$errorMessage.compactMap { $0 }.sink(receiveValue: { error in
            XCTFail("EXPECTING SUCCESS REQUEST BUT RECEIVED ERROR \(error)")
            /* 2 */ exp.fulfill()
            }).store(in: &subscriptions)
        
        viewModel.$currencies.compactMap { $0 }.sink { currencies in
            XCTAssertGreaterThanOrEqual(currencies.count, 0)
            /* 2 */ exp.fulfill()
        }.store(in: &subscriptions)
        
        viewModel.fetchCryptoCurrencies()
        
        wait(for: [exp], timeout: 5.0)
    }

    func test_fetchCryptoCurrenciesButFailWithError() {
        let url = URL(string: API_CRYPTO_CURRENCY_LIST_URL)!
        
        let anError = NSError(domain: "An-Error", code: -1)
        
        let exp = expectation(description: "Wait for response")
        exp.expectedFulfillmentCount = 2
        exp.assertForOverFulfill = false
        
        URLProtocolStub.stub(data: nil, response: nil, error: anError)
        URLProtocolStub.observeRequests { request in
            XCTAssertEqual("GET", request.httpMethod)
            
            /* 1 */ exp.fulfill()
        }
    
        var subscriptions = Set<AnyCancellable>()
        let viewModel = CryptoCurrencyViewModel(dependencies: AppDependency())
        
        viewModel.$errorMessage.compactMap { $0 }.sink(receiveValue: { error in
            XCTAssertEqual(error.code, anError.code)
            /* 2 */ exp.fulfill()
            }).store(in: &subscriptions)
        
        viewModel.$currencies.compactMap { $0 }.sink { currencies in
            XCTFail("EXPECTING FAIL REQUEST BUT RECEIVED RESPONSE")
            /* 2 */ exp.fulfill()
        }.store(in: &subscriptions)
        
        viewModel.fetchCryptoCurrencies()
        
        wait(for: [exp], timeout: 5.0)
    }
}
