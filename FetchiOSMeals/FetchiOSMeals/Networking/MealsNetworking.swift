//
//  MealsNetworking.swift
//  FetchiOSMeals
//
//  Created by user on 3/28/24.
//

import SwiftUI
import Combine

/// Methods:
/// - `fetchDesserts(completion:)`: Asynchronously fetches a list of dessert meals. The method takes a completion handler that returns a `Result` type containing either a `MealList` object on success or a `NetworkError` on failure.
/// - `fetchMealDetail(for:completion:)`: Asynchronously fetches the detailed information for a specific meal identified by its ID. The method takes a meal ID and a completion handler that returns a `Result` type containing either a `MealDetail` object on success or a `NetworkError` on failure.
///
/// The class uses a private `request(endpoint:completion:)` method to perform the actual network requests. This method is generic and works with any endpoint conforming to the `MealsEndpoint` protocol and any decodable response type, making it reusable for different types of requests.
class MealService {
    func fetchDesserts(completion: @escaping (Result<MealList, NetworkError>) -> Void) {
        request(endpoint: MealsEndpoint.getDesserts, completion: completion)
    }
    
    func fetchMealDetail(for id: String, completion: @escaping (Result<MealDetail, NetworkError>) -> Void) {
        request(endpoint: MealsEndpoint.getDessertDetail(id: id), completion: completion)
    }
    
    private func request<T: Decodable>(endpoint: MealsEndpoint, completion: @escaping (Result<T, NetworkError>) -> Void) {
        var components = URLComponents(url: endpoint.baseURL.appendingPathComponent(endpoint.path), resolvingAgainstBaseURL: true)!
        
        if let parameters = endpoint.parameters {
            components.queryItems = parameters.map { URLQueryItem(name: $0.key, value: "\($0.value)") }
        }
        
        guard let url = components.url else {
            completion(.failure(.badURL))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method.rawValue
        endpoint.headers?.forEach { request.addValue($1, forHTTPHeaderField: $0) }
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                completion(.failure(.noData))
                return
            }
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                completion(.failure(.failedFetch))
                return
            }
            do {
                let decodedResponse = try JSONDecoder().decode(T.self, from: data)
                completion(.success(decodedResponse))
            } catch {
                completion(.failure(.badData))
            }
        }.resume()
    }
}
