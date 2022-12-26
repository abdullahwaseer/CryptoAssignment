//
//  ResponseStatus.swift
//  CryptoCurrencyApp
//
//  Created by Abdullah Waseer on 20/12/2022.
//

import Foundation

struct ResponseStatus: Decodable {
	let timestamp: String?
	let error_code: Int?
	let error_message: String?
	let elapsed: Int?
	let credit_count: Int?
	let notice: String?
	let total_count: Int?
}
