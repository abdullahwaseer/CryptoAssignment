//
//  Enums.swift
//  CryptoCurrencyApp
//
//  Created by Abdullah Waseer on 20/12/2022.
//

import Foundation

enum NetworkError: Error, LocalizedError, CustomNSError {
    case badRequest
    case unAuthorized
    case forbidden
    case notFound
    case tooManyRequests
    case serverError
    case noConnection
    case timeOutError
    case unknownError
    case decodingError
    
    var errorDescription: String? {
        switch self {
        case .badRequest:
            return "NetworkBadRequest".localized
        case .unAuthorized:
            return "UnAuthorized".localized
        case .forbidden:
            return "Forbidden".localized
        case .notFound:
            return "NotFound".localized
        case .tooManyRequests:
            return "TooManyRequests".localized
        case .serverError:
            return "ServerError".localized
        case .noConnection:
            return "NoConection".localized
        case .timeOutError:
            return "TimeOutError".localized
        case .unknownError:
            return "UnknownError".localized
        case .decodingError:
            return "DecodingError".localized
        }
    }
    
    static func checkErrorCode(_ errorCode: Int) -> NetworkError {
            switch errorCode {
            case 400:
                return .badRequest
            case 401:
                return .unAuthorized
            case 403:
                return .forbidden
            case 404:
                return .notFound
            case 429:
                return .tooManyRequests
            case 500:
                return .serverError
            case -1009:
                return .noConnection
            case -1001:
                return .timeOutError
            default:
                return .unknownError
            }
        }
}

protocol OurErrorProtocol: LocalizedError {
    var title: String? { get }
    var code: Int { get }
}

struct CustomError : OurErrorProtocol {
    var title: String?
    var code: Int
    var errorDescription: String? { return _description }
    var failureReason: String? { return _description }
    
    private var _description: String
    
    init(title: String = "Error", description: String = String(), code: Int? = nil) {
        self.title = title
        self._description = description
        self.code = code ?? 0
    }
}

enum HTTPMethod: String {
    case GET
    case POST
}

enum APIParams: String {
    case start
    case limit
    case api_key = "CMC_PRO_API_KEY"
}
