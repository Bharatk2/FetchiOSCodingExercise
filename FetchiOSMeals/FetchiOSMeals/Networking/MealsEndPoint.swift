//
//  MealsEndPoint.swift
//  FetchiOSMeals
//
//  Created by user on 3/28/24.
//

import Foundation

protocol APIEndpoint {
    var baseURL: URL { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var headers: [String: String]? { get }
    var parameters: [String: Any]? { get }
}

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case patch = "PATCH"
    case delete = "DELETE"
}

enum MealsEndpoint: APIEndpoint {
    case getDesserts
    case getDessertDetail(id: String)
    
    var baseURL: URL {
        return URL(string: "https://themealdb.com/api/json/v1/1")!
    }
    
    var path: String {
        switch self {
        case .getDesserts:
            return "/filter.php"
        case .getDessertDetail:
            return "/lookup.php"
        }
    }
    
    var method: HTTPMethod {
        return .get
    }
    
    var headers: [String: String]? {
        return nil
    }
    
    var parameters: [String: Any]? {
        switch self {
        case .getDesserts:
            return ["c": "Dessert"]
        case .getDessertDetail(let id):
            return ["i": id]
        }
    }
}
