//
//  NetworkingError.swift
//  FetchiOSMeals
//
//  Created by user on 3/28/24.
//

import Foundation

enum NetworkError: Error {
    case noData, badData
    case failedFetch
    case badURL
}

enum APIError: Error {
    case invalidResponse
    case invalidData
}
