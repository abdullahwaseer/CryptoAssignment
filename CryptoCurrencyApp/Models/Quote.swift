//
//  Quote.swift
//  CryptoCurrencyApp
//
//  Created by Abdullah Waseer on 20/12/2022.
//

import Foundation

struct Quote: Decodable {
	let usd: USD?

	enum CodingKeys: String, CodingKey {
		case usd = "USD"
	}
}
