//
//  ExercisesRequestProtocol.swift
//  ExercisesList
//
//  Created by Polina on 03.04.2024.
//

import Foundation

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case patch = "PATCH"
    case delete = "DELETE"
}

enum Param{
    case name
    case typeExercises
    case typeMuscle
    case difficultyType
}

protocol ExercisesRequestProtocol {
    associatedtype Response

    var url: String { get }
    var method: HTTPMethod { get }
    var headers: [String : String]? { get }
    var param: Param { get }
    var queryItems: [String : String]? { get }
    
    func decode(_ data: Data) throws -> Response
}

extension ExercisesRequestProtocol where Response: Decodable {
    func decode(_ data: Data) throws -> Response {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return try decoder.decode(Response.self, from: data)
    }
}
