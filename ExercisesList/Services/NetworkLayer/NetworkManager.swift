//
//  NetworkManager.swift
//  ExercisesList
//
//  Created by Polina on 03.04.2024.
//

import Foundation

protocol NetworkMangerProtocol {
    func request<Request: ExercisesRequestProtocol>(_ request: Request) async throws -> Request.Response
}

final class NetworkManager: NetworkMangerProtocol {
    func request<Request: ExercisesRequestProtocol>(_ request: Request) async throws -> Request.Response {
        guard let url = URL(string: request.url) else { throw NetworkError.invalidURL }
        var urlRequest = URLRequest(url: url)
        
        if let headers = request.headers {
            headers.forEach { urlRequest.addValue($0.value, forHTTPHeaderField: $0.key) }
        }
        
        if let parameters = request.queryItems {
            var components = URLComponents(url: url, resolvingAgainstBaseURL: true)
            components?.queryItems = parameters.map { URLQueryItem(name: $0.key, value: $0.value) }
            if let urlParameters = components?.url {
                urlRequest.url = urlParameters
            }
        }
        urlRequest.httpMethod = request.method.rawValue
        
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw NetworkError.invalidResponse}
        do {
            let questionInfo = try request.decode(data)
            return questionInfo
        } catch {
            throw NetworkError.invalidData
        }
    }
}
