//
//  Config.swift
//  CryptoCurrencyApp
//
//  Created by Abdullah Waseer on 20/12/2022.
//

import Foundation

let API_BASE_URL = "https://pro-api.coinmarketcap.com/"
let API_KEY = "ae4804ed-faa6-432d-be0c-5c8749c2e45f"

let API_VERSION = "v" + VERSION + "/"

let IMAGE_SIZE_DESC = "\(IMAGE_SIZE)x\(IMAGE_SIZE)"
let IMAGE_BASE_URL = "https://s2.coinmarketcap.com/static/img/coins/" + IMAGE_SIZE_DESC
let API_CRYPTO_CURRENCY_LIST_URL = API_BASE_URL + API_VERSION + "cryptocurrency/listings/latest"
let VERSION = "1"
let PAGE_LIMIT = 50
let IMAGE_SIZE = 64
